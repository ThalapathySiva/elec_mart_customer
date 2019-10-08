class AddressModel {
  final String name;
  final String addressLine;
  final String landmark;
  final String city;
  final String pinCode;
  final String phoneNumber;

  AddressModel(
      {this.city,
      this.name,
      this.pinCode,
      this.addressLine,
      this.landmark,
      this.phoneNumber});

  factory AddressModel.fromJson(Map<dynamic, dynamic> json) {
    return AddressModel(
        name: json['name'],
        addressLine: json['addressLine'],
        landmark: json['landmark'],
        city: json['city'],
        pinCode: json["pinCode"],
        phoneNumber: json['phoneNumber']);
  }
}
