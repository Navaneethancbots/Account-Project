import 'package:account_project/MasterPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Firestore/User.dart';
import 'HomePage.dart';

class EquityPage extends StatefulWidget {
  const EquityPage({Key? key}) : super(key: key);

  @override
  _EquityPageState createState() => _EquityPageState();
}

class _EquityPageState extends State<EquityPage> {
  var totalAmountController = TextEditingController();
  var descController = TextEditingController();
  TextEditingController dateinput = TextEditingController();

  @override
  void initState() {
    dateinput.text = "";
    super.initState();
  }

  bool totalAmountErr = false;
  bool dateErr = false;
  bool descErr = false;

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  String? dropdownValue = 'one';

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
        title: Text('Add New Equity',
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

              Container(
                  padding: EdgeInsets.all(15),
                  height: 80,
                  child: TextField(
                    style: TextStyle(fontFamily: 'Poppins'),
                    controller:
                        dateinput, //editing controller of this TextField
                    decoration: InputDecoration(
                      // icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "Select Date",
                      labelStyle: TextStyle(fontFamily: 'Poppins'),
                      errorText: dateErr
                          ? 'Value can\'t Be Empty'
                          : null, //label text of field
                    ),
                    readOnly: true,
                    onTap: () async {
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
                          dateinput.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                  )),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: TextField(
                  style: TextStyle(fontFamily: 'Poppins'),
                  controller: totalAmountController,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    hintText: 'Income Amount',
                    hintStyle: TextStyle(fontFamily: 'Poppins'),
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                    errorText: totalAmountErr ? 'Value can\'t Be Empty' : null,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: TextField(
                  style: TextStyle(fontFamily: 'Poppins'),
                  controller: descController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: 'Description',
                    hintStyle: TextStyle(fontFamily: 'Poppins'),
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                    errorText: descErr ? 'Value can\'t Be Empty' : null,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
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
                          totalAmountController.text.isEmpty
                              ? totalAmountErr = true
                              : totalAmountErr = false;
                          descController.text.isEmpty
                              ? descErr = true
                              : descErr = false;
                          dateinput.text.isEmpty
                              ? dateErr = true
                              : dateErr = false;
                        });

                        if (totalAmountErr == false &&
                            descErr == false &&
                            dateErr == false) {
                          final user = User(
                              totalAmount: totalAmountController.text,
                              descpEquity: descController.text,
                              date: dateinput.text);
                          createUser(user);
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

  Future createUser(User user) async {
    final docUser = FirebaseFirestore.instance.collection('Equity').doc();
    user.id = docUser.id;
    final json = user.equity();
    await docUser.set(json);
  }
}
