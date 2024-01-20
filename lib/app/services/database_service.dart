import 'package:dafa/app/models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:get/get.dart';

class DatabaseService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final SignInController signInController = Get.find<SignInController>();

  Future InsertUserData(AppUser user) async {
    return await usersCollection.doc(user.phoneNumber).set({
      'userId': user.userId,
      'phoneNumber': user.phoneNumber,
      'password': user.password,
      'images': user.images,
      'name': user.name,
      'dateOfBirth': user.dateOfBirth,
      'gender': user.gender,
    });
  }

  // ignore: non_constant_identifier_names
  Future Authenticate(String phoneNumber, String password) async {
    DocumentReference documentReference = usersCollection.doc(phoneNumber);
    await documentReference.get().then(
      (DocumentSnapshot documentSnapshot) {
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
      },
    );
  }

    Future UpdateUserData(List<String> images, String name, String dateOfBirth, String gender) async {
    return await usersCollection.doc(signInController.phoneNumberController.text).update({
      'images': images,
      'name': name,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
    });
  }

  Future<bool> FirstTimeUpdate() async {
    bool isFirstTimeUpdate = true;
    await usersCollection
        .doc((signInController.phoneNumberController.text))
        .get()
        .then(
      (doc) {
        if (doc.exists) {
          final images = (doc.data() as dynamic)['images'] as List<dynamic>;
          images.forEach((element) {
            if (element != '') isFirstTimeUpdate = false;
          });
        } else {
          //
        }
      },
    ).catchError(
      (error) {
        //
      },
    );
    return isFirstTimeUpdate;
  }
}
