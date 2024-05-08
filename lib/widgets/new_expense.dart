import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleCntroller = TextEditingController();
  final _amountCntroller = TextEditingController();

  @override
  void dispose() {
    _titleCntroller.dispose();
    _amountCntroller.dispose();
    super.dispose();
  }

//date picker dialog
  void _showDatePickerDialog() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          //title
          TextField(
            autofocus: false,
            maxLength: 50,
            controller: _titleCntroller,
            decoration: const InputDecoration(
              labelText: 'Title',
              labelStyle: TextStyle(fontSize: 15),
            ),
          ),

          Row(
            children: [
              //amount
              Expanded(
                child: TextField(
                  autofocus: false,
                  controller: _amountCntroller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '₹ ',
                    labelText: 'Amount',
                    labelStyle: TextStyle(fontSize: 15),
                  ),
                ),
              ),

              //gap between
              const SizedBox(
                width: 20,
              ),

              //date
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Select date',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    IconButton(
                      onPressed: _showDatePickerDialog,
                      icon: const Icon(
                        Icons.date_range_outlined,
                        size: 35,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),

          //button
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('cancel'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('button pressed'),
              )
            ],
          )
        ],
      ),
    );
  }
}
