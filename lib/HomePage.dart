import 'package:account_project/EquityPage.dart';
import 'package:account_project/ExpensePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:account_project/Login/LoginPage.dart';
import 'package:account_project/Firestore/Accounts.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:string_extensions/string_extensions.dart';
import 'FirestoreCRUD.dart';
import 'MasterPage.dart';
String Currency = '₹';



class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  double mothlyExpenseTotal = 0;

  @override
  void initState() {
    super.initState();
    Currency;
  }

  setSelectedRadio(String val){
    setState(() {
      Currency = val;
    });
  }



  bool isExpanded = false;

  final money = NumberFormat('#,##0','en_US');

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.deepPurple,

      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'TRANSACTIONS',
          style: TextStyle(
              fontSize: 20,
              fontFamily: 'poppins',
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        actions: [
          FlatButton(
            //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            //color: Colors.blue[800],
            child: Text(
              'Logout',
              style: TextStyle(
                  color: Colors.white,
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

      drawer: Container(
        width: 250,
        child: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            children: [
               DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.deepPurple
                 // color: Color(0xFFF48FB1),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.pink[200],
                      child: Center(
                        child: Text((userEmail.toString()[0].toUpperCase()),
                            style: TextStyle(fontFamily: 'Poppins', fontSize: 30,color: Colors.white)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      userEmail.toTitleCase!,
                      style: TextStyle(
                      fontFamily: 'poppins', fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: const Text(
                  'Expense',
                  style: TextStyle(fontFamily: 'poppins', fontSize: 20),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text(
                  'Master',
                  style: TextStyle(fontFamily: 'poppins', fontSize: 20),
                ),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MasterPage()));
                },
              ),
              ListTile(
                title: const Text(
                  'Setting',
                  style: TextStyle(fontFamily: 'poppins', fontSize: 20),
                ),
                onTap: () {

                  //radio();
                   showAlertDialog(context);
                 // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> RadioPage()));
                },
              ),
              ListTile(
                title: const Text(
                  'About',
                  style: TextStyle(fontFamily: 'poppins', fontSize: 20),
                ),
                onTap: () {
                  showAboutDialog(
                    useRootNavigator: true,
                    context: context,
                    applicationIcon: FlutterLogo(),
                    applicationName: 'account_project',
                    applicationVersion: '1.0.0+1',
                    //applicationLegalese: '',
                  );
                },
              ),

            ],
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    //side: BorderSide(color: Colors.purpleAccent),
                    borderRadius: BorderRadius.circular(16)),
                color: Colors.white10,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: [
                          Text(
                            'Equity',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          StreamBuilder<List<Accounts>>(

                              stream: read('Expense'),

                              builder: (context, snapsot) {

                                if (snapsot.hasError) {

                                  return Text('Something went wrong! ${snapsot.error}');

                                }

                                else if (snapsot.hasData) {

                                  mothlyExpenseTotal = 0;

                                  final Expenses = snapsot.data!;

                                  Expenses.forEach((element) {

                                    mothlyExpenseTotal += element.expenseTotalAmount!;

                                  });

                                  return Column();
    }
                                 else {

                                  return Center(

                                    child: CircularProgressIndicator(),

                                  );
                                }
                              }),
                          Expanded(
                            child: Container(
                              child: Text('${Currency}10000',
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 16,color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: 70,
                          child: VerticalDivider(
                            color: Colors.black38,
                            thickness: 1,
                          )),
                      Column(
                        children: [
                          Text(
                            'Expense',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Expanded(
                            child: Container(
                              child: Text(
                                '${Currency} ${mothlyExpenseTotal}',
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 16,color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: 70,
                          child: VerticalDivider(
                            color: Colors.black38,
                            thickness: 1,
                          )),
                      Column(
                        children: [
                          Text(
                            'Balance',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Expanded(
                            child: Container(
                              child: Text(
                                '${Currency}9000',
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 16,color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5,bottom: 0,left: 10,right: 10),
                   child:
                   StreamBuilder<List<Accounts>>(
                      stream: read('Expense'),
                      builder: (context, snapsot) {
                        if (snapsot.hasError) {
                          return Text('Something went wrong! ${snapsot.error}');
                        } else if (snapsot.hasData) {

                          var Expense = snapsot.data!;

                           return GroupedListView<Accounts, String>(
                             elements: Expense,
                             physics: BouncingScrollPhysics(),
                             scrollDirection: Axis.vertical,
                             shrinkWrap: true,
                             groupBy: (element) => element.expenseDate == DateFormat("yyyy-MM-dd").format(DateTime.now()) ? "Today" : element.expenseDate.toString(),
                             groupComparator: (value1,
                                 value2) => value2.compareTo(value1),
                             // itemComparator: (item1, item2) =>
                               //   item1['topicName'].compareTo(item2['topicName']),
                             order: GroupedListOrder.ASC,
                             // useStickyGroupSeparators: true,
                             groupSeparatorBuilder: (String value) => Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Text(
                                 value,
                                 textAlign: TextAlign.left,
                                 style: TextStyle(fontSize: 18,
                                     fontWeight: FontWeight.bold),
                               ),
                             ),
                             itemBuilder: (c, element) {
                               return Card(
                                 elevation: 0.0,
                                 color: Colors.grey[200],
                                 shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(16)
                                 ),
                                 child: ExpansionTile(
                                   onExpansionChanged: (bool expanding) => setState(() => this.isExpanded = expanding),
                                   leading: CircleAvatar(
                                     backgroundColor: Colors.pink[200],
                                     child: Center(
                                       child: Text((element.expenseSelectItem.toString()[0].toUpperCase()),
                                           style: TextStyle(fontFamily: 'Poppins', fontSize: 18,color: Colors.white)),
                                     ),
                                   ),
                                   title: Text(element.expenseSelectItem.toString().toTitleCase!,
                                       style: TextStyle(
                                           fontFamily: 'Poppins',color: isExpanded ? Colors.deepPurple : Colors.black
                                       )),

                                   trailing: Text('$Currency${element.expenseTotalAmount}',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Poppins',color: isExpanded ? Colors.deepPurple : Colors.black),),
                                   children: <Widget>[
                                     SizedBox(
                                       height: 100,
                                       child: Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Card(
                                           color: Colors.white,
                                           elevation: 0.0,
                                           shape: RoundedRectangleBorder(
                                               borderRadius: BorderRadius.circular(16)),
                                           child: Padding(
                                             padding: const EdgeInsets.only(top: 10),
                                             child: Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                               children: [
                                                 Column(
                                                   children: [
                                                     Text('Date',style: TextStyle(fontFamily: 'Poppins',color: Colors.black,fontWeight: FontWeight.bold),),
                                                     SizedBox(
                                                       height: 10,
                                                     ),
                                                     Text('${element.expenseDate}',style: TextStyle(fontFamily: 'Poppins',color: Colors.black),)
                                                   ],
                                                 ),
                                                 Column(
                                                   children: [
                                                     Text('Qty',style: TextStyle(fontFamily: 'Poppins',color: Colors.black,fontWeight: FontWeight.bold),),
                                                     SizedBox(
                                                       height: 10,
                                                     ),
                                                     Text('${element.expenseMeasure}',style: TextStyle(fontFamily: 'Poppins',color: Colors.black),)
                                                   ],
                                                 ),
                                                 Column(
                                                   children: [
                                                     Text('Rate',style: TextStyle(fontFamily: 'Poppins',color: Colors.black,fontWeight: FontWeight.bold),),
                                                     SizedBox(
                                                       height: 10,
                                                     ),
                                                     Text('$Currency${element.expenseAmount}',style: TextStyle(fontFamily: 'Poppins',color: Colors.black),),
                                                   ],
                                                 ),
                                               ],
                                             ),
                                           ),
                                         ),
                                       ),
                                     ),


                                   ],
                                 ),
                               );
                             },
                           );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),

                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: SpeedDial(
        marginBottom: 10,
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: Colors.pink[200],
        foregroundColor: Colors.white,
        activeBackgroundColor: Colors.pink[200],
        activeForegroundColor: Colors.white,
        buttonSize: 56.0, //button size
        visible: true,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        // onOpen: () =>
        // onClose: () =>

        elevation: 8.0, //shadow elevation of button
        shape: CircleBorder(), //shape of button

        children: [
          SpeedDialChild(
            labelBackgroundColor: Colors.grey[300],
            child: Icon(Icons.account_balance_wallet),
            backgroundColor: Colors.pink[200],
            foregroundColor: Colors.grey[300],
            label: 'Expense',
            labelStyle: TextStyle(fontSize: 18.0, fontFamily: 'Poppins'),
            onLongPress: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => ExpensePage())),
            onTap: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => ExpensePage())),
          ),
          SpeedDialChild(
            labelBackgroundColor: Colors.grey[300],
            child: Icon(Icons.account_balance),
            backgroundColor: Colors.pink[200],
            foregroundColor: Colors.grey[300],
            label: 'Equity',
            labelStyle: TextStyle(fontSize: 18.0, fontFamily: 'Poppins'),
            onTap: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => EquityPage())),
            onLongPress: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => EquityPage())),
          ),


        ],
      ),

    );

  }
  showAlertDialog(BuildContext context) {
     AlertDialog alert = AlertDialog(
       actionsAlignment: MainAxisAlignment.start,
      //title: Center(child: Text("Setting",style: TextStyle(fontFamily: 'Poppins',fontSize: 20),)),
      actions: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text('Settings',style: TextStyle(fontFamily: 'Poppins',fontWeight: FontWeight.bold,fontSize: 20),)),
            SizedBox(
              height: 5,
            ),
            Text('Currency :',style: TextStyle(fontFamily: 'Poppins',fontWeight: FontWeight.bold),),
            Padding(
              padding: const EdgeInsets.only(left:50),
              child: Row(
                children: <Widget>[
                  Radio(
                    value: '₹',
                    groupValue: Currency,
                    activeColor: Colors.deepPurple,
                    onChanged: (val) {
                      setSelectedRadio(val as String);
                      print(val);
                      Navigator.pop(context);
                    },
                  ),
                  Text('₹'),
                  SizedBox(
                    width: 20,
                  ),
                  Radio(
                    // title: Text('\$'),
                    value: '\$',
                    groupValue: Currency,
                    activeColor: Colors.deepPurple,
                    onChanged: ( val) {
                      setSelectedRadio(val as String);
                      print(val);
                      Navigator.pop(context);
                    },
                  ),
                  Text('\$'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


}
