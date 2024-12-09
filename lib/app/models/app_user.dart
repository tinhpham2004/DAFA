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
  bool isVerified = false;
  String encryptedIdNumber = '';
  String job = '';
  int get age => ((dateOfBirth.split('/').length == 3)
      ? DateTime.now().year - int.tryParse(dateOfBirth.split('/')[2])!
      : 0);

  AppUser({
    required this.phoneNumber,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      phoneNumber: json['phoneNumber'] ?? '',
    )
      ..userId = json['userId'] ?? ''
      ..password = json['password'] ?? ''
      ..images = List<String>.from(json['images'] ?? [])
      ..name = json['name'] ?? ''
      ..dateOfBirth = json['dateOfBirth'] ?? ''
      ..gender = json['gender'] ?? ''
      ..bio = json['bio'] ?? ''
      ..coordinate = GeoPoint(
        json['coordinate']['latitude'] ?? 0,
        json['coordinate']['longitude'] ?? 0,
      )
      ..address = json['address'] ?? ''
      ..height = json['height'] ?? ''
      ..hobby = json['hobby'] ?? ''
      ..isOnline = json['isOnline'] ?? false
      ..isSearching = json['isSearching'] ?? false
      ..isBanned = json['isBanned'] ?? false
      ..lastActive =
          DateTime.parse(json['lastActive'] ?? DateTime.now().toIso8601String())
      ..token = json['token'] ?? ''
      ..isVerified = json['isVerified'] ?? false
      ..encryptedIdNumber = json['encryptedIdNumber'] ?? ''
      ..job = json['job'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'phoneNumber': phoneNumber,
      'password': password,
      'images': images,
      'name': name,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'bio': bio,
      'coordinate': {
        'latitude': coordinate.latitude,
        'longitude': coordinate.longitude,
      },
      'address': address,
      'height': height,
      'hobby': hobby,
      'isOnline': isOnline,
      'isSearching': isSearching,
      'isBanned': isBanned,
      'lastActive': lastActive.toIso8601String(),
      'token': token,
      'isVerified': isVerified,
      'encryptedIdNumber': encryptedIdNumber,
      'job': job,
    };
  }
}
