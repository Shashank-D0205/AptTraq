import 'package:flutter/material.dart';
import 'package:pennyflow/Auth/LogIn.dart';
import 'package:pennyflow/Screens/SetBudget/services&models%5Bmonthly%5D.dart';
import 'package:pennyflow/values/values.dart';
import 'package:provider/provider.dart';
import 'Screens/Dashboard/Dashboard Screen.dart';
import 'Screens/ExpenseReport/Expense Report.dart';
import 'Screens/Recomm/Recommendation Screen.dart';
import 'Screens/SetBudget/Set_Budget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringConst.APP_NAME,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  void _onIndexChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>BudgetProvider(),
      child: Scaffold(
        body: Row(
          children: [
            Expanded(
              child: IndexedStack(
                index: _currentIndex,
                children: [
                  Dashboard_SC(
                    currentIndex: _currentIndex,
                    onIndexChanged: _onIndexChanged,
                  ),
                  SetBudget(
                    currentIndex: _currentIndex,
                    onIndexChanged: _onIndexChanged,
                  ),
                  ExpenseReport(
                    currentIndex: _currentIndex,
                    onIndexChanged: _onIndexChanged,
                  ),
                  RecommendationSC(
                    currentIndex: _currentIndex,
                    onIndexChanged: _onIndexChanged,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}