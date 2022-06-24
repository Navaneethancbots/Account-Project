import 'package:account_project/EquityPage.dart';
import 'package:account_project/ExpensePage.dart';
import 'package:account_project/MasterPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:account_project/Login/LoginPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: PopupMenuButton(
          // add icon, by default "3 dot" icon
          icon: Icon(Icons.menu,color: Colors.teal,),
            itemBuilder: (context){
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text("Expenses"),
                ),

                PopupMenuItem<int>(
                  value: 1,
                  child: Text("Master"),
                ),

                PopupMenuItem<int>(
                  value: 2,
                  child: Text("About"),
                ),
              ];
            },
            onSelected:(value){
              if(value == 0){
                print("Expenses menu is selected.");
              }else if(value == 1){
                print("Master menu is selected.");
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MasterPage()));
              }else if(value == 2){
                print("About menu is selected.");
              }
            }
        ),
        title: Text(
          'ACCOUNT ',
          style: TextStyle(
              fontSize: 20,
              fontFamily: 'poppins',
              fontWeight: FontWeight.bold,
              color: Colors.teal),
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
              auth.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 80,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              color: Colors.grey[300],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(),
                  Column(
                    children: [
                      Text('Owner\'s Equity',style: TextStyle(fontFamily: 'Poppins',fontSize: 16,fontWeight: FontWeight.bold),),
                      SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: Container(
                          child: Text('10000',style: TextStyle(fontFamily: 'Poppins',fontSize: 16),),

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
      ),
        floatingActionButton: PopupMenuButton(
          // add icon, by default "3 dot" icon
          icon: Icon(Icons.add,color: Colors.teal,),
            itemBuilder: (context){
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text("Expense"),
                ),

                PopupMenuItem<int>(
                  value: 1,
                  child: Text("Equity"),
                ),
              ];
            },
            onSelected:(value){
              if(value == 0){
                print("Expenses menu is selected.");
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ExpensePage()));
              }else if(value == 1){
                print("Equity menu is selected.");
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>EquityPage()));
              }
            }
        ),
    );
  }
}

// class HomePage extends StatelessWidget {
//   HomePage({Key? key}) : super(key: key);
//   final auth = FirebaseAuth.instance;
//
//   TextEditingController nameController = TextEditingController();
//   TextEditingController ageController = TextEditingController();
//   // TextEditingController birthdayController = TextEditingController();
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.teal,
//         centerTitle: true,
//         title: Text('ACCOUNT ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
//         actions: [FlatButton(
//           //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           //color: Colors.blue[800],
//           child: Text('Signout',style: TextStyle(color: Colors.white,fontFamily: 'poppins',fontWeight: FontWeight.w900),),onPressed: (){
//           auth.signOut();
//           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginPage()),);
//         },),
//         ],
//       ),
//       body: Column(
//
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           TextField(
//             controller: nameController,
//             decoration: InputDecoration(
//               labelText: 'Enter your name',
//             ),
//           ),
//           TextField(
//             controller: ageController,
//             decoration: InputDecoration(
//               labelText: 'Enter your age',
//             ),
//           ),
//           // TextField(
//           //   controller: birthdayController,
//           //   decoration: InputDecoration(
//           //     labelText: 'Enter your birthday',
//           //   ),
//           // ),
//           ElevatedButton(onPressed: (){
//
//
//             var user = User();
//             createUser(user);
//             Navigator.pop(context);
//           }, child: Text('Create')),
//         ],
//       ),
//     );
//   }
//   Future createUser(User user)async{
//     final docUser = FirebaseFirestore.instance.collection('Account').doc();
//
//     user.id = docUser.id;
//
//     final json = user.toJson();
//
//     await docUser.set(json);
//   }
//
// }
