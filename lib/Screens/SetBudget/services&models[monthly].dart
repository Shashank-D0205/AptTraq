import 'package:flutter/material.dart';

class BudgetData {
  final double monthlyIncome;
  final double monthlyBudget;
  final double monthlySavings;
  final double weeklyBudget;
  final double weeklySpent;
  static const double maxWeeklyLimit = 50000;

  BudgetData({
    this.monthlyIncome = 0,
    this.monthlyBudget = 0,
    this.monthlySavings = 0,
    this.weeklyBudget = 0,
    this.weeklySpent = 0,
  });

  BudgetData copyWith({
    double? monthlyIncome,
    double? monthlyBudget,
    double? monthlySavings,
    double? weeklyBudget,
    double? weeklySpent,
  }) {
    return BudgetData(
      monthlyIncome: monthlyIncome ?? this.monthlyIncome,
      monthlyBudget: monthlyBudget ?? this.monthlyBudget,
      monthlySavings: monthlySavings ?? this.monthlySavings,
      weeklyBudget: weeklyBudget ?? this.weeklyBudget,
      weeklySpent: weeklySpent ?? this.weeklySpent,
    );
  }
}

class BudgetProvider extends ChangeNotifier {
  BudgetData _budgetData = BudgetData();

  BudgetData get budgetData => _budgetData;

  void updateMonthlyBudget({
    required double income,
    required double budget,
    required double savings,
  }) {
    _budgetData = _budgetData.copyWith(
      monthlyIncome: income,
      monthlyBudget: budget,
      monthlySavings: savings,
    );
    notifyListeners();
  }

  void updateWeeklyBudget(double budget) {
    if (budget <= BudgetData.maxWeeklyLimit) {
      _budgetData = _budgetData.copyWith(weeklyBudget: budget);
      notifyListeners();
    }
  }

  void updateWeeklySpent(double spent) {
    _budgetData = _budgetData.copyWith(weeklySpent: spent);
    notifyListeners();
  }

  double get weeklyProgress {
    if (_budgetData.weeklyBudget == 0) return 0;
    return (_budgetData.weeklySpent / _budgetData.weeklyBudget).clamp(0.0, 1.0);
  }
}