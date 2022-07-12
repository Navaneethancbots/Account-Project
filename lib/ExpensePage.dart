
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Decimal values.dart';
import 'Firestore/Accounts.dart';

import 'FirestoreCRUD.dart';
import 'HomePage.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({Key? key}) : super(key: key);

  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {


  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.amberAccent,
              onPrimary: Colors.redAccent,
              onSurface: Colors.blueAccent,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
  }

  final expenseMeasureController = TextEditingController();

  final expenseAmountController = TextEditingController();

  final expenseTotalAmountController = TextEditingController();

  final expenseDate = TextEditingController();

  bool expenseMeasureErr = false;
  bool expenseAmountErr = false;
  bool expenseDateErr = false;

  String? expenseSelectItem ;

  int? expenseTotalAmount;

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
  @override
  void initState() {
    expenseTotalAmountController.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: Text('Add New Expense',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                fontFamily: 'Poppins',
                color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: TextField(
                  style: TextStyle(fontFamily: 'Poppins'),
                  controller:
                  expenseDate, //editing controller of this TextField
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple)
                    ),
                    suffixIcon: IconButton(onPressed: ()async{
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));
                      if (pickedDate != null) {
                        print(pickedDate);
                        String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(formattedDate);

                        setState(() {
                          expenseDate.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },icon: Icon(Icons.calendar_today,color: Colors.deepPurple,),),
                    // icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "Select Date",
                    labelStyle: TextStyle(fontFamily: 'Poppins',color: Colors.deepPurple),
                    errorText: expenseDateErr
                        ? 'Value can\'t Be Empty'
                        : null, //label text of field
                  ),
                  readOnly: true,
                ),
              ),

              SizedBox(
                height: 30,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: StreamBuilder<List<Accounts>>(
                    stream: read('master_expenses'),
                    builder: (context, snapsot) {
                      if (snapsot.hasError) {
                        return Text('Something went wrong! ${snapsot.error}');
                      } else if (snapsot.hasData) {
                        final Expenses = snapsot.data!;
                        return DropdownButton<String>(
                          alignment: Alignment.topLeft,
                          hint: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 25),
                              child: Text("Select Expense",
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontFamily: 'Poppins',
                                    fontSize: 17,
                                  )),
                            ),
                          ),
                          isExpanded: true,
                          value: expenseSelectItem,
                          icon: const Icon(Icons.arrow_drop_down_sharp),
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 16),
                          underline: Container(
                            height: 1,
                            color: Colors.black38,
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              expenseSelectItem = newValue;
                            });
                          },
                          items: Expenses.map((e) {
                            return DropdownMenuItem<String>(
                              value: e.masterName,
                              child: Text(e.masterName.toString()),
                              alignment: Alignment.topLeft,
                            );
                          }).toList(),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: TextField(
                  cursorColor: Colors.deepPurple,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontFamily: 'Poppins'),
                  controller: expenseMeasureController,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple)
                    ),
                    labelText: 'Qty',
                    labelStyle: TextStyle(fontFamily: 'Poppins',color: Colors.deepPurple),
                    errorText: expenseMeasureErr ? 'Value can\'t Be Empty' : null,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: TextField(
                  cursorColor: Colors.deepPurple,
                 // inputFormatters:[ThousandsSeparatorInputFormatter()],
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontFamily: 'Poppins'),
                  controller: expenseAmountController,
                  onChanged: (value) {
                    setState(() {
                      expenseAmountController.addListener(() {
                        expenseTotalAmountController.text = (int.parse(value.toString()) *
                            int.parse(expenseMeasureController.text)).toString();
                      });
                    });
                  },
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple)
                    ),
                    prefix: Text(Currency,style:TextStyle(color: Colors.black,fontSize: 16),),
                    labelText: 'Base Rate',
                    labelStyle: TextStyle(fontFamily: 'Poppins',color: Colors.deepPurple),
                    errorText: expenseAmountErr ? 'Value can\'t Be Empty' : null,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: TextField(
                 // inputFormatters:[ThousandsSeparatorInputFormatter()],
                  enabled: false,
                  style: TextStyle(fontFamily: 'Poppins',color: Colors.black,fontSize: 20),
                  controller: expenseTotalAmountController,
                  decoration: InputDecoration(
                    prefix: Text(Currency,style:TextStyle(color: Colors.black,fontSize: 16),),
                    labelText: 'Total Amount',
                    labelStyle:
                        TextStyle(fontFamily: 'Poppins', color: Colors.deepPurple),
                  ),
                ),
              ),
              //Text(expenseTotalAmountController.text.toString()),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: RaisedButton(
                      padding: EdgeInsets.all(10),
                      elevation: (0.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.pink[200],
                      onPressed: () {
                        setState(() {
                          expenseMeasureController.text.isEmpty
                              ? expenseMeasureErr = true
                              : expenseMeasureErr = false;
                          expenseDate.text.isEmpty
                              ? expenseDateErr = true
                              : expenseDateErr = false;
                          expenseAmountController.text.isEmpty
                              ? expenseAmountErr = true
                              : expenseAmountErr = false;
                          if (expenseMeasureController.text.isNotEmpty &&
                              expenseAmountController.text.isNotEmpty &&
                              expenseSelectItem == null) {
                            _showSuccessSnackBar('Select Expense');
                          }
                        });

                        if (expenseMeasureErr == false &&
                            expenseAmountErr == false &&
                            expenseDateErr == false &&
                            expenseSelectItem != null) {
                          final user = Accounts(
                              expenseSelectItem: expenseSelectItem,
                              expenseDate: expenseDate.text,
                              expenseMeasure: expenseMeasureController.text,
                              expenseAmount: double.tryParse (expenseAmountController.text),
                              expenseTotalAmount:double.tryParse(expenseTotalAmountController.text));
                          createMaster(user,"Expense");
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        }
                      },
                      child: Text('Add',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              fontSize: 16))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  getData(myId) async{
    QuerySnapshot response1  = await FirebaseFirestore.instance.collection("master_expenses").where('id',isEqualTo: myId ).get();
    QuerySnapshot response2 = await FirebaseFirestore.instance.collection("Expense").where('id',isEqualTo: myId ).get();
    List<DocumentSnapshot> list1 = response1.docs;
    list1.addAll(response2.docs);
    print('${list1}');
    return list1;
  }

}
