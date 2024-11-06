import 'package:flutter/material.dart';
import 'package:pennyflow/Screens/Dashboard/widgets/recent_expenses.dart';
import 'package:pennyflow/Nav_bar.dart';
import 'package:pennyflow/header.dart';
import 'package:pennyflow/Screens/Dashboard/widgets/BarChart.dart';
import 'package:pennyflow/values/values.dart';

import '../../ResponsiveWrapper.dart';
import 'MobileDashboard.dart';
import 'widgets/MonthlyOverviewCards.dart';


class Dashboard_SC extends StatefulWidget {
  static const String DashboardPageRoute = StringConst.DASHBOARD_PAGE;
  final Function(int) onIndexChanged;
  final int currentIndex;

  Dashboard_SC({
    Key? key,
    required this.onIndexChanged,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<Dashboard_SC> createState() => _DashboardSCState();
}

class _DashboardSCState extends State<Dashboard_SC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardbg,
      body: ResponsiveWrapper(
        mobile: MobileDashboard(
          currentIndex: widget.currentIndex,
          onIndexChanged: widget.onIndexChanged,
        ),
        tablet: _buildTabletLayout(),
        desktop: _buildDesktopLayout(),
      ),
    );
  }
  Widget _buildTabletLayout() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          NavBar(
            onIndexChanged: widget.onIndexChanged,
            currentIndex: widget.currentIndex,
          ),
          Container(
            width: 4,
            decoration: BoxDecoration(
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: VerticalDivider(
                thickness: 1,
                width: 1,
                color: Colors.grey.shade300,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                PageHeader(title: StringConst.DASHBOARD),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            StringConst.GOOD_MORNING_USER,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 24),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Barchartwidget(),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                flex: 1,
                                child: _buildMonthlyOverview(),
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          RecentExpenses(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildDesktopLayout(){
    return Scaffold(
      backgroundColor: AppColors.cardbg,
      body: Row(
        children: <Widget>[
          NavBar(
            onIndexChanged: widget.onIndexChanged,
            currentIndex: widget.currentIndex,
          ),
          Container(
            width: 4,
            decoration: BoxDecoration(
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: VerticalDivider(
                thickness: 1,
                width: 1,
                color: Colors.grey.shade300,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                PageHeader(title: StringConst.DASHBOARD),
                Divider(height: 1, thickness: 1, color: Colors.grey[300]),
                Expanded(
                  child: Container(
                    color: AppColors.white,
                    padding: EdgeInsets.all(0),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                            Text(
                              StringConst.GOOD_MORNING_USER,
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        StringConst.sub_head_dashboard,
                                        style: TextStyle(color: AppColors.subheading),
                                      ),
                                      SizedBox(height: 16),
                                      _buildExpenseOverview(),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Monthly Overview',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
                                      ),
                                      SizedBox(height: 16),
                                      _buildMonthlyOverview(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 24),
                            _buildRecentExpenses(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseOverview() {
    return Barchartwidget();
  }

  Widget _buildMonthlyOverview() {
    return Column(
      children: [
        OverviewCard(
          icon: Icons.account_balance_wallet,
          iconColor: Colors.green,
          title: 'Monthly Income',
          amount: '\$200.000.00',
          description: 'Total income for this month is 200,000.00. Try to save more than you spend this month.',
          percent: '100 Percent',
        ),
        SizedBox(height: 16),
        OverviewCard(
          icon: Icons.assignment,
          iconColor: Colors.redAccent,
          title: 'Monthly Budget',
          amount: '\$180.000.00',
          description: 'You have spent \$80,000.00 of the amount you budgeted for this month.',
          percent: '80 percent',
        ),
        SizedBox(height: 16),
        OverviewCard(
          icon: Icons.savings,
          iconColor: Colors.blue,
          title: 'Monthly Savings',
          amount: '\$20.000.00',
          description: 'You saved \$20.000.00 from your total income of \$200,000.00 this month, good job!',
          percent: '20 percent',
        ),
      ],
    );
  }

  Widget _buildRecentExpenses() {
    return RecentExpenses();
  }
}



