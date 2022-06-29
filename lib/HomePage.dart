import 'package:account_project/EquityPage.dart';
import 'package:account_project/ExpensePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:account_project/Login/LoginPage.dart';
import 'package:account_project/Firestore/User.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'MasterPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'ACCOUNT ',
          style: TextStyle(
              fontSize: 20,
              fontFamily: 'poppins',
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        actions: [
          FlatButton(
            //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            //color: Colors.blue[800],
            child: Text(
              'Logout',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w700),
            ),
            onPressed: () {
            //  auth.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      drawer: Container(
        width: 250,
        child: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Center(child: Text('Account',style: TextStyle(fontFamily: 'poppins',fontSize: 30,color: Colors.white),)),
              ),
              ListTile(
                title: const Text('Expense' ,style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 20),),
                onTap: () {

                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Master',style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 20),),
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MasterPage()));
                },
              ),
              ListTile(
                title: const Text('About',style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 20),),
                onTap: () {

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      body:StreamBuilder<List<User>>(
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
      floatingActionButton: SpeedDial(
        marginBottom: 10,
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: Colors.grey,
        foregroundColor: Colors.white,
        activeBackgroundColor: Colors.deepPurpleAccent,
        activeForegroundColor: Colors.white,
        buttonSize: 56.0, //button size
        visible: true,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),

        elevation: 8.0, //shadow elevation of button
        shape: CircleBorder(), //shape of button

        children: [
          SpeedDialChild( //speed dial child
            child: Icon(Icons.account_balance_wallet),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            label: 'Expense',
            labelStyle: TextStyle(fontSize: 18.0,fontFamily: 'Poppins'),
            onLongPress: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ExpensePage())),
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ExpensePage())),
          ),
          SpeedDialChild(
            child: Icon(Icons.account_balance),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            label: 'Equity',
            labelStyle: TextStyle(fontSize: 18.0,fontFamily: 'Poppins'),
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>EquityPage())),
            onLongPress: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>EquityPage())),
          ),

          //add more menu item childs here
        ],
      ),
        // floatingActionButton: PopupMenuButton(
        //   // add icon, by default "3 dot" icon
        //   icon: Icon(Icons.add,color: Colors.black,),
        //     itemBuilder: (context){
        //       return [
        //         PopupMenuItem<int>(
        //           value: 0,
        //           child: Text("Expense"),
        //         ),
        //
        //         PopupMenuItem<int>(
        //           value: 1,
        //           child: Text("Equity"),
        //         ),
        //       ];
        //     },
        //     onSelected:(value){
        //       if(value == 0){
        //         print("Expenses menu is selected.");
        //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ExpensePage()));
        //       }else if(value == 1){
        //         print("Equity menu is selected.");
        //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>EquityPage()));
        //       }
        //     }
        // ),
    );
  }
   Widget buildUser(User user) =>Column(
     children: <Widget>[
       Padding(
         padding: const EdgeInsets.only(right: 250),
         child: Text('${user.date.toString()}',style: TextStyle(fontFamily: 'Poppins',fontSize: 16,fontWeight: FontWeight.bold),),
       ),
       SizedBox(
         height: 80,
         child: Card(
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
           color: Colors.grey[300],
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: <Widget>[
               Column(
                 children: [
                   Text('Owner\'s Equity',style: TextStyle(fontFamily: 'Poppins',fontSize: 16,fontWeight: FontWeight.bold),),
                   SizedBox(
                     height: 15,
                   ),
                   Expanded(
                     child: Container(
                       child: Text('${user.totalAmount.toString()}',style: TextStyle(fontFamily: 'Poppins',fontSize: 16),),

                     ),
                   ),
                 ],
               ),
               Column(
                 children: [
                   Text('Expense',style: TextStyle(fontFamily: 'Poppins',fontSize: 16,fontWeight: FontWeight.bold),),
                   SizedBox(
                     height: 15,
                   ),
                   Expanded(
                     child: Container(
                       child: Text('1000',style: TextStyle(fontFamily: 'Poppins',fontSize: 16),),

                     ),
                   ),
                 ],
               ),
               Column(
                 children: [
                   Text('Balance',style: TextStyle(fontFamily: 'Poppins',fontSize: 16,fontWeight: FontWeight.bold),),
                   SizedBox(
                     height: 15,
                   ),
                   Expanded(
                     child: Container(
                       child: Text('9000',style: TextStyle(fontFamily: 'Poppins',fontSize: 16),),

                     ),
                   ),
                 ],
               ),
             ],
           ),
         ),
       ),
     ],
   );


  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection('Equity')
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
}
