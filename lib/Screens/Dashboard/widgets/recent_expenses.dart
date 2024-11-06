import 'package:flutter/material.dart';

class RecentExpenses extends StatelessWidget {
  const RecentExpenses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Expenses', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () {

                },
                child: Text('View all'),
              ),
            ],
          ),
          SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return _buildExpensesTable();
              } else {
                return _buildExpensesList();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExpensesTable() {
    return Table(
      columnWidths: {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(3),
        3: FlexColumnWidth(2),
        4: FlexColumnWidth(1),
        5: FlexColumnWidth(2),
      },
      children: [
        TableRow(
          children: ['Item Category', 'Payment Channel', 'Description', 'Transaction', 'Time', 'Amount']
              .map((e) => TableCell(child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(e, style: TextStyle(fontWeight: FontWeight.bold)),
          )))
              .toList(),
        ),
        _buildTableRow('Food', 'Debit Card', 'Mega chicken', 'Successful', '16:28', '\$3,000.00'),
        _buildTableRow('Utilities', 'POS', 'Ikeja electric', 'Unsuccessful', '15:28', '\$10,000.00'),
      ],
    );
  }

  TableRow _buildTableRow(String itemCategory, String paymentChannel, String description, String transaction, String time, String amount) {
    return TableRow(
      children: [
        _buildTableCell(itemCategory),
        _buildTableCell(paymentChannel),
        _buildTableCell(description),
        _buildTableCell(transaction, color: transaction.toLowerCase() == 'successful' ? Colors.blue : Colors.red),
        _buildTableCell(time),
        _buildTableCell(amount),
      ],
    );
  }

  Widget _buildTableCell(String text, {Color? color}) {
    return TableCell(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(
          text,
          style: TextStyle(color: color),
        ),
      ),
    );
  }

  Widget _buildExpensesList() {
    return ListView(

      shrinkWrap: true,
      children: [
        _buildExpenseCard('Food', 'Debit Card', 'Mega chicken', 'Successful', '16:28', '\$3,000.00'),
        SizedBox(height: 20,),
        _buildExpenseCard('Utilities', 'POS', 'Ikeja electric', 'Unsuccessful', '15:28', '\$10,000.00'),
      ],
    );
  }

  Widget _buildExpenseCard(String itemCategory, String paymentChannel, String description, String transaction, String time, String amount) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
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
                Text(itemCategory, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(amount, style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 8),
            Text(description),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(paymentChannel),
                Text(time),
              ],
            ),
            SizedBox(height: 8),
            Text(
              transaction,
              style: TextStyle(
                color: transaction.toLowerCase() == 'successful' ? Colors.blue : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}