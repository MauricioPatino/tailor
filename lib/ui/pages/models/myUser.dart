// class myUser {
//  final String? uid;
//
//  myUser({this.uid});
// }
import 'package:cloud_firestore/cloud_firestore.dart';

class myUser {
 String? uid;
 String? screenName;
 String? photoUrl;
 int? age;
 String? bio = "";
 myUser({this.uid, required this.screenName, required this.photoUrl, required this.age, required this.bio});

 myUser.fromSnapshot(DocumentSnapshot snapshot) {
  uid = snapshot['uid'];
  screenName = snapshot['name'];
  age = snapshot['age'];
  photoUrl = snapshot['profile_photo_path'];
  bio = snapshot.get('bio') ?? '';
 }
 Map<String, dynamic> toMap() {
  return <String, dynamic>{
   'id': uid,
   'name': screenName,
   'age': age,
   'profile_photo_path': photoUrl,
   'bio': bio
  };
 }
}

