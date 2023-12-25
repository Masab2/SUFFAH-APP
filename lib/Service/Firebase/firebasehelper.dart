import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:suffa_app/utils/constant/constant.dart';

class Apis {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static GoogleSignIn googleSignIn = GoogleSignIn();
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static storage.FirebaseStorage imagestorage =
      storage.FirebaseStorage.instance;

  static User get user => auth.currentUser!;

  // Create Account of The Donner Via Email verified Link
  static Future<void> signUpAccount(var email, password) async {
    await auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      await saveUserData(user, email);
    }).onError((error, stackTrace) {
      throw Exception(error.toString());
    });
  }

  // Create Account of The Donner Via Google
  static Future<void> signUpWithGoogle() async {
    try {
      var result = await googleSignIn.signIn();
      if (result != null) {
        final userdata = await result.authentication;
        // ignore: unnecessary_null_comparison
        if (userdata != null) {
          final credential = GoogleAuthProvider.credential(
            accessToken: userdata.accessToken,
            idToken: userdata.idToken,
          );
          await Apis.auth.signInWithCredential(credential).then((value) async {
            await saveUserData(user, result.email);
          }).onError((error, stackTrace) {
            throw Exception(error.toString());
          });
        } else {
          throw Exception("User data is null");
        }
      } else {
        throw Exception("Google sign-in result is null");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Donner Authentication via Email verified Link
  static Future<void> saveUserData(User user, email) async {
    final userDoc = await firestore
        .collection(DonorinfoCollection)
        .where('uid', isEqualTo: user.uid)
        .limit(1)
        .get();
    if (userDoc.docs.isEmpty) {
      firestore.collection(DonorinfoCollection).doc(user.uid).set({
        'email': email,
        'uid': user.uid,
      });
    }
  }

  // Donner Login To Dashboard Via Email
  static Future<void> loginAccount(var email, password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  // LogOut from DashBoard
  static Future<void> logOutAccount() async {
    for (final userinfo in user!.providerData) {
      if (userinfo.providerId == 'Google') {
        await googleSignIn.signOut();
      } else {
        await auth.signOut();
      }
    }
  }
}
