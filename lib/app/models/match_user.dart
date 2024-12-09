import 'dart:convert';

import 'package:dafa/app/models/app_user.dart';

class MatchUser {
  AppUser? user;
  double distance;

  MatchUser({
    required this.user,
    required this.distance,
  });

  factory MatchUser.fromJson(Map<String, dynamic> json) {
    return MatchUser(
      user: json['user'] != null ? AppUser.fromJson(jsonDecode(json['user'])) : null,
      distance: double.parse(json['distance']),
    );
  }

  Map<String, String> toJson() {
    return {
      'user': user != null ? jsonEncode(user!.toJson()) : '',
      'distance': distance.toString(),
    };
  }
}
