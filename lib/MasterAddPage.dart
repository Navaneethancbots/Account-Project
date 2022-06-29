 import 'package:account_project/MasterPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Firestore/User.dart';
import 'HomePage.dart';
class MasterAddPage extends StatefulWidget {
  const MasterAddPage({Key? key}) : super(key: key);

  @override
  _MasterAddPageState createState() => _MasterAddPageState();
}

class _MasterAddPageState extends State<MasterAddPage> {
  var nameController = TextEditingController();
  var queController = TextEditingController();
  var descriptionController = TextEditingController();

  bool nameErr = false;
  bool dropdownErr = false;
  bool descriptionErr = false;

  String? dropdownValue ;


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
        leading:
        IconButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MasterPage()));
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        title: Text('Add New Master',style: TextStyle(fontSize: 20
            ,fontWeight: FontWeight.w800 ,fontFamily: 'Poppins',color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15,right: 15),
                child: TextField(
                  style: TextStyle(fontFamily: 'Poppins'),
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Expense Name',
                    hintText: 'Expense Name',
                    hintStyle:  TextStyle(fontFamily: 'Poppins'),
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                    errorText: nameErr ? 'Value can\'t Be Empty' : null,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15,right: 15),
                child:DropdownButton<String>(

                  alignment: Alignment.topLeft,
                  hint: Container(
                    child:Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: Text(
                      "Select Item Type",
                      style: TextStyle(color: Colors.black54,fontFamily: 'Poppins',fontSize: 16,),

                  ),
                    ),),                     //and here
                  isExpanded: true,
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_drop_down_sharp),
                  style: const TextStyle(color: Colors.black,fontFamily: 'Poppins',fontSize: 16),
                  underline: Container(
                    height: 1,
                    color: Colors.black38,

                  ),
                  onChanged: (String? newValue) {

                    setState(
                            () {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>['Ltr', 'Nos', 'Kg',]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                      alignment: Alignment.topLeft,
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              Padding(
                padding: EdgeInsets.only(left: 15,right: 15),
                child: TextField(
                  style: TextStyle(fontFamily: 'Poppins'),
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: 'Description',
                    hintStyle:  TextStyle(fontFamily: 'Poppins'),
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                    errorText: descriptionErr ? 'Value can\'t Be Empty' : null,
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.blue,

                      onPressed: ()  {
                        setState(() {
                          nameController.text.isEmpty ? nameErr = true : nameErr = false;
                          descriptionController.text.isEmpty ? descriptionErr = true : descriptionErr = false;
                          if(nameController.text.isNotEmpty && descriptionController.text.isNotEmpty && dropdownValue == null){
                            _showSuccessSnackBar('select',);
                          }
                        });

                        if (nameErr == false && descriptionErr == false && dropdownValue != null){
                          final user = User(expenseName: nameController.text, Mesure: dropdownValue, decription: descriptionController.text);
                          createUser(user);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MasterPage()));
                        }

                      },
                      child:
                      Text('Add',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'Poppins',fontSize: 16))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future createUser(User user)async{
    final docUser = FirebaseFirestore.instance.collection('master_expenses').doc();
    user.id = docUser.id;
    final json = user.toJson();
    await docUser.set(json);
  }
}

