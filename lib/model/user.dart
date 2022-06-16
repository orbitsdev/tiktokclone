class User {
  String uid;
  String name;
  String phonenumber;
  String email;
  String profilePhoto;

  User({
    required this.uid,
    required this.name,
    required this.phonenumber,
    required this.email,
    required this.profilePhoto,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'phonenumber': phonenumber,
        'email': email,
        'profilePhoto': profilePhoto,
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      name: json['name'],
      phonenumber: json['phonenumber'],
      email: json['email'],
      profilePhoto: json['profilePhoto'],
    );
  }
}
