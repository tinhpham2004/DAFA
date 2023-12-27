import 'package:dafa/app/models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future UpdateUserData(AppUser user) async {
    return await usersCollection.doc(user.userId).set({
      'userId': user.userId,
      'phoneNumber': user.phoneNumber,
      'password': user.password,
    });
  }
}
