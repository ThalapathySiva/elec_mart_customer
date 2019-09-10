class AddressModel {
  final String name;
  final String addressLine;
  final String landmark;
  final String city;
  final String phoneNumber;

  AddressModel(
      {this.city,
      this.name,
      this.addressLine,
      this.landmark,
      this.phoneNumber});

  factory AddressModel.fromJson(Map<dynamic, dynamic> json) {
    return AddressModel(
        name: json['name'],
        addressLine: json['addressLine'],
        landmark: json['landmark'],
        city: json['city'],
        phoneNumber: json['phoneNumber']);
  }
}
