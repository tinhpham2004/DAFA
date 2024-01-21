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
  AppUser({
    required this.phoneNumber,
  });
}
