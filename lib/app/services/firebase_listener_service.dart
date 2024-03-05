import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dafa/app/modules/chat/chat_controller.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseListenerService extends ChangeNotifier {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference matchedListCollection =
      FirebaseFirestore.instance.collection('matchedList');
  final SignInController signInController = Get.find<SignInController>();

  void LoadAllUsersOnlineState() {
    usersCollection.snapshots(includeMetadataChanges: true).listen(
      (otherUsersQuerysnapshot) {
        List<DocumentSnapshot> otherUsers = otherUsersQuerysnapshot.docs;
        otherUsers.forEach(
          (value) {
            String phoneNumber =
                ((value.data() as dynamic)['phoneNumber'] as dynamic)
                    .toString();
            bool isOnline = ((value.data() as dynamic)['isOnline'] as dynamic);
            signInController.listUsersOnlineState[phoneNumber] = isOnline;
          },
        );
        notifyListeners();
      },
    );
  }

  void LoadCompatibleList() {
    bool check = false;
    matchedListCollection
        .doc(signInController.user.phoneNumber)
        .snapshots(includeMetadataChanges: true)
        .listen(
      (value) {
        final compatibleList =
            (value.data() as dynamic)['compatible'] as List<dynamic>;
        compatibleList.forEach((element) {
          if (signInController.compatibleList.contains(element) == false)
            signInController.compatibleList.add(element);
        });
        notifyListeners();
      },
    );
  }

  void LoadAllUsersSearchingState() {
    usersCollection.snapshots(includeMetadataChanges: true).listen(
      (otherUsersQuerysnapshot) {
        List<DocumentSnapshot> otherUsers = otherUsersQuerysnapshot.docs;
        otherUsers.forEach(
          (value) {
            String phoneNumber =
                ((value.data() as dynamic)['phoneNumber'] as dynamic)
                    .toString();
            bool isSearching =
                ((value.data() as dynamic)['isSearching'] as dynamic);
            signInController.listUsersSearchingState[phoneNumber] = isSearching;
          },
        );
        notifyListeners();
      },
    );
  }

  void LoadGraphMatchList() {
    matchedListCollection
        .snapshots(includeMetadataChanges: true)
        .listen((querySnapshot) {
      List<DocumentSnapshot> users = querySnapshot.docs;
      users.forEach((doc) {
        final likeList = (doc.data() as dynamic)['like'] as List<dynamic>;
        final dislikeList = (doc.data() as dynamic)['dislike'] as List<dynamic>;

        users.forEach((doc2) {
          if (signInController.listUsersSearchingState[doc.id] == true &&
              signInController.listUsersSearchingState[doc2.id] == true &&
              doc.id != doc2.id &&
              likeList.contains(doc2.id) == false &&
              dislikeList.contains(doc2.id) == false &&
              (signInController.graphMatchUser[doc.id] == null ||
                  (signInController.graphMatchUser[doc.id] != null &&
                      signInController.graphMatchUser[doc.id]!
                              .contains(doc2.id) ==
                          false))) {
            if (signInController.listUsersGender[doc.id] == 'Man' &&
                signInController.listUsersGender[doc2.id] == 'Woman') {
              if (signInController.graphMatchUser[doc.id] != null) {
                signInController.graphMatchUser[doc.id]!.add(doc2.id);
              } else {
                signInController.graphMatchUser[doc.id] = [doc2.id];
              }
            }
            if (signInController.listUsersGender[doc.id] == 'Woman' &&
                signInController.listUsersGender[doc2.id] == 'Man') {
              if (signInController.graphMatchUser[doc.id] != null) {
                signInController.graphMatchUser[doc.id]!.add(doc2.id);
              } else {
                signInController.graphMatchUser[doc.id] = [doc2.id];
              }
            }
            if (signInController.listUsersGender[doc.id] == 'LGBT' &&
                signInController.listUsersGender[doc2.id] == 'LGBT') {
              if (signInController.graphMatchUser[doc.id] != null) {
                signInController.graphMatchUser[doc.id]!.add(doc2.id);
              } else {
                signInController.graphMatchUser[doc.id] = [doc2.id];
              }
            }
          }
        });
        List<String> liked = [];
        List<String> disliked = [];
        if (signInController.graphMatchUser[doc.id] != null) {
          signInController.graphMatchUser[doc.id]!.forEach(
            (element) {
              if (likeList.contains(element)) liked.add(element);
              if (dislikeList.contains(element)) disliked.add(element);
            },
          );
          liked.forEach(
            (element) {
              signInController.graphMatchUser[doc.id]!.remove(element);
            },
          );
          disliked.forEach(
            (element) {
              signInController.graphMatchUser[doc.id]!.remove(element);
            },
          );
        }
      });
      signInController.graphMatchUser.forEach((key, value) {
        List<String> oneDirEdge = [];
        signInController.graphMatchUser[key]!.forEach((element) {
          if ((signInController.graphMatchUser[element] == null) ||
              (signInController.graphMatchUser[element] != null &&
                  signInController.graphMatchUser[element]!.contains(key) ==
                      false)) {
            oneDirEdge.add(element);
          }
        });
        oneDirEdge.forEach((element) {
          signInController.graphMatchUser[key]!.remove(element);
        });
      });
      notifyListeners();
    });
  }
}
