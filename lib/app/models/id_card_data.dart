import 'package:dafa/app/models/address_entities.dart';

class IDCardData {
  final String id;
  final String idProb;
  final String name;
  final String nameProb;
  final String dob;
  final String dobProb;
  final String sex;
  final String sexProb;
  final String nationality;
  final String nationalityProb;
  final String home;
  final String homeProb;
  final String address;
  final String addressProb;
  final AddressEntities addressEntities;
  final String doe;
  final String doeProb;
  final String type;

  IDCardData({
    required this.id,
    required this.idProb,
    required this.name,
    required this.nameProb,
    required this.dob,
    required this.dobProb,
    required this.sex,
    required this.sexProb,
    required this.nationality,
    required this.nationalityProb,
    required this.home,
    required this.homeProb,
    required this.address,
    required this.addressProb,
    required this.addressEntities,
    required this.doe,
    required this.doeProb,
    required this.type,
  });

  factory IDCardData.fromJson(Map<String, dynamic> json) {
    return IDCardData(
      id: json['id'] ?? '',
      idProb: json['id_prob'] ?? '',
      name: json['name'] ?? '',
      nameProb: json['name_prob'] ?? '',
      dob: json['dob'] ?? '',
      dobProb: json['dob_prob'] ?? '',
      sex: json['sex'] ?? 'N/A',
      sexProb: json['sex_prob'] ?? 'N/A',
      nationality: json['nationality'] ?? 'N/A',
      nationalityProb: json['nationality_prob'] ?? 'N/A',
      home: json['home'] ?? '',
      homeProb: json['home_prob'] ?? '',
      address: json['address'] ?? '',
      addressProb: json['address_prob'] ?? '',
      addressEntities: AddressEntities.fromJson(json['address_entities'] ?? {}),
      doe: json['doe'] ?? 'N/A',
      doeProb: json['doe_prob'] ?? 'N/A',
      type: json['type'] ?? '',
    );
  }
}
