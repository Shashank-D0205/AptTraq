import 'package:flutter/material.dart';
import 'package:pennyflow/DIalogBtns/AddCategory.dart';

import '../../DIalogBtns/Addbudget.dart';
import '../../values/values.dart';

class SetExpenseWidget extends StatefulWidget {
  @override
  State<SetExpenseWidget> createState() => _SetExpenseWidgetState();
}

class _SetExpenseWidgetState extends State<SetExpenseWidget> {
  List<Map<String, dynamic>> expenseItems = [
    {'icon': Icons.school_outlined, 'title': 'Education', 'amount': '\$10,000.00'},
    {'icon': Icons.movie_outlined, 'title': 'Entertainment', 'amount': '\$10,000.00'},
    {'icon': Icons.family_restroom_outlined, 'title': 'Family', 'amount': '\$10,000.00'},
    {'icon': Icons.fastfood_outlined, 'title': 'Food', 'amount': '\$10,000.00'},
    {'icon': Icons.local_gas_station_outlined, 'title': 'Gas', 'amount': '\$10,000.00'},
    {'icon': Icons.shopping_cart_outlined, 'title': 'Groceries', 'amount': '\$10,000.00'},
    {'icon': Icons.medical_services_outlined, 'title': 'Medication', 'amount': '\$10,000.00'},
    {'icon': Icons.beach_access_outlined, 'title': 'Outing', 'amount': '\$10,000.00'},
    {'icon': Icons.shopping_bag_outlined, 'title': 'Shopping', 'amount': '\$10,000.00'},
    {'icon': Icons.spa_outlined, 'title': 'Skincare', 'amount': '\$10,000.00'},
    {'icon': Icons.car_rental_outlined, 'title': 'Transport', 'amount': '\$10,000.00'},
    {'icon': Icons.house_outlined, 'title': 'Housing', 'amount': '\$10,000.00'},
    {'icon': Icons.sports_esports_outlined, 'title': 'Gaming', 'amount': '\$10,000.00'},
    {'icon': Icons.fitness_center_outlined, 'title': 'Fitness', 'amount': '\$10,000.00'},
    {'icon': Icons.book_outlined, 'title': 'Books', 'amount': '\$10,000.00'},
  ];

  void _addNewCategory(String categoryName) {
    setState(() {
      expenseItems.add({
        'icon': Icons.category_outlined,
        'title': categoryName,
        'amount': '\$10,000.00',
      });
    });
  }

  Future<void> _showBudgetDialog(int index) async {
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AddBudgetDialog(
          categoryTitle: expenseItems[index]['title'],
        );
      },
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        double amount = double.tryParse(result) ?? 0.0;
        expenseItems[index]['amount'] = '\$${amount.toStringAsFixed(2)}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Set Expense',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () async {
                  final newCategory = await showDialog<String>(
                    context: context,
                    builder: (context) => const AddCategoryDialog(),
                  );

                  if (newCategory != null && newCategory.isNotEmpty) {
                    _addNewCategory(newCategory);
                  }
                },
                child: Text('+ New Category', style: TextStyle(color: AppColors.primaryColor)),
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text('Tap on the icon to set budget amount.',
              style: TextStyle(color: Colors.grey)),
          SizedBox(height: 30),
          LayoutBuilder(
            builder: (context, constraints) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: expenseItems.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _buildExpenseItem(
                    expenseItems[index]['icon'],
                    expenseItems[index]['title'],
                    expenseItems[index]['amount'],
                        () => _showBudgetDialog(index),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseItem(IconData icon, String title, String amount, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade100.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Icon(icon, size: 24, color: AppColors.primaryColor),
          ),
          SizedBox(height: 8),
          Text(title,
              style: TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis),
          SizedBox(height: 4),
          Text(amount,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}