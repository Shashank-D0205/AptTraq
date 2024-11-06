import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pennyflow/values/values.dart';

class Barchartwidget extends StatelessWidget {
  const Barchartwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Expense Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(color: AppColors.subheading),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Text('Monthly', style: TextStyle(fontSize: 12)),
                          Icon(Icons.arrow_drop_down, size: 16),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 40),
            AspectRatio(
              aspectRatio: 2,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 900000,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const style = TextStyle(fontSize: 10);
                          String text;
                          switch (value.toInt()) {
                            case 0: text = 'Jan'; break;
                            case 1: text = 'Feb'; break;
                            case 2: text = 'Mar'; break;
                            case 3: text = 'Apr'; break;
                            case 4: text = 'May'; break;
                            case 5: text = 'Jun'; break;
                            case 6: text = 'Jul'; break;
                            case 7: text = 'Aug'; break;
                            case 8: text = 'Sept'; break;
                            case 9: text = 'Oct'; break;
                            case 10: text = 'Nov'; break;
                            case 11: text = 'Dec'; break;
                            default: text = '';
                          }
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(text, style: style),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                            showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta){
                              const style = TextStyle(fontSize: 10);
                              if (value % 100000 == 0) {
                                return SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  child: Text('${value ~/ 1000}k', style: style),
                                );
                              }
                              return Container();
                            }
                        )
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false, // Disable vertical lines
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 150000, color: AppColors.primaryColor,width: 20,borderRadius: BorderRadius.circular(5))]),
                    BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 180000, color: AppColors.primaryColor,width: 20,borderRadius: BorderRadius.circular(5))]),
                    BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 120000, color: AppColors.primaryColor,width: 20,borderRadius: BorderRadius.circular(5))]),
                    BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 170000, color: AppColors.primaryColor,width: 20,borderRadius: BorderRadius.circular(5))]),
                    BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 160000, color: AppColors.primaryColor,width: 20,borderRadius: BorderRadius.circular(5))]),
                    BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 170000, color: AppColors.primaryColor,width: 20,borderRadius: BorderRadius.circular(5))]),
                    BarChartGroupData(x: 6, barRods: [BarChartRodData(toY: 80000, color:AppColors.primaryColor,width: 20,borderRadius: BorderRadius.circular(5))]),
                    BarChartGroupData(x: 7, barRods: [BarChartRodData(toY: 0, color: AppColors.primaryColor,width: 20,borderRadius: BorderRadius.circular(5))]),
                    BarChartGroupData(x: 8, barRods: [BarChartRodData(toY: 0, color: AppColors.primaryColor,width: 20,borderRadius: BorderRadius.circular(5))]),
                    BarChartGroupData(x: 9, barRods: [BarChartRodData(toY: 0, color: AppColors.primaryColor,width: 20,borderRadius: BorderRadius.circular(5))]),
                    BarChartGroupData(x: 10, barRods: [BarChartRodData(toY: 0, color: AppColors.primaryColor,width: 20,borderRadius: BorderRadius.circular(5))]),
                    BarChartGroupData(x: 11, barRods: [BarChartRodData(toY: 0, color: AppColors.primaryColor,width: 20,borderRadius: BorderRadius.circular(5))]),


                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class BarchartMobile extends StatefulWidget {
  const BarchartMobile({Key? key}) : super(key: key);

  @override
  State<BarchartMobile> createState() => _BarchartMobileState();
}

class _BarchartMobileState extends State<BarchartMobile> {
  bool _isMonthly = true;
  bool _showDropdown = false;
  void _toggleView() {
    setState(() {
      _isMonthly = !_isMonthly;
      _showDropdown = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Expense Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IntrinsicHeight(
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _toggleView();
                          // setState(() {
                          //   _showDropdown = !_showDropdown;
                          // });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            border: Border.all(color: AppColors.subheading),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              Text(_isMonthly ? 'Monthly' : 'Weekly', style: TextStyle(fontSize: 12,color: AppColors.subheading)),
                              SizedBox(width: 4),
                              Icon(Icons.arrow_drop_down, size: 16),
                            ],
                          ),
                        ),
                      ),
                      if(_showDropdown)
                        Positioned(
                          top: 40,
                          right: 0,
                          width: 100,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: AppColors.subheading!),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: GestureDetector(
                              onTap: _toggleView,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                child: Text(
                                  _isMonthly ? 'Weekly' : 'Monthly',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            AspectRatio(
              aspectRatio: 0.8, // Adjusted for better fit on mobile screens
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 900000,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const style = TextStyle(fontSize: 8); // Smaller font for mobile
                          String text;
                          switch (value.toInt()) {
                            case 0: text = 'Jan'; break;
                            case 1: text = 'Feb'; break;
                            case 2: text = 'Mar'; break;
                            case 3: text = 'Apr'; break;
                            case 4: text = 'May'; break;
                            case 5: text = 'Jun'; break;
                            case 6: text = 'Jul'; break;
                            default: text = '';
                          }
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(text, style: style),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: (value, meta){
                              const style = TextStyle(fontSize: 8); // Smaller font for mobile
                              if (value % 100000 == 0) { // Adjusted scale for mobile
                                return SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  child: Text('${value ~/ 1000}k', style: style),
                                );
                              }
                              return Container();
                            }
                        )
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 150000,width: 20, color: AppColors.primaryColor,borderRadius: BorderRadius.circular(5))]),
                    BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 180000,width: 20, color: AppColors.primaryColor,borderRadius: BorderRadius.circular(5))]),
                    BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 120000,width: 20, color: AppColors.primaryColor,borderRadius: BorderRadius.circular(5))]),
                    BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 170000,width: 20, color: AppColors.primaryColor,borderRadius: BorderRadius.circular(5))]),
                    BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 160000,width: 20, color: AppColors.primaryColor,borderRadius: BorderRadius.circular(5))]),
                    BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 170000,width: 20, color: AppColors.primaryColor,borderRadius: BorderRadius.circular(5))]),
                    BarChartGroupData(x: 6, barRods: [BarChartRodData(toY: 80000,width: 20, color: AppColors.primaryColor,borderRadius: BorderRadius.circular(5))]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
