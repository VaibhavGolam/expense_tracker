import 'package:expense_tracker/expense_container.dart';

import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => ExpenseContainer(
        containerTitle: expenses[index].title,
        containerAmount: expenses[index].amount,
        containerCategory: expenses[index].category,
        containerTime: expenses[index].date,
      ),
    );
  }
}