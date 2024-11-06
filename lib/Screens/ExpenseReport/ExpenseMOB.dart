import 'package:flutter/material.dart';
import 'package:pennyflow/DIalogBtns/Addexpense.dart';
import 'package:pennyflow/MobileAppBar.dart';
import 'package:pennyflow/values/values.dart';
import 'package:intl/intl.dart';
import 'expensetrackingfucntionality.dart';

class Expensemob extends StatelessWidget {
  final int currentIndex;
  final Function(int) onIndexChanged;

  const Expensemob({
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
            child: Column(
              children: [
                MOBEXPENSECONTENT(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MOBEXPENSECONTENT extends StatefulWidget {
  const MOBEXPENSECONTENT({super.key});

  @override
  State<MOBEXPENSECONTENT> createState() => _MOBEXPENSECONTENTState();
}

class _MOBEXPENSECONTENTState extends State<MOBEXPENSECONTENT> {
  final _expenseService = ExpenseService();
  DateTime selectedDate = DateTime.now();
  final DateFormat dateFormatter = DateFormat('MMM d, yyyy');
  final currencyFormatter = NumberFormat.currency(symbol: '\$');

  @override
  void initState() {
    super.initState();
    // No need to initialize if already done in desktop
    // _expenseService.initializeData();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  IconData _getIconForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'food':
      case 'foodstuff':
        return Icons.fastfood;
      case 'utilities':
        return Icons.electric_bolt;
      case 'groceries':
        return Icons.shopping_cart;
      case 'medication':
        return Icons.medical_services;
      default:
        return Icons.receipt;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.chevron_left),
                onPressed: () {
                  setState(() {
                    selectedDate = selectedDate.subtract(Duration(days: 1));
                  });
                },
                color: Colors.grey,
              ),
              TextButton(
                onPressed: () => _selectDate(context),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: Colors.blue),
                    SizedBox(width: 8),
                    Text(
                      dateFormatter.format(selectedDate),
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.chevron_right),
                onPressed: () {
                  setState(() {
                    selectedDate = selectedDate.add(Duration(days: 1));
                  });
                },
                color: Colors.grey,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Expense Details',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Expense>>(
              stream: _expenseService.expenseStream,
              initialData: _expenseService.expenses,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final filteredExpenses = _expenseService.getExpensesByDate(selectedDate);

                if (filteredExpenses.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.receipt_long,
                            size: 48,
                            color: Colors.grey[400]
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No expenses for this date',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filteredExpenses.length,
                  itemBuilder: (context, index) {
                    final expense = filteredExpenses[index];
                    return ExpenseCard(
                      expense: ExpenseItem(
                        icon: _getIconForCategory(expense.category),
                        iconColor: Colors.blue,
                        title: expense.category,
                        amount: expense.amount,
                        paymentChannel: expense.paymentMode,
                        time: DateFormat('HH:mm').format(expense.dateTime),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () async {
                  final result = await showDialog(
                    context: context,
                    builder: (context) => AddExpenseDialog(),
                  );

                  if (result != null) {
                    // The dialog will return a complete Expense object
                    // The mobile UI will just show a subset of the fields
                    _expenseService.addExpense(result);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Download',
                      style: TextStyle(color: Colors.blue),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.cloud_upload_outlined, color: Colors.blue),
                  ],
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.blue, width: 1),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExpenseItem {
  final IconData icon;
  final Color iconColor;
  final String title;
  final double amount;
  final String paymentChannel;
  final String time;

  ExpenseItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.amount,
    required this.paymentChannel,
    required this.time,
  });
}

class ExpenseCard extends StatelessWidget {
  final ExpenseItem expense;
  final currencyFormatter = NumberFormat.currency(symbol: '\$');

  ExpenseCard({
    Key? key,
    required this.expense,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: expense.iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              expense.icon,
              color: expense.iconColor,
              size: 20,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  expense.paymentChannel,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                currencyFormatter.format(expense.amount),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Text(
                expense.time,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}