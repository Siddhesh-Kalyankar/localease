import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalyticalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics Dashboard'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Overview',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOverviewCard('Total Sales', '\$5000'),
                _buildOverviewCard('Total Profit', '\$1500'),
                _buildOverviewCard('Total Loss', '\$500'),
              ],
            ),
            const SizedBox(height: 32),

            // Profit and Loss Pie Chart Section
            const Text(
              'Profit and Loss Overview',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildProfitLossChart(),
            const SizedBox(height: 32),

            // Best Selling Products Section
            const Text(
              'Best Selling Products',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildBestSellingProductsChart(),
            const SizedBox(height: 32),

            // Weekly Sales Trend Section
            const Text(
              'Weekly Sales Trend',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildWeeklySalesTrendChart(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value) {
    return Card(
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfitLossChart() {
    // Sample data for profit and loss
    final profit = 1500;
    final loss = 500;

    return SizedBox(
      height: 250,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              value: profit.toDouble(),
              color: Colors.green,
              title: 'Profit\n\$${profit}',
              titleStyle: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            PieChartSectionData(
              value: loss.toDouble(),
              color: Colors.red,
              title: 'Loss\n\$${loss}',
              titleStyle: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
          borderData: FlBorderData(show: false),
          centerSpaceRadius: 40,
        ),
      ),
    );
  }

  Widget _buildBestSellingProductsChart() {
    // Sample data for best-selling products
    final data = [
      ProductSales('Product A', 50),
      ProductSales('Product B', 30),
      ProductSales('Product C', 20),
    ];

    return SizedBox(
      height: 250,
      child: BarChart(
        BarChartData(
          barGroups: data
              .asMap()
              .entries
              .map((entry) => BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(
                        toY: entry.value.sales.toDouble(),
                        color: Colors.blue,
                      ),
                    ],
                  ))
              .toList(),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 38,
                getTitlesWidget: (value, meta) {
                  return Text(
                    data[value.toInt()].productName,
                    style: const TextStyle(fontSize: 12),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: true),
        ),
      ),
    );
  }

  Widget _buildWeeklySalesTrendChart() {
    // Sample data for weekly sales
    final data = [
      WeeklySales('Week 1', 1000),
      WeeklySales('Week 2', 1500),
      WeeklySales('Week 3', 1200),
      WeeklySales('Week 4', 1800),
    ];

    return SizedBox(
      height: 250,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 38,
                getTitlesWidget: (value, meta) {
                  return Text(
                    data[value.toInt()].week,
                    style: const TextStyle(fontSize: 12),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: true),
          minX: 0,
          maxX: data.length.toDouble() - 1,
          minY: 0,
          maxY: 2000,
          lineBarsData: [
            LineChartBarData(
              spots: data
                  .asMap()
                  .entries
                  .map((entry) => FlSpot(
                      entry.key.toDouble(), entry.value.sales.toDouble()))
                  .toList(),
              isCurved: true,
              color: Colors.red,
              dotData: FlDotData(show: true),
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}

// Model for best-selling products
class ProductSales {
  final String productName;
  final int sales;

  ProductSales(this.productName, this.sales);
}

// Model for weekly sales
class WeeklySales {
  final String week;
  final int sales;

  WeeklySales(this.week, this.sales);
}
