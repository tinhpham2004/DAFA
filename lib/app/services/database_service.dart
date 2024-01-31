import 'dart:math';

import 'package:dafa/app/models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dafa/app/models/match_user.dart';
import 'package:dafa/app/models/message.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:get/get.dart';

class DatabaseService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference matchedListCollection =
      FirebaseFirestore.instance.collection('matchedList');
  final CollectionReference messagesCollection =
      FirebaseFirestore.instance.collection('messages');
  final CollectionReference reportCollection =
      FirebaseFirestore.instance.collection('report');
  final SignInController signInController = Get.find<SignInController>();

  Future InsertUserData(AppUser user) async {
    await usersCollection.doc(user.phoneNumber).set({
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
      'isOnline': user.isOnline,
      'isSearching': user.isSearching,
      'lastActive': user.lastActive,
    });
    await matchedListCollection.doc(user.phoneNumber).set(
      {
        'like': [],
        'dislike': [],
        'compatible': [],
      },
    );
    await reportCollection.doc(user.phoneNumber).set(
      {
        'reporters': [],
      },
    );
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
      'isOnline': user.isOnline,
      'isSearching': user.isSearching,
      'lastActive': user.lastActive,
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
        user.isOnline = ((value.data() as dynamic)['isOnline'] as dynamic);
        user.isSearching =
            ((value.data() as dynamic)['isSearching'] as dynamic);
        user.lastActive =
            ((value.data() as dynamic)['lastActive'] as Timestamp).toDate();
      },
    );
    return user;
  }

  Future<List<MatchUser>> LoadMatchList(AppUser appUser) async {
    List<MatchUser> matchList = [];
    await usersCollection.get().then(
      (otherUsersQuerysnapshot) {
        List<DocumentSnapshot> otherUsers = otherUsersQuerysnapshot.docs;
        otherUsers.forEach(
          (value) {
            String phoneNumber =
                ((value.data() as dynamic)['phoneNumber'] as dynamic)
                    .toString();
            AppUser user = AppUser(phoneNumber: phoneNumber);
            final _images =
                (value.data() as dynamic)['images'] as List<dynamic>;
            _images.forEach((element) {
              user.images.add(element.toString());
            });
            user.userId =
                ((value.data() as dynamic)['userId'] as dynamic).toString();
            user.name =
                ((value.data() as dynamic)['name'] as dynamic).toString();
            user.gender =
                ((value.data() as dynamic)['gender'] as dynamic).toString();
            user.dateOfBirth =
                ((value.data() as dynamic)['dateOfBirth'] as dynamic)
                    .toString();
            user.bio = ((value.data() as dynamic)['bio'] as dynamic).toString();
            user.address =
                ((value.data() as dynamic)['address'] as dynamic).toString();
            user.coordinate =
                ((value.data() as dynamic)['coordinate'] as dynamic);
            user.height =
                ((value.data() as dynamic)['height'] as dynamic).toString();
            user.hobby =
                ((value.data() as dynamic)['hobby'] as dynamic).toString();
            user.isOnline = ((value.data() as dynamic)['isOnline'] as dynamic);
            user.isSearching =
                ((value.data() as dynamic)['isSearching'] as dynamic);
            user.lastActive =
                ((value.data() as dynamic)['lastActive'] as Timestamp).toDate();

            signInController.listUsersGender[user.phoneNumber] = user.gender;

            double distance = calculateDistance(
                appUser.coordinate.latitude,
                appUser.coordinate.longitude,
                user.coordinate.latitude,
                user.coordinate.longitude);
            if (appUser.gender == "Man" && user.gender == "Woman")
              matchList.add(MatchUser(user: user, distance: distance));
            if (appUser.gender == "Woman" && user.gender == "Man")
              matchList.add(MatchUser(user: user, distance: distance));
            if (appUser.phoneNumber != user.phoneNumber &&
                appUser.gender == "LGBT" &&
                user.gender == "LGBT")
              matchList.add(MatchUser(user: user, distance: distance));
          },
        );
      },
    );
    List<MatchUser> hobbyMatchList = [];
    List<MatchUser> distanceMatchList = [];
    matchList.forEach(
      (user) {
        if (appUser.hobby == user.user!.hobby)
          hobbyMatchList.add(user);
        else
          distanceMatchList.add(user);
      },
    );

    for (int i = 0; i < hobbyMatchList.length - 1; i++) {
      for (int j = i + 1; j < hobbyMatchList.length; j++) {
        if (hobbyMatchList[i].distance > hobbyMatchList[j].distance) {
          MatchUser temp = hobbyMatchList[i];
          hobbyMatchList[i] = hobbyMatchList[j];
          hobbyMatchList[j] = temp;
        }
      }
    }

    for (int i = 0; i < distanceMatchList.length - 1; i++) {
      for (int j = i + 1; j < distanceMatchList.length; j++) {
        if (distanceMatchList[i].distance > distanceMatchList[j].distance) {
          MatchUser temp = distanceMatchList[i];
          distanceMatchList[i] = distanceMatchList[j];
          distanceMatchList[j] = temp;
        }
      }
    }

    matchList.clear();
    hobbyMatchList.forEach(
      (user) {
        matchList.add(user);
      },
    );
    distanceMatchList.forEach(
      (user) {
        matchList.add(user);
      },
    );
    matchList.forEach(
      (element) {
        signInController.matchListForChat.add(element);
      },
    );
    List<int> matchedListId = [];
    for (int index = 0; index < matchList.length; index++) {
      for (int j = 0; j < signInController.likeList.length; j++) {
        if (matchList[index].user!.phoneNumber ==
            signInController.likeList[j]) {
          matchedListId.add(index);
        }
      }
      if (matchedListId.length == 0 ||
          (matchedListId.length > 0 &&
              matchedListId[matchedListId.length - 1] != index))
        for (int j = 0; j < signInController.dislikeList.length; j++) {
          if (matchList[index].user!.phoneNumber ==
              signInController.dislikeList[j]) {
            matchedListId.add(index);
          }
        }
    }
    for (int index = matchedListId.length - 1; index >= 0; index--) {
      matchList.removeAt(matchedListId[index]);
    }
    return matchList;
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Future<void> UpdateMatchedList() async {
    await matchedListCollection.doc(signInController.user.phoneNumber).set(
      {
        'like': signInController.likeList,
        'dislike': signInController.dislikeList,
        'compatible': signInController.compatibleList,
      },
    );
  }

  Future<void> LoadMatchedList() async {
    await matchedListCollection
        .doc(signInController.user.phoneNumber)
        .get()
        .then(
      (docs) {
        final likeList = (docs.data() as dynamic)['like'] as List<dynamic>;
        final dislikeList =
            (docs.data() as dynamic)['dislike'] as List<dynamic>;
        final compatibleList =
            (docs.data() as dynamic)['compatible'] as List<dynamic>;
        likeList.forEach(
          (element) {
            signInController.likeList.add(element);
          },
        );
        dislikeList.forEach(
          (element) {
            signInController.dislikeList.add(element);
          },
        );
        compatibleList.forEach(
          (element) {
            signInController.compatibleList.add(element);
          },
        );
      },
    );
  }

  Future<void> UpdateCompatibleList(String phoneNumber) async {
    await matchedListCollection.doc(phoneNumber).get().then(
      (docs) async {
        final compatibleList =
            (docs.data() as dynamic)['compatible'] as List<dynamic>;
        compatibleList.add(signInController.user.phoneNumber);
        await matchedListCollection.doc(phoneNumber).update(
          {
            'compatible': compatibleList,
          },
        );
      },
    );
  }

  Future<bool> CheckIsLike(String phoneNumber) async {
    bool check = false;
    await matchedListCollection.doc(phoneNumber).get().then(
      (docs) {
        final likeList = (docs.data() as dynamic)['like'] as List<dynamic>;
        likeList.forEach(
          (value) {
            if (value == signInController.user.phoneNumber) check = true;
          },
        );
      },
    );
    return check;
  }

  Future<void> SendMessage(Message message) async {
    await messagesCollection.doc().set({
      'sender': message.sender,
      'receiver': message.receiver,
      'content': message.content,
      'time': message.time,
    });
  }

  Future<bool> IsReported(String reportedUser) async {
    bool isReported = false;
    await reportCollection.doc(reportedUser).get().then(
      (docs) async {
        final reportersList =
            (docs.data() as dynamic)['reporters'] as List<dynamic>;

        isReported = reportersList.contains(signInController.user.phoneNumber);
      },
    );
    return isReported;
  }

  Future<void> Report(String reportedUser) async {
    await reportCollection.doc(reportedUser).get().then(
      (docs) async {
        final reportersList =
            (docs.data() as dynamic)['reporters'] as List<dynamic>;
        if (reportersList.contains(signInController.user.phoneNumber) ==
            false) {
          reportersList.add(signInController.user.phoneNumber);

          await reportCollection.doc(reportedUser).update(
            {
              'reporters': reportersList,
            },
          );
        }
      },
    );
  }
}
