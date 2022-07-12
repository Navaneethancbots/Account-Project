import 'package:account_project/MasterPage.dart';
import 'package:flutter/material.dart';
import 'Firestore/Accounts.dart';
import 'FirestoreCRUD.dart';

class MasterAddPage extends StatefulWidget {
  const MasterAddPage({Key? key}) : super(key: key);

  @override
  _MasterAddPageState createState() => _MasterAddPageState();
}

class _MasterAddPageState extends State<MasterAddPage> {

  var masterNameController = TextEditingController();
  var masterDescriptionController = TextEditingController();

  bool masterNameErr = false;
  bool masterUOMErr = false;
  bool masterDescriptionErr = false;

  String? masterUOM;

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
        backgroundColor: Colors.deepPurple,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MasterPage()));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: Text('Add New Master',
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
                padding: EdgeInsets.only(left: 15, right: 15),
                child: TextField(
                  cursorColor: Colors.deepPurple,
                  style: TextStyle(fontFamily: 'Poppins'),
                  controller: masterNameController,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple)
                    ),
                    labelText: 'Expense Name',
                    labelStyle: TextStyle(fontFamily: 'Poppins',color: Colors.deepPurple),
                    errorText: masterNameErr ? 'Value can\'t Be Empty' : null,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: DropdownButton<String>(
                  alignment: Alignment.topLeft,
                  hint: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: Text(
                        "UOM",
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontFamily: 'Poppins',
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ), //and here
                  isExpanded: true,
                  value: masterUOM,
                  icon: const Icon(Icons.arrow_drop_down_sharp),
                  style: const TextStyle(
                      color: Colors.black, fontFamily: 'Poppins', fontSize: 16),
                  underline: Container(
                    height: 1,
                    color: Colors.black38,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      masterUOM = newValue!;
                    });
                  },
                  items: <String>[
                    'Ltr',
                    'Nos',
                    'Kg',
                  ].map<DropdownMenuItem<String>>((String value) {
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
                padding: EdgeInsets.only(left: 15, right: 15),
                child: TextField(
                  cursorColor: Colors.deepPurple,
                  style: TextStyle(fontFamily: 'Poppins'),
                  controller: masterDescriptionController,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple)
                    ),
                    labelText: 'Description',
                    labelStyle: TextStyle(fontFamily: 'Poppins',color: Colors.deepPurple),
                    errorText: masterDescriptionErr ? 'Value can\'t Be Empty' : null,
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
                          masterNameController.text.isEmpty
                              ? masterNameErr = true
                              : masterNameErr = false;
                          masterDescriptionController.text.isEmpty
                              ? masterDescriptionErr = true
                              : masterDescriptionErr = false;
                          if (masterNameController.text.isNotEmpty &&
                              masterDescriptionController.text.isNotEmpty &&
                              masterUOM == null) {
                            _showSuccessSnackBar(
                              'select Item Type',
                            );
                          }
                        });

                        if (masterNameErr == false &&
                            masterDescriptionErr == false &&
                            masterUOM != null) {
                          final user = Accounts(
                              masterName: masterNameController.text,
                              masterUOM: masterUOM,
                              masterDescription: masterDescriptionController.text);
                              createMaster(user,"master_expenses");
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MasterPage()));
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
