class AppUser {
  String userId;
  String phoneNumber;
  String password;
  List<String> images;
  String name;
  String dateOfBirth;
  String gender;
  AppUser({
    required this.userId,
    required this.phoneNumber,
    required this.password,
    required this.images,
    required this.name,
    required this.dateOfBirth,
    required this.gender,
  });
}
