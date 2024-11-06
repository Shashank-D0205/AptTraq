import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pennyflow/Screens/Dashboard/widgets/recent_expenses.dart';
import 'package:pennyflow/values/values.dart';
import '../../MobileAppBar.dart';
import 'widgets/BarChart.dart';

import 'Dashboard Screen.dart';
import 'widgets/MonthlyOverviewCards.dart';


class MobileDashboard extends StatelessWidget {
  final int currentIndex;
  final Function(int) onIndexChanged;

  const MobileDashboard({
    Key? key,
    required this.currentIndex,
    required this.onIndexChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
        children: [
          MobileAppBar(
            currentIndex: currentIndex,
            onIndexChanged: onIndexChanged,),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 1.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9, // Set width to 80% of screen width
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      Text(
                        StringConst.GOOD_MORNING_USER,
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 2),
                      Text(
                        StringConst.sub_head_dash_mobile1,
                        style: TextStyle(color: AppColors.subheading,fontSize: 15),
                      ),
                      Text(
                        StringConst.sub_head_dash_mobile2,
                        style: TextStyle(color: AppColors.subheading,fontSize: 15),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        child: BarchartMobile(),
                      ),
                      SizedBox(height: 30,),
                      Text(
                        'Monthly Overview',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24, color: Colors.black),
                      ),
                      SizedBox(height: 20,),
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
                      SizedBox(height: 20,),
                      RecentExpenses(),
                      // MobileRecentTransactions(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}



