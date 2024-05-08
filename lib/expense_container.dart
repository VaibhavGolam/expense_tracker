import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseContainer extends StatelessWidget {
  const ExpenseContainer({
    super.key,
    required this.containerTitle,
    required this.containerAmount,
    required this.containerTime,
    required this.containerCategory,
  });

  final String containerTitle;
  final double containerAmount;
  final DateTime containerTime;
  final Category containerCategory;

//icon Changer
  IconData getIconForCategory(Category containerCategory) {
    switch (containerCategory) {
      case Category.travel:
        return Icons.flight;
      case Category.food:
        return Icons.restaurant;
      case Category.leisure:
        return Icons.beach_access;
      case Category.work:
        return Icons.work;
      default:
        return Icons.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:
          //Container
          Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 192, 188, 222),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //item name
            Text(
              containerTitle,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //cost
                Text(containerAmount.toString()),

                //date of purchase
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(getIconForCategory(containerCategory)),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(containerTime.toString())
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
