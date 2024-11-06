import 'package:flutter/material.dart';
import 'package:pennyflow/Screens/SetBudget/services&models%5Bmonthly%5D.dart';
import 'package:provider/provider.dart';
import 'package:pennyflow/MobileAppBar.dart';
import 'package:pennyflow/values/values.dart';
import '../../DIalogBtns/SetBudgetBtn.dart';
import 'Set Expense.dart';

class MobileSB extends StatelessWidget {
  final int currentIndex;
  final Function(int) onIndexChanged;

  const MobileSB({
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
              onIndexChanged: onIndexChanged
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    Text(
                      StringConst.BUDGET,
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    MobileBudgetSection(),
                    SizedBox(height: 40),
                    SetExpenseWidget(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MobileBudgetSection extends StatelessWidget {
  const MobileBudgetSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BudgetProvider>(
      builder: (context, budgetProvider, child) {
        final budgetData = budgetProvider.budgetData;
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => _showSetBudgetDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Set', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            SizedBox(height: 10,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildBudgetCard(
                    icon: Icons.account_balance_wallet,
                    color: Colors.blue,
                    title: 'Monthly Income',
                    amount: budgetData.monthlyIncome,
                  ),
                  SizedBox(width: 16),
                  _buildBudgetCard(
                    icon: Icons.shopping_cart,
                    color: Colors.green,
                    title: 'Monthly Budget',
                    amount: budgetData.monthlyBudget,
                  ),
                  SizedBox(width: 16),
                  _buildBudgetCard(
                    icon: Icons.savings,
                    color: Colors.purple,
                    title: 'Monthly Savings',
                    amount: budgetData.monthlySavings,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Divider(height: 1, thickness: 1, color: Colors.grey[300]),
            SizedBox(height: 24),
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
            SizedBox(height: 8),
            LinearProgressIndicator(
              value: budgetProvider.weeklyProgress,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                budgetProvider.weeklyProgress > 0.8 ? Colors.red : AppColors.primaryColor,
              ),
              minHeight: 8,
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
        );
      },
    );
  }

  Widget _buildBudgetCard({
    required IconData icon,
    required Color color,
    required String title,
    required double amount,
  }) {
    return Container(
      width: 280,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 32),
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
              fontSize: 20,
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