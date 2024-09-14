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
  double _totalIncome = 0; // Add a variable for total income

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

    String? savedIncome = prefs.getString('income'); // Load saved income
    if (savedIncome != null) {
      setState(() {
        _totalIncome = double.parse(savedIncome); // Set total income
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
        // Update expenses and income if present in the result
        _expenses.add(result['expense']);
        _totalIncome = double.parse(result['income']); // Set the total income
        _calculateTotal();
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('expenses', jsonEncode(_expenses));
      prefs.setString('income', _totalIncome.toString()); // Save the income
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

    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor:Colors.grey[200],
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: const AssetImage("asset/images (3).jpeg"),
              radius:  width * 0.06,
            ),
            SizedBox(
              width: width * 0.02,
            ),
             Column(
              children: [
                Text('Welcome!',
                    style: TextStyle(
                        fontSize: width * 0.05,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700)),
                Text('John Doe',
                    style: TextStyle(
                        fontSize: width * 0.06, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
        flexibleSpace: Container(),
      ),
      body: Column(
        children: [
          Padding(
            padding:  EdgeInsets.all(width * 0.04),
            child: Container(
               height: height * 0.25,
              width: width * 0.9,
              padding:  EdgeInsets.all(width * 0.06),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width * 0.08),
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.purple, Colors.orange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  const Text('Total Balance',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  const SizedBox(height: 8),
                  Text('\$ $_totalExpenses',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold)),
                  Padding(
                    padding:  EdgeInsets.symmetric(
                        vertical: height * 0.015, horizontal: width * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: width * 0.06,
                              height: width * 0.06,
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Income',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  '\$ $_totalIncome',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                               width: width * 0.06,
                              height: width * 0.06,
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
                                const Text(
                                  'Expenses',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  '\$ $_totalExpenses',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.all(width * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Transactions",
                  style: TextStyle(fontSize: width * 0.06, fontWeight: FontWeight.bold),
                ),
                Text(
                  "View All",
                  style: TextStyle(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w700,
                      color: Colors.black54),
                ),
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
                        borderRadius: BorderRadius.circular(width * 0.03),
                      ),
                    ],
                  ),
                  child: Card(
                    margin:  EdgeInsets.symmetric(
                        vertical: height * 0.015, horizontal: width * 0.05),
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
                      trailing: const Icon(Icons.drag_handle),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 20,
        shape: const CircleBorder(),
        backgroundColor: Colors.purpleAccent,
        onPressed: _navigateToAddExpensePage,
        child: const Icon(
          Icons.add,
          color: Colors.white,
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
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.graphic_eq), label: 'Stats')
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
