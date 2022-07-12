
import 'package:account_project/CurrencyFormat.dart';
import 'package:account_project/Decimal%20values.dart';
import 'package:account_project/Login/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'Firestore/Accounts.dart';
import 'FirestoreCRUD.dart';
import 'HomePage.dart';
class EquityPage extends StatefulWidget {
  const EquityPage({Key? key}) : super(key: key);

  @override
  _EquityPageState createState() => _EquityPageState();
}

class _EquityPageState extends State<EquityPage> {
  TextEditingController equityAmountController = TextEditingController();
  TextEditingController equityDescriptionController = TextEditingController();
  TextEditingController equityDate = TextEditingController();



  @override
  void initState() {
    equityDate.text = "";
    super.initState();
  }

  bool equityAmountErr = false;
  bool equityDateErr = false;
  bool equityDescriptionErr = false;

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  var formatter;

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
        title: Text('Add New Equity',
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

              Container(
                  padding: EdgeInsets.all(15),
                  height: 80,
                  child: TextField(
                    cursorColor: Colors.deepPurple,
                    style: TextStyle(fontFamily: 'Poppins'),
                    controller:
                        equityDate, //editing controller of this TextField
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
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
                            equityDate.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },icon: Icon(Icons.calendar_today,color: Colors.deepPurple,),),
                      // icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "Select Date",
                      labelStyle: TextStyle(fontFamily: 'Poppins',color: Colors.deepPurple),
                      errorText: equityDateErr
                          ? 'Value can\'t Be Empty'
                          : null, //label text of field
                    ),
                    readOnly: true,
                  ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: TextFormField(

                  cursorColor: Colors.deepPurple,
                  style: TextStyle(fontFamily: 'Poppins'),
                  controller: equityAmountController,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                    prefix: Text("$Currency ",style:TextStyle(color: Colors.black,fontSize: 16),),
                    // suffixIcon: DropdownButton<String>(
                    //   value: drop,
                    //   icon: Icon(Icons.keyboard_arrow_down_outlined,color: Colors.deepPurple,),
                    //   elevation:0,
                    //   style:TextStyle(color: Colors.black,fontSize: 18,fontFamily: 'Poppins'),
                    //   underline: Container(
                    //     height: 0,
                    //   ),
                    //   // onChanged: (String? newValue) {
                    //   //   setState(() {
                    //   //
                    //   //    // Converting entered amount format as per selected currency format
                    //   //    equityAmountController.text =  (drop == '₹') ?
                    //   //
                    //   //     CurrencyFormatIn().money.format(double.parse(equityAmountController.text.replaceAll(',',''))) :
                    //   //
                    //   //     CurrencyFormatUs().money.format(double.parse(equityAmountController.text.replaceAll(',','')));
                    //   //
                    //   //     drop = newValue!;
                    //   //
                    //   //   });
                    //   // },
                    //   items: <String>['₹','\$']
                    //       .map<DropdownMenuItem<String>>((String value) {
                    //     return DropdownMenuItem<String>(
                    //       value: value,
                    //       child: Text(value),
                    //     );
                    //   }).toList(),
                    // ),
                    labelText: 'Amount',
                    labelStyle: TextStyle(fontFamily: 'Poppins',color: Colors.deepPurple),
                    errorText: equityAmountErr ? 'Value can\'t Be Empty' : null,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly,Currency == '₹' ? CurrencyFormatIn() : CurrencyFormatUs()],
                ),
              ),
             //Text('${int.parse(equityAmountController.text)}'),
              //Text('${drop == '₹' ? NumberFormat.currency(locale: 'en-in').format(double.tryParse(equityAmountController.text)) : NumberFormat.currency(locale: 'en-us').format(double.tryParse(equityAmountController.text))}'),
              SizedBox(
                height: 15,
              ),

              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: TextField(
                  cursorColor: Colors.deepPurple,
                  style: TextStyle(fontFamily: 'Poppins'),
                  controller: equityDescriptionController,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                    labelText: 'Description',
                    labelStyle: TextStyle(fontFamily: 'Poppins',color: Colors.deepPurple),
                    errorText: equityDescriptionErr ? 'Value can\'t Be Empty' : null,
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
                      color: Colors.pink[200],
                      onPressed: () {
                        setState(() {
                          equityAmountController.text.isEmpty
                              ? equityAmountErr = true
                              : equityAmountErr = false;
                          equityDescriptionController.text.isEmpty
                              ? equityDescriptionErr = true
                              : equityDescriptionErr = false;
                          equityDate.text.isEmpty
                              ? equityDateErr = true
                              : equityDateErr = false;
                        });

                        if (equityAmountErr == false &&
                            equityDescriptionErr == false &&
                            equityDateErr == false) {
                         String value = equityAmountController.text;

                          final user = Accounts(
                              equityAmount: double.parse(value.replaceAll(',','')),
                              equityDescription: equityDescriptionController.text,
                              equityDate: equityDate.text);
                          createMaster(user,"Equity");
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
}


