import 'package:flutter/material.dart';
import 'package:pennyflow/Screens/SetBudget/services&models%5Bmonthly%5D.dart';
import 'package:provider/provider.dart';
import 'package:pennyflow/values/values.dart';

import '../../DIalogBtns/SetBudgetBtn.dart';

class Budgetcontainer extends StatelessWidget {
  const Budgetcontainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BudgetProvider>(
      builder: (context, budgetProvider, child) {
        final budgetData = budgetProvider.budgetData;

        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => _showSetBudgetDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text('Set',style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _buildBudgetCard(
                      title: 'Monthly Income',
                      amount: budgetData.monthlyIncome,
                      icon: Icons.account_balance_wallet,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildBudgetCard(
                      title: 'Monthly Budget',
                      amount: budgetData.monthlyBudget,
                      icon: Icons.shopping_cart,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildBudgetCard(
                      title: 'Monthly Savings',
                      amount: budgetData.monthlySavings,
                      icon: Icons.savings,
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'This week\'s budget',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () => _showWeeklyBudgetDialog(context),
                    child: Text('Set'),
                  ),
                ],
              ),
              SizedBox(height: 10),
              LinearProgressIndicator(
                value: budgetProvider.weeklyProgress,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(
                  budgetProvider.weeklyProgress > 0.8 ? Colors.red : AppColors.primaryColor,
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Spent: \$${budgetData.weeklySpent.toStringAsFixed(2)}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  Text(
                    'Budget: \$${budgetData.weeklyBudget.toStringAsFixed(2)}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBudgetCard({
    required String title,
    required double amount,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          SizedBox(height: 4),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showSetBudgetDialog(BuildContext context) async {
    final result = await showDialog(
      context: context,
      builder: (context) => SetBudgetDialog(),
    );

    if (result != null && result is Map<String, double>) {
      Provider.of<BudgetProvider>(context, listen: false).updateMonthlyBudget(
        income: result['monthlyIncome']!,
        budget: result['monthlyBudget']!,
        savings: result['monthlySavings']!,
      );
    }
  }

  Future<void> _showWeeklyBudgetDialog(BuildContext context) async {
    final result = await showDialog(
      context: context,
      builder: (context) => SetWeeklyBar(),
    );

    if (result != null && result is Map<String, double>) {
      Provider.of<BudgetProvider>(context, listen: false)
          .updateWeeklyBudget(result['weeklyBudget']!);
    }
  }
}


//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey[300]!),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 3,
//             offset: Offset(0, 1),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               TextButton(
//                   onPressed: (){
//                     showDialog(context: context, builder: (context)=>SetBudgetDialog());
//                   },
//                   child: Text('Set',style: TextStyle(color: Colors.grey),
//                   )
//               )
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: BudgetItem(
//                   icon: Icons.account_balance_wallet,
//                   iconColor: Colors.green,
//                   title: 'Income',
//                   amount: '\$200,000.00',
//                   color: Colors.green,
//                   percentage: '37.6%',
//                   isIncreasing: true,
//                 ),
//               ),
//               SizedBox(width: 16),
//               Expanded(
//                 child: BudgetItem(
//                   icon: Icons.assignment,
//                   iconColor: Colors.redAccent,
//                   title: 'Budget',
//                   amount: '\$180,000.00',
//                   color: Colors.red,
//                   percentage: '37.6%',
//                   isIncreasing: false,
//                 ),
//               ),
//               SizedBox(width: 16),
//               Expanded(
//                 child: BudgetItem(
//                   icon: Icons.savings,
//                   iconColor: Colors.blue,
//                   title: 'Savings',
//                   amount: '\$20,000.00',
//                   color: Colors.blue,
//                   percentage: '37.6%',
//                   isIncreasing: false,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 40),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               TextButton(
//                   onPressed: (){
//                     showDialog(context: context, builder: (context)=>SetWeeklyBar());
//                   },
//                   child: Text('Set',style: TextStyle(color: Colors.grey),
//                   )
//               )
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('This week\'s budget'),
//               Text('\$10,000.00 of \$50,000.00'),
//             ],
//           ),
//           SizedBox(height: 8),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: Container(
//               height: 8,
//               width: double.infinity,
//               child: LinearProgressIndicator(
//                 value: 0.2,
//                 backgroundColor: Colors.grey[200],
//                 valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class BudgetItem extends StatelessWidget {
//   final IconData icon;
//   final Color iconColor;
//   final String title;
//   final String amount;
//   final Color color;
//   final String percentage;
//   final bool isIncreasing;
//
//   const BudgetItem({
//     Key? key,
//     required this.icon,
//     required this.iconColor,
//     required this.title,
//     required this.amount,
//     required this.color,
//     required this.percentage,
//     required this.isIncreasing,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           padding: EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: Colors.grey[200],
//             shape: BoxShape.circle,
//           ),
//           child: Icon(icon, color: iconColor, size: 35),
//         ),
//         SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(title, style: TextStyle(color: Colors.grey)),
//               SizedBox(height: 4),
//               Text(amount, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
//               SizedBox(height: 4),
//               Row(
//                 children: [
//                   Icon(
//                       isIncreasing ? Icons.arrow_upward : Icons.arrow_downward,
//                       color: color,
//                       size: 16
//                   ),
//                   SizedBox(width: 4),
//                   Text(percentage, style: TextStyle(color: color)),
//                   Text(' this month'),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }