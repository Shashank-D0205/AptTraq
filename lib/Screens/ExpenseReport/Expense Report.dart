import 'package:flutter/material.dart';
import 'package:pennyflow/Screens/ExpenseReport/ExpenseMOB.dart';
import 'package:pennyflow/Nav_bar.dart';
import 'package:pennyflow/ResponsiveWrapper.dart';
import 'package:pennyflow/header.dart';
import 'package:pennyflow/values/values.dart';
import 'package:intl/intl.dart';
import 'expensetrackingfucntionality.dart';

class ExpenseReport extends StatefulWidget {
  static const String expensereportPageroute = StringConst.EXPENSE_REPORT_PAGE;
  final Function(int) onIndexChanged;
  final int currentIndex;

  const ExpenseReport({
    Key? key,
    required this.onIndexChanged,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<ExpenseReport> createState() => _ExpenseReportState();
}

class _ExpenseReportState extends State<ExpenseReport> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveWrapper(
      mobile: Expensemob(
          currentIndex: widget.currentIndex,
          onIndexChanged: widget.onIndexChanged
      ),
      tablet: _buildERDesktop(),
      desktop: _buildERDesktop(),
    );
  }

  Widget _buildERDesktop() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: <Widget>[
          NavBar(
              onIndexChanged: widget.onIndexChanged,
              currentIndex: widget.currentIndex
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
                PageHeader(title: StringConst.Expense_Report),
                Divider(height: 1, thickness: 1, color: Colors.grey[300]),
                ExpenseReportContent(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ExpenseReportContent extends StatefulWidget {
  const ExpenseReportContent({Key? key}) : super(key: key);

  @override
  State<ExpenseReportContent> createState() => _ExpenseReportContentState();
}

class _ExpenseReportContentState extends State<ExpenseReportContent> {
  final _expenseService = ExpenseService();
  DateTime selectedDate = DateTime.now();
  final DateFormat dateFormatter = DateFormat('MMM d, yyyy');

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
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with date picker and export button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: 500),
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
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                Container(
                  width: 150,
                  child: TextButton(
                    onPressed: () {
                      // Implement export functionality
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Export',
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
              ],
            ),
            SizedBox(height: 24),
            // Expense table with real-time data
            Expanded(
              child: StreamBuilder<List<Expense>>(
                stream: _expenseService.expenseStream,
                initialData: _expenseService.expenses,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final filteredExpenses = _expenseService.getExpensesByDate(selectedDate);

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Expense Details',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Divider(height: 1, color: Colors.grey.shade200),
                        if (filteredExpenses.isEmpty)
                          Expanded(
                            child: Center(
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
                            ),
                          )
                        else
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SingleChildScrollView(
                                child: DataTable(
                                  columnSpacing: 120,
                                  columns: [
                                    DataColumn(
                                      label: Text('Bill Category',
                                          style: TextStyle(fontWeight: FontWeight.w500)
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text('Payment Channel',
                                          style: TextStyle(fontWeight: FontWeight.w500)
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text('Description',
                                          style: TextStyle(fontWeight: FontWeight.w500)
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text('Transaction',
                                          style: TextStyle(fontWeight: FontWeight.w500)
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text('Time',
                                          style: TextStyle(fontWeight: FontWeight.w500)
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text('Amount',
                                          style: TextStyle(fontWeight: FontWeight.w500)
                                      ),
                                    ),
                                  ],
                                  rows: filteredExpenses.map((expense) {
                                    return DataRow(
                                      cells: [
                                        DataCell(
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                  _getIconForCategory(expense.category),
                                                  size: 20,
                                                  color: Colors.blue
                                              ),
                                              SizedBox(width: 8),
                                              Text(expense.category),
                                            ],
                                          ),
                                        ),
                                        DataCell(Text(expense.paymentMode)),
                                        DataCell(Text(expense.description)),
                                        DataCell(
                                          Text(
                                            expense.status,
                                            style: TextStyle(color: Colors.blue),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                              DateFormat('HH:mm')
                                                  .format(expense.dateTime)
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                              '\$${expense.amount.toStringAsFixed(2)}'
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}