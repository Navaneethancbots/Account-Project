import 'package:flutter/material.dart';

import 'Login/HomePage.dart';
class EquityPage extends StatefulWidget {
  const EquityPage({Key? key}) : super(key: key);

  @override
  _EquityPageState createState() => _EquityPageState();
}

class _EquityPageState extends State<EquityPage> {
  var nameController = TextEditingController();
  var queController = TextEditingController();
  var descriptionController = TextEditingController();

  bool nameErr = false;
  bool queErr = false;
  bool descriptionErr = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
        IconButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
        }, icon: Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: Text('Equity'),
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
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                  ),
                  hintText: 'Expense Name',
                  labelText: 'Name',
                  errorText: nameErr ? 'Value can\'t Be Empty' : null,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: queController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Quantity',
                  labelText: 'Quantity',
                  errorText: queErr ? 'Value can\'t Be Empty' : null,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Description',
                  labelText: 'Description',
                  errorText: descriptionErr ? 'Value can\'t Be Empty' : null,
                ),
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
                        nameController.text.isEmpty
                            ? nameErr = true
                            : nameErr = false;
                        queController.text.isEmpty
                            ? queErr = true
                            : queErr = false;
                        descriptionController.text.isEmpty
                            ? descriptionErr = true
                            : descriptionErr = false;
                      });
                      if (nameErr == false &&
                          queErr == false &&
                          descriptionErr == false) {
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
                      nameController.text = '';
                      queController.text = '';
                      descriptionController.text = '';
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

