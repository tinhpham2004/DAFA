import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  String userId = '';
  String phoneNumber;
  String password = '';
  List<String> images = [];
  String name = '';
  String dateOfBirth = '';
  String gender = '';
  String bio = '';
  GeoPoint coordinate = GeoPoint(0, 0);
  String address = '';
  String height = '';
  String hobby = '';
  bool isOnline = false;
  bool isSearching = false;
  bool isBanned = false;
  DateTime lastActive = DateTime.now();
  String token = '';
  // I want to add these 3 fields in database
  bool isVerified = false;
  String encryptedIdNumber = '';
  int matchingPeopleNumber = 0;
  //
  AppUser({
    required this.phoneNumber,
  });
}
