class UserModel {
  final String id;
  final String name;
  final String phoneNumber;
  final String email;

  UserModel({this.id, this.name, this.phoneNumber,this.email});

  factory UserModel.fromJson(Map<dynamic, dynamic> json) {
    return UserModel(
        id: json['id'], name: json['name'], phoneNumber: json['phoneNumber'],email: json['email']);
  }
}
