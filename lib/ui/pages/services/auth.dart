import 'package:firebase_auth/firebase_auth.dart';
import 'package:tailor/ui/pages/models/myUser.dart';
import 'package:tailor/ui/pages/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {

  //final GoogleSignIn _googleSignIn = GoogleSignIn();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //creates user object based on User
  //User = FirebaseUser. Use User not FirebaseUser
  myUser? _userFromFirebaseUser(User? user) {
    return user != null ? myUser(uid: user.uid, screenName: '', age: 0, bio: '', photoUrl: '') : null;
    //return user != null ? myUser(uid: user.uid, screenName: '', age: 1, bio: '', photoUrl: '') : null;

  }

  //auth change user stream
  Stream<myUser?> get user{
    return _auth.authStateChanges()
        //.map((User? user) => _userFromFirebaseUser(user!));
        .map(_userFromFirebaseUser);
  }
//sign in user anonymously
  Future signInAnon() async {
    try{
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user!;
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  //registration with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      //creates a new document for the user with the uid
      await DatabaseService(uid: user!.uid).updateUserData('Joey Scally', 'Foto-1', 'I like women', 'Please date me!');


      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out user
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //deletes user account
   Future deleteAccount() async{
    try{
      User? user = _auth.currentUser;
      await DatabaseService(uid: user!.uid).deleteUserData('Joey Kit', 'Foto-1', 'I like women', 'Please date me!');
      user.delete();
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  //gets user account
  // Future<myUser> getUser() async {
  //   coUserCredential = await _auth.currentUser();
  //   return myUser(uid: user.uid);
  // }
  //

}