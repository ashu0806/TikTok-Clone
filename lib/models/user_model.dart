import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;
  String email;
  String profilePic;
  String uid;

  UserModel({
    required this.name,
    required this.email,
    required this.profilePic,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'profilePic': profilePic,
        'uid': uid,
      };

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      name: snapshot['name'],
      email: snapshot['email'],
      profilePic: snapshot['profilePic'],
      uid: snapshot['uid'],
    );
  }
}
