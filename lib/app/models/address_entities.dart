class AddressEntities {
  final String province;
  final String district;
  final String ward;
  final String street;

  AddressEntities({
    required this.province,
    required this.district,
    required this.ward,
    required this.street,
  });

  factory AddressEntities.fromJson(Map<String, dynamic> json) {
    return AddressEntities(
      province: json['province'] ?? '',
      district: json['district'] ?? '',
      ward: json['ward'] ?? '',
      street: json['street'] ?? '',
    );
  }
}