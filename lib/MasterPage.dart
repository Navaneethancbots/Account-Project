import 'package:account_project/MasterAddPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Firestore/User.dart';
import 'HomePage.dart';

class MasterPage extends StatefulWidget {
  const MasterPage({Key? key}) : super(key: key);

  @override
  _MasterPageState createState() => _MasterPageState();
}

class _MasterPageState extends State<MasterPage> {

  List<String> items = [];

  String? dropdownValue ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
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
        title: Text('Master',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                fontFamily: 'Poppins',
                color: Colors.black)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: IconButton(onPressed:()async{
              final instance = FirebaseFirestore.instance;
              final batch = instance.batch();
              var collection = instance.collection('master_expenses');
              var snapshots = await collection.get();
              for (var doc in snapshots.docs) {
                batch.delete(doc.reference);
              }
              await batch.commit();

            }, icon:Icon(Icons.delete,color: Colors.black,)),
          )
        ],
      ),
      body:
      StreamBuilder<List<User>>(
        stream: readUsers(),
        builder: (context, snapsot) {
          if (snapsot.hasError) {
            return Text('Something went wrong! ${snapsot.error}');
          } else if (snapsot.hasData) {
            final masterexpenses = snapsot.data!;
            return ListView(
              children: masterexpenses.map(buildUser).toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => MasterAddPage()));
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget buildUser(User user) =>
  ListTile(
        leading: CircleAvatar(
           child: Text((user.expenseName.toString()[0].toUpperCase()),style: TextStyle(fontFamily: 'Poppins',fontSize: 20) ),

        ),
        title: Text(user.expenseName.toString(),style: TextStyle(fontFamily: 'Poppins',)),
        subtitle: Text(user.decription.toString(),style: TextStyle(fontFamily: 'Poppins',)),
        trailing: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(onPressed: (){
                print("id delete ${user.id}");
                final docUser = FirebaseFirestore.instance.collection('master_expenses').doc(user.id);
                docUser.delete();
              }, icon: Icon(Icons.delete)),
            ],
          ),
        ),
  );

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection('master_expenses')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
}
