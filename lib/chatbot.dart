import 'package:flutter/material.dart';
import 'package:flutter_login/home_screen.dart';
import 'package:flutter_login/seller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  _ChatbotState createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Assistant',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          elevation: 1,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        cardColor: Colors.grey[100],
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            elevation: WidgetStateProperty.all(5),
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          elevation: 1,
          backgroundColor: Colors.black,
        ),
        cardColor: Colors.grey[850],
      ),
      themeMode: _themeMode,
      home: ChatScreen(toggleTheme: _toggleTheme),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final Function(ThemeMode) toggleTheme;

  const ChatScreen({super.key, required this.toggleTheme});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final ChatGPTService _chatGPTService = ChatGPTService();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
    _addWelcomeMessage();
  }

  void _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _loadMessages();
  }

  void _loadMessages() {
    List<String>? savedMessages = _prefs.getStringList('chat_messages');
    if (savedMessages != null) {
      setState(() {
        _messages.addAll(savedMessages.map((message) {
          Map<String, dynamic> messageMap = json.decode(message);
          return ChatMessage(
            text: messageMap['text'],
            isUser: messageMap['isUser'],
          );
        }));
      });
    }
  }

  void _saveMessages() {
    List<String> messagesToSave = _messages.map((message) {
      return json.encode({
        'text': message.text,
        'isUser': message.isUser,
      });
    }).toList();
    _prefs.setStringList('chat_messages', messagesToSave);
  }

  void _addWelcomeMessage() {
    setState(() {
      _messages.add(const ChatMessage(
        text: "Welcome! How can I assist you today?",
        isUser: false,
      ));
    });
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = ChatMessage(
      text: text,
      isUser: true,
    );
    setState(() {
      _messages.insert(0, message);
      _isLoading = true;
    });
    _saveMessages();
    _getChatGPTResponse(text);
  }

  void _getChatGPTResponse(String text) async {
    try {
      String response = await _chatGPTService.sendMessage(text);
      ChatMessage botMessage = ChatMessage(
        text: response,
        isUser: false,
      );
      setState(() {
        _messages.insert(0, botMessage);
        _isLoading = false;
      });
      _saveMessages();
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
        _messages.insert(
            0,
            const ChatMessage(
              text: "Sorry, I encountered an error. Please try again later.",
              isUser: false,
            ));
      });
      _saveMessages();
      _showErrorDialog(e.toString());
    }
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Assistant'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HomePage()), // ** Navigate back to home.dart  **
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Theme.of(context).brightness == Brightness.light
                ? Icons.dark_mode
                : Icons.light_mode),
            onPressed: () {
              widget.toggleTheme(
                Theme.of(context).brightness == Brightness.light
                    ? ThemeMode.dark
                    : ThemeMode.light,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                _messages.clear();
                _addWelcomeMessage();
              });
              _saveMessages();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          if (_isLoading) const LinearProgressIndicator(),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                )
              ],
            ),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _isLoading ? null : _handleSubmitted,
                decoration: InputDecoration(
                  hintText: "Type your message...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.light
                      ? Colors.grey[200]
                      : Colors.grey[800],
                ),
                enabled: !_isLoading,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: _isLoading
                    ? null
                    : () => _handleSubmitted(_textController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key, required this.text, required this.isUser});

  final String text;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor:
                  isUser ? Colors.blue : Theme.of(context).primaryColor,
              child: Text(isUser ? "You" : "AI"),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(isUser ? "You" : "AI Assistant",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isUser ? Colors.blue : Colors.blueAccent,
                        )),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: MarkdownBody(data: text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatGPTService {
  final String rapidApiHost = 'chatgpt-42.p.rapidapi.com';
  final String rapidApiKey =
      '2118c04483msh9d44e9702ece1dfp15d1e0jsnb5fc9fed81fc';

  Future<String> sendMessage(String message) async {
    final url = Uri.parse('https://$rapidApiHost/conversationgpt4-2');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'x-rapidapi-host': rapidApiHost,
          'x-rapidapi-key': rapidApiKey,
        },
        body: jsonEncode({
          "messages": [
            {"role": "user", "content": message}
          ],
          "system_prompt": "",
          "temperature": 0.9,
          "top_k": 5,
          "top_p": 0.9,
          "max_tokens": 256,
          "web_access": false,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == true && data['result'] != null) {
          return data['result'];
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception(
            'Failed to fetch response: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      throw Exception('Error communicating with the server: $e');
    }
  }
}
