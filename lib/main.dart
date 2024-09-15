import 'package:contact_app/expence.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dart:convert';

void main() => runApp(const ExpenseTrackerApp());

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Expense Tracker',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _expenses = [];
  double _totalExpenses = 0;



  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  _loadExpenses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedExpenses = prefs.getString('expenses');
    if (savedExpenses != null) {
      List<dynamic> decodedExpenses = jsonDecode(savedExpenses);
      setState(() {
        _expenses = List<Map<String, dynamic>>.from(decodedExpenses);
        _calculateTotal();
      });
    }
  }

  _calculateTotal() {
    double total = _expenses.fold(
        0, (sum, expense) => sum + double.parse(expense['amount']));
    setState(() {
      _totalExpenses = total;
    });
  }

  _deleteExpense(int index) async {
    setState(() {
      _expenses.removeAt(index);
      _calculateTotal();
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('expenses', jsonEncode(_expenses));
  }

  _navigateToAddExpensePage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddExpensePage()),
    );
    if (result != null) {
      setState(() {
        _expenses.add(result);
        _calculateTotal();
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('expenses', jsonEncode(_expenses));
    }
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("asset/images (3).jpeg"),
              radius: 23,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Text('Welcome!',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700)),
                Text('John Doe',
                    style:
                        TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 210,
              width: 400,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 5, 208, 253),
                    Color.fromARGB(255, 255, 73, 200),
                    Color.fromARGB(255, 249, 118, 30)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  const Text('Total Balance',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  Text('\$ $_totalExpenses',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 43,
                          fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 25,
                              height: 25,
                              decoration: const BoxDecoration(
                                  color: Colors.white30,
                                  shape: BoxShape.circle),
                              child: const Center(
                                  child: Icon(
                                Icons.arrow_downward,
                                size: 12,
                                color: Colors.greenAccent,
                              )),
                            ),
                            const SizedBox(width: 8),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Income',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "\$ 300000", 
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 25,
                              height: 25,
                              decoration: const BoxDecoration(
                                  color: Colors.white30,
                                  shape: BoxShape.circle),
                              child: const Center(
                                  child: Icon(
                                Icons.arrow_upward,
                                size: 12,
                                color: Colors.red,
                              )),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Expenses',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  '\$ $_totalExpenses',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          const SizedBox(height: 10,),

          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Transactions",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
                Text(
                  "View All",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black54),
                )
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: _expenses.length,
              itemBuilder: (context, index) {
                return Slidable(
                  endActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) => _deleteExpense(index),
                        icon: Icons.delete,
                        backgroundColor: Colors.red.shade300,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ],
                  ),
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.shopping_bag,
                          color: Colors.black54, size: 30),
                      title: Text(
                        _expenses[index]['description'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        '\$${_expenses[index]['amount']}',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600]),
                      ),
                      trailing: Icon(Icons.drag_handle),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: Container(
  height: 56.0,
  width: 56.0,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    gradient: const LinearGradient(
      colors: [
        Color.fromARGB(255, 5, 208, 253),
        Color.fromARGB(255, 255, 73, 200),
        Color.fromARGB(255, 249, 118, 30)
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  child: FloatingActionButton(
    elevation: 20,  // Remove shadow to make gradient more prominent
    backgroundColor: Colors.transparent,  // Transparent to show gradient
    onPressed: _navigateToAddExpensePage,
    child: const Icon(
      Icons.add,
      color: Colors.white,
    ),
  ),
),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: BottomNavigationBar(
          selectedItemColor: Colors.black54,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          elevation: 0,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.graphic_eq), label: 'Stats')
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
