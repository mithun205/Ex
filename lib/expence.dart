import 'package:flutter/material.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  _AddExpensePageState createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
 

  _saveExpense() {
    String amount = _amountController.text;
    String description = _descriptionController.text;
     

    if (amount.isNotEmpty && description.isNotEmpty) {
    
      Map<String, dynamic> newExpense = {
        'amount': amount,
        'description': description,
       
      };
      Navigator.pop(context, newExpense);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close_outlined))
        ],
        backgroundColor: Colors.transparent,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text('Add Expense',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
                  
              const SizedBox(height: 20,),

              Padding(
                padding: const EdgeInsets.only(right: 40, left: 40),
                child: TextField(
                  textAlign: TextAlign.center,
                  cursorColor: Colors.black,
                  cursorHeight: 30,
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(25),
                    labelText: 'Amount',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(
                          color: Colors.white), 
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 2), 
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 35),

              TextField(
                cursorColor: Colors.black,
                controller: _descriptionController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20),
                  labelText: 'Note',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                        color: Colors.white), 
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 2),
                  ),
                ),
              ),

              const SizedBox(height: 290),

              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 5, 208, 253),
                      Color.fromARGB(255, 255, 73, 200),
                      Color.fromARGB(255, 249, 118, 30)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(
                      15), 
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 140, vertical: 15),
                    backgroundColor: Colors
                        .transparent, 
                    shadowColor: Colors
                        .transparent, 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: _saveExpense,
                  child: const Text(
                    'SAVE',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
