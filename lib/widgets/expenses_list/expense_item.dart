import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      // color: const Color.fromARGB(255, 192, 188, 222),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //item name
            Text(
              expense.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //amount
                Text('₹ ${expense.amount.toStringAsFixed(2)}'),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    //icon
                    Icon(categoryIcon[expense.category]),

                    //gap between
                    const SizedBox(
                      width: 10,
                    ),

                    //date
                    Text(expense.formatedDate)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
