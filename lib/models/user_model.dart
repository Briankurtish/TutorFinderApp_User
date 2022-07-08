class UserModel {
  bool completedProfile;
  String uid;
  String username;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String address;

  UserModel({
    this.uid = '',
    this.username = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.address = '',
    this.phoneNumber = '',
    this.completedProfile = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      completedProfile: json['completedProfile'],
      username: json['username'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'completedProfile': completedProfile,
      'uid': uid,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }
}
