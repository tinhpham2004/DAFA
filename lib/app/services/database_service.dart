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
      'bio': user.bio,
      'height': user.height,
      'coordinate': user.coordinate,
      'address': user.address,
      'hobby': user.hobby,
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

  Future UpdateUserData(AppUser user) async {
    return await usersCollection
        .doc(signInController.phoneNumberController.text)
        .update({
      'userId': user.userId,
      'phoneNumber': user.phoneNumber,
      'images': user.images,
      'name': user.name,
      'dateOfBirth': user.dateOfBirth,
      'bio': user.bio,
      'gender': user.gender,
      'height': user.height,
      'coordinate': user.coordinate,
      'address': user.address,
      'hobby': user.hobby,
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

  Future<AppUser> LoadUserData() async {
    AppUser user = AppUser(
      phoneNumber: '',
    );
    await usersCollection
        .doc(signInController.phoneNumberController.text)
        .get()
        .then(
      (value) {
        final _images = (value.data() as dynamic)['images'] as List<dynamic>;
        _images.forEach((element) {
          user.images.add(element.toString());
        });
        user.userId =
            ((value.data() as dynamic)['userId'] as dynamic).toString();
        user.phoneNumber =
            ((value.data() as dynamic)['phoneNumber'] as dynamic).toString();
        user.name = ((value.data() as dynamic)['name'] as dynamic).toString();
        user.gender =
            ((value.data() as dynamic)['gender'] as dynamic).toString();
        user.dateOfBirth =
            ((value.data() as dynamic)['dateOfBirth'] as dynamic).toString();
        user.bio = ((value.data() as dynamic)['bio'] as dynamic).toString();
        user.address =
            ((value.data() as dynamic)['address'] as dynamic).toString();
        user.coordinate = ((value.data() as dynamic)['coordinate'] as dynamic);
        user.height =
            ((value.data() as dynamic)['height'] as dynamic).toString();
        user.hobby = ((value.data() as dynamic)['hobby'] as dynamic).toString();
      },
    );
    return user;
  }
}
