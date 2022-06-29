
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'Firestore/User.dart';

import 'HomePage.dart';

class ExpensePage extends StatefulWidget {

  const ExpensePage({Key? key}) : super(key: key);

  @override
  _ExpensePageState createState() => _ExpensePageState();

}

class _ExpensePageState extends State<ExpensePage> {

  final measureValueController = TextEditingController();

  final itemAmountController = TextEditingController();

  final totalController = TextEditingController();

  bool measureErr = false;
  bool itemAmountErr = false;

  String? dropdownValue;

  var basic = 0, other = 0, sum = 0;

  void initState() {

    itemAmountController.addListener(() {

      totalController.text = (int.parse(itemAmountController.text) *
              int.parse(measureValueController.text))
          .toString();

    });

    super.initState();

  }

  _showSuccessSnackBar(String message) {

    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(

        content: Text(message),

      ),

    );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      appBar: AppBar(

        backgroundColor: Colors.white,

        elevation: 0.0,

        leading: IconButton(

            onPressed: () {

              Navigator.pushReplacement(

                  context, MaterialPageRoute(builder: (context) => HomePage()));

            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Text('Expense',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                fontFamily: 'Poppins',
                color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: StreamBuilder<List<User>>(
                    stream: readUsers(),
                    builder: (context, snapsot) {
                      if (snapsot.hasError) {
                        return Text('Something went wrong! ${snapsot.error}');
                      } else if (snapsot.hasData) {

                        final master_expenses = snapsot.data!;

                        return DropdownButton<String>(
                          alignment: Alignment.topLeft,
                          hint: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 25),
                              child: Text("Select item",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontFamily: 'Poppins',
                                    fontSize: 17,
                                  )),
                            ),
                          ),
                          isExpanded:true,
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_drop_down_sharp),
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 16),
                          underline: Container(
                            height: 0,
                            color: Colors.black38,
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: master_expenses.map((e) {
                            return DropdownMenuItem<String>(
                              value: e.expenseName,
                              child: Text(e.expenseName.toString()),
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
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontFamily: 'Poppins'),
                  controller: measureValueController,
                  onSubmitted: (String value) {},
                  decoration: InputDecoration(
                    labelText: 'Measure Value',
                    hintText: 'Measure Value',
                    hintStyle: TextStyle(fontFamily: 'Poppins'),
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                    errorText: measureErr ? 'Value can\'t Be Empty' : null,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: TextField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontFamily: 'Poppins'),
                  controller: itemAmountController,
                  onChanged: (value){

                   setState(() {

                      itemAmountController.addListener(() {

                        totalController.text = (int.parse(value.toString()) * int.parse(measureValueController.text)).toString();


                      });

                    });

                  },
                  onSubmitted: (String value) {},
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    hintText: 'one quantity Amount',
                    hintStyle: TextStyle(fontFamily: 'Poppins'),
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                    errorText: itemAmountErr ? 'Value can\'t Be Empty' : null,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: TextField(
                  enabled: false,
                  style: TextStyle(fontFamily: 'Poppins'),
                  controller: totalController,
                  onSubmitted: (String value) {},
                  decoration: InputDecoration(
                    labelText: 'Total Amount',
                    labelStyle: TextStyle(fontFamily: 'Poppins',color: Colors.black54),
                  ),
                ),
              ),

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
                      color: Colors.blue,
                      onPressed: () {
                        setState(() {
                          measureValueController.text.isEmpty
                              ? measureErr = true
                              : measureErr = false;
                          itemAmountController.text.isEmpty
                              ? itemAmountErr = true
                              : itemAmountErr = false;
                          if(measureValueController.text.isNotEmpty && itemAmountController.text.isNotEmpty && dropdownValue == null){
                            _showSuccessSnackBar('Select Item');
                          }
                        });

                        if (measureErr == false && itemAmountErr == false && dropdownValue != null){
                          final user = User(selectItem: dropdownValue,measurement: measureValueController.text,Amount: totalController.text);
                          createUser(user);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
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
  
  Future createUser(User user) async {
    
    final docUser = FirebaseFirestore.instance.collection('Expense').doc();

    user.id = docUser.id;

    final json = user.Expense();

    await docUser.set(json);
  }
  
  Stream<List<User>> readUsers() {
    return FirebaseFirestore.instance
        .collection('master_expenses')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
  }
}
