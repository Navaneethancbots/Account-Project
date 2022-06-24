import 'package:account_project/Login/HomePage.dart';
import 'package:flutter/material.dart';
class ExpensePage extends StatefulWidget {
  const ExpensePage({Key? key}) : super(key: key);

  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  final itemController = TextEditingController();
  final quantityController = TextEditingController();
  final qutAmountController = TextEditingController();

  bool itemErr = false;
  bool quantityErr = false;
  bool qutAmountErr = false;

  var _volume;

  void _calculation() {
    _volume = int.parse(quantityController.text) * int.parse(qutAmountController.text) ;
    print(_volume);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
           IconButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
          }, icon: Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: Text('Expense'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add New Details',
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: itemController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                  ),
                  hintText: 'item Name',
                  labelText: 'Name',
                  errorText: itemErr ? 'Value can\'t Be Empty' : null,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: quantityController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Quantity',
                  labelText: 'Quantity',
                  errorText: quantityErr ? 'Value can\'t Be Empty' : null,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: qutAmountController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'qut Amount',
                  labelText: 'Amount',
                  errorText: qutAmountErr ? 'Value can\'t Be Empty' : null,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text('total : ${_volume} '),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.white, backgroundColor: Colors.teal),
                    onPressed: () async {

                      setState(() {
                        itemController.text.isEmpty
                            ? itemErr = true
                            : itemErr = false;
                        quantityController.text.isEmpty
                            ? quantityErr = true
                            : quantityErr = false;
                        qutAmountController.text.isEmpty
                            ? qutAmountErr = true
                            : qutAmountErr = false;
                      });
                      if (itemErr == false &&
                          quantityErr == false &&
                          qutAmountErr == false) {
                      }
                    },
                    child: Text(
                      'Add Details',
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.white, backgroundColor: Colors.red),
                    onPressed: () {
                      itemController.text = '';
                      quantityController.text = '';
                      qutAmountController.text = '';
                    },
                    child: Text(
                      'Clear Details',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

