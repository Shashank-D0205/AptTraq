import 'dart:async';

class Expense {
  final String category;
  final String paymentMode;
  final String description;
  final double amount;
  final DateTime dateTime;
  final String status = 'Successful';  // Default status

  Expense({
    required this.category,
    required this.paymentMode,
    required this.description,
    required this.amount,
    required this.dateTime,
  });
}

class ExpenseService {
  static final ExpenseService _instance = ExpenseService._internal();
  factory ExpenseService() => _instance;
  ExpenseService._internal();

  final List<Expense> _expenses = [];

  final _controller = StreamController<List<Expense>>.broadcast();

  Stream<List<Expense>> get expenseStream => _controller.stream;
  List<Expense> get expenses => _expenses;

  void addExpense(Expense expense) {
    _expenses.add(expense);
    _controller.add(_expenses);  // Broadcast the update
  }

  List<Expense> getExpensesByDate(DateTime date) {
    return _expenses.where((expense) =>
    expense.dateTime.year == date.year &&
        expense.dateTime.month == date.month &&
        expense.dateTime.day == date.day
    ).toList();
  }

  void dispose() {
    _controller.close();
  }
}