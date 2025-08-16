class Address {
  final String fullAddress;
  bool isDefault;

  Address({required this.fullAddress, this.isDefault = false});

  factory Address.fromMap(Map<String, dynamic> map) => Address(
    fullAddress: map['fullAddress'],
    isDefault: map['isDefault'] ?? false,
  );

  Map<String, dynamic> toMap() => {
    'fullAddress': fullAddress,
    'isDefault': isDefault,
  };

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    fullAddress: json['fullAddress'],
    isDefault: json['isDefault'] ?? false,
  );
}
