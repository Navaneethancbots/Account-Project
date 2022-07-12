import 'package:account_project/MasterAddPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:string_extensions/string_extensions.dart';

import 'Firestore/Accounts.dart';
import 'FirestoreCRUD.dart';
import 'HomePage.dart';

class MasterPage extends StatefulWidget {
  const MasterPage({Key? key}) : super(key: key);

  @override
  _MasterPageState createState() => _MasterPageState();
}

class _MasterPageState extends State<MasterPage> {

  String? dropdownValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
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
        title: Text('Master',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                fontFamily: 'Poppins',
                color: Colors.white)),
      ),
      body: StreamBuilder<List<Accounts>>(
          stream: read('master_expenses'),
          builder: (context, snapsot) {
            if (snapsot.hasError) {
              return Text('Something went wrong! ${snapsot.error}');
            } else if (snapsot.hasData) {
              final masterExpenses = snapsot.data!;
              return ListView(
                children: masterExpenses.map(buildUser).toList(),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        backgroundColor: Colors.pink[200],
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => MasterAddPage()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildUser(Accounts user) => Card(
    elevation: 0.0,
    color: Colors.grey[200],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16)
    ),
    child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.pink[200],
            child: Text((user.masterName.toString()[0].toUpperCase()),
                style: TextStyle(fontFamily: 'Poppins', fontSize: 20,color: Colors.white)),
          ),
          title: Text(user.masterName.toString().toTitleCase!,
              style: TextStyle(
                fontFamily: 'Poppins',
              )),
          subtitle: Text(user.masterDescription.toString(),
              style: TextStyle(
                fontFamily: 'Poppins',
              )),
          trailing: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () {
                      print("id delete ${user.id}");
                      final docUser = FirebaseFirestore.instance
                          .collection('master_expenses')
                          .doc(user.id);
                      docUser.delete();
                    },
                    icon: Icon(Icons.delete,color: Colors.red[400],)),
              ],
            ),
          ),
        ),
  );

}
