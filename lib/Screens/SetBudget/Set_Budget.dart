//main setbudget screen

import 'package:flutter/material.dart';
import 'package:pennyflow/Screens/SetBudget/MobileSB.dart';
import 'package:pennyflow/Screens/SetBudget/Budgetcontainer.dart';
import 'package:pennyflow/ResponsiveWrapper.dart';
import 'package:pennyflow/values/values.dart';

import '../../Nav_bar.dart';
import '../../header.dart';
import 'Set Expense.dart';

class SetBudget extends StatefulWidget {
  static const String setbudgetPageroute = StringConst.SET_BUDGET_PAGE;
  final Function(int) onIndexChanged;
  final int currentIndex;

  const SetBudget({
    Key? key,
    required this.onIndexChanged,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<SetBudget> createState() => _SetBudgetState();
}

class _SetBudgetState extends State<SetBudget> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveWrapper(
        mobile: MobileSB(currentIndex: widget.currentIndex, onIndexChanged: widget.onIndexChanged),
        tablet: _buildtabSB(),
        desktop: _builddesktopSB());
  }

  Widget _buildtabSB() {
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
                PageHeader(title: StringConst.SET_BUDGET),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              StringConst.BUDGET,
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 18),
                            Budgetcontainer(),
                            SizedBox(height: 24),
                            SetExpenseWidget(),
                            // Add more widgets here as needed
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

  Widget _builddesktopSB() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: <Widget>[
          NavBar(
            currentIndex: widget.currentIndex,
            onIndexChanged: widget.onIndexChanged,
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
                PageHeader(title: StringConst.SET_BUDGET),
                Divider(height: 1, thickness: 1, color: Colors.grey[300]),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(0),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Text(
                              StringConst.BUDGET,
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 18),
                            Budgetcontainer(),
                            SizedBox(height: 24),
                            SetExpenseWidget() // Add more widgets here as needed
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}