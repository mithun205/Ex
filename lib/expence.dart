import 'package:flutter/material.dart';


class AddExpensePage extends StatefulWidget {
  const AddExpensePage({Key? key}) : super(key: key);

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _incomeController = TextEditingController(); // Add income controller

  _saveExpense() {
    String amount = _amountController.text;
    String description = _descriptionController.text;
    String income = _incomeController.text; // Get income input

    if (amount.isNotEmpty && description.isNotEmpty ) {
      Map<String, dynamic> newExpense = {
        'amount': amount,
        'description': description,
      };
      Navigator.pop(context, {'expense': newExpense, 'income': income}); // Pass income as well
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
     appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [IconButton(onPressed:(){
            Navigator.pop(context); 
        }, icon:Icon(Icons.close_outlined))],
        backgroundColor: Colors.transparent,
       
      ),

      body:Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Add Expense', style: TextStyle(fontSize: 24)),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 40, left: 40),
                child: TextField(
                  textAlign: TextAlign.center,
                        
                  cursorColor: Colors.black,
                  cursorHeight: 30,
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(25),
                    labelText: 'Amount',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(
                          color: Colors.white), // White border when not focused
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2), // White border when focused
                    ),
                  ),
                ),
              ),
              SizedBox(height: 35),
              TextField(
                cursorColor: Colors.black,
                controller: _descriptionController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  labelText: 'Note',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                        color: Colors.white), // White border when not focused
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2), // White border when focused
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _incomeController, // Income input field
              keyboardType: TextInputType.number, //---------------------------------
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    labelText: 'Income',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                     ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: Colors.white), // White border when not focused
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2), // White border when focused
                    )),
              ),
              SizedBox(height: 20),
              


              SizedBox(height: 250),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.purple, Colors.orange],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(
                      15), // Match the button's border radius
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 160, vertical: 15),
                    backgroundColor: Colors
                        .transparent, // Make button background transparent
                    shadowColor: Colors
                        .transparent, // Remove shadow to show gradient clearly
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  onPressed: _saveExpense,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
