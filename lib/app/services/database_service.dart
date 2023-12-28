import 'package:dafa/app/models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:get/get.dart';

class DatabaseService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final SignInController signInController = Get.find<SignInController>();

  Future UpdateUserData(AppUser user) async {
    return await usersCollection.doc(user.phoneNumber).set({
      'userId': user.userId,
      'phoneNumber': user.phoneNumber,
      'password': user.password,
    });
  }

  // ignore: non_constant_identifier_names
  void Authenticate(String phoneNumber, String password) async {
    phoneNumber = phoneNumber.substring(1);
    DocumentReference documentReference = usersCollection.doc(phoneNumber);
    await documentReference.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        String actualPassword = documentSnapshot.get("password");
        if (password == actualPassword) {
          signInController.UpdateSignInState('Sign in successfully.');
        } else {
          signInController.UpdateSignInState(
              'The account or password is incorrect.');
        }
      } else {
        signInController.UpdateSignInState(
            'The account or password is incorrect.');
      }
    });
  }
}
