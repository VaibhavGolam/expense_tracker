import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'flutter core',
      amount: 19.88,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 18.88,
      date: DateTime.now(),
      category: Category.leisure,
    )
  ];

  //opens the expense add form
  void _openExpenseAddOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return NewExpense(
          onAddExpense: _addExpense,
        );
      },
    );
  }

  //add
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  //remove
  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });

    //user can undo acceidently deleted expense
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense deleted'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/img/add_notes.png',
          width: 200,
          height: 200,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'No expenses, Add one',
          style: TextStyle(fontSize: 15),
        )
      ],
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: const Color.fromARGB(255, 17, 25, 110),
        title: const Text(
          'Expense Tracker',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                //the chart
                Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 192, 188, 222),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.food_bank_outlined,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.movie_creation_outlined,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.flight_takeoff_outlined,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.shopping_bag_outlined,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),

          //the list of expenses
          Expanded(child: mainContent),
        ],
      ),

      //todo
      floatingActionButton: FloatingActionButton(
        onPressed: _openExpenseAddOverlay,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
