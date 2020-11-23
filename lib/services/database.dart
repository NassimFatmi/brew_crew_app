import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_world/models/Brew.dart';
import 'package:hello_world/models/appuser.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  List<Brew> createBrewList(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => Brew(
            name: doc.data()['name'],
            strength: doc.data()['strength'],
            sugars: doc.data()['sugars']))
        .toList();
  }

  // Collection reference
  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data()['name'],
      strength: snapshot.data()['strength'],
      sugars: snapshot.data()['sugars'],
    );
  }

  // update user data

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.document(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(createBrewList);
  }

  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
