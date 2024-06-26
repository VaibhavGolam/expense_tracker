import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleCntroller = TextEditingController();
  final _amountCntroller = TextEditingController();
  DateTime? _selectedDate;
  Category? _selectedCategory = Category.leisure;

  final formatter = DateFormat.yMd();

  @override
  void dispose() {
    _titleCntroller.dispose();
    _amountCntroller.dispose();
    super.dispose();
  }

//date picker dialog
  void _showDatePickerDialog() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  //form validation
  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountCntroller.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0; 
    if (_titleCntroller.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Add all fields'),
          content: const Text(
            'Please make sure valid Title, Amount, Date and Cateogry was entered',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
      return;
    }

    widget.onAddExpense(
      Expense(
          title: _titleCntroller.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory!),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final ScreenWidth = constraints.maxWidth;
      //   final height = constraints.maxHeight;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 10, 16, keyboardSpace + 16),
            child: Column(
              children: [
                //first row
                if (ScreenWidth >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          autofocus: false,
                          maxLength: 50,
                          controller: _titleCntroller,
                          decoration: const InputDecoration(
                            labelText: 'Title',
                            labelStyle: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
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
                    ],
                  )
                else
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

                //second row
                if (ScreenWidth >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //drop down button
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(category.name.toUpperCase()),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ),

                      const SizedBox(width: 24),

                      //date
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_selectedDate == null
                                ? 'Select date'
                                : formatter.format(_selectedDate!)),
                            IconButton(
                              onPressed: _showDatePickerDialog,
                              icon: const Icon(
                                Icons.date_range_outlined,
                                size: 35,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                else
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
                            Text(_selectedDate == null
                                ? 'Select date'
                                : formatter.format(_selectedDate!)),
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

                //third row
                if (ScreenWidth >= 600)
                  //drop down and button
                  Row(
                    children: [
                      const Spacer(),
                      //cancel btn
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),

                      //
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text('Add expense'),
                      )
                    ],
                  )
                else
                  Row(
                    children: [
                      //drop down list
                      DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name.toUpperCase()),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          }),

                      const Spacer(),
                      //cancel btn
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),

                      //
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text('Add expense'),
                      )
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}
