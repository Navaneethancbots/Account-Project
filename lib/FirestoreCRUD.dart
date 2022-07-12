import 'package:cloud_firestore/cloud_firestore.dart';

import 'Firestore/Accounts.dart';

Future createMaster(Accounts accounts, String name) async {

  final docUser = FirebaseFirestore.instance.collection(name).doc();

  accounts.id = docUser.id;

  final json = (name == 'master_expenses')  ?
        accounts.Master() : (name == 'Equity') ?
        accounts.equity() : (name == 'Expense') ?
        accounts.Expense() : null ;

  await docUser.set(json!);

}


Stream<List<Accounts>> read(name) {

  return FirebaseFirestore.instance

      .collection(name)

      .snapshots()

      .map((snapshot) =>

      snapshot.docs.map((doc) => Accounts.fromJson(doc.data())).toList());

}

