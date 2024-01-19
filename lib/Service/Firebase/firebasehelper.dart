import 'dart:developer';
import 'dart:io';

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
        .collection(donorinfoCollection)
        .where('uid', isEqualTo: user.uid)
        .limit(1)
        .get();
    if (userDoc.docs.isEmpty) {
      firestore.collection(donorinfoCollection).doc(user.uid).set({
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
    for (final userinfo in user.providerData) {
      if (userinfo.providerId == 'Google') {
        await googleSignIn.signOut();
      } else {
        await auth.signOut();
      }
    }
  }

  // Add Suffah center
  static Future<void> addSuffahCenter(File file, name, email, suffahemail,
      password, phoneno, city, country, address, adminid, masjidname) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = imagestorage.ref().child('/Images/MasjidImages$id');
    storage.UploadTask uploadTask = ref.putFile(file);
    Future.value(uploadTask).then((value) async {
      var imageUrl = await ref.getDownloadURL();
      await firestore.collection(suffahCenterCollection).doc(id).set({
        'adminCreatedId': adminid,
        'centerid': id,
        'name': name,
        'email': email,
        'suffahemail': suffahemail,
        'password': password,
        'phoneno': phoneno,
        'masjidimg': imageUrl.toString(),
        'city': city,
        'country': country,
        'address': address,
        'masjidname': masjidname,
      });
      await firestore.collection(suffahCenterMembers).doc(adminid).set({
        'MuntazimId': adminid,
        'name': name,
        'email': email,
        'suffahemail': suffahemail,
        'password': password,
        'phoneno': phoneno,
        'masjidimg': imageUrl.toString(),
        'city': city,
        'country': country,
        'address': address,
        'MemberId': adminid,
        'status': 'Verified',
        'Desig': 'Muntazim',
        'masjidname': masjidname
      }).onError((error, stackTrace) {
        log(error.toString());
      });
    }).onError((error, stackTrace) {
      throw FirebaseException;
    });
  }

  // get All Registered Suffa Center
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllSuffaCenter() {
    return firestore.collection(suffahCenterCollection).snapshots();
  }

  // get All Registered Suffa Center Access his Profile
  static Stream<QuerySnapshot<Map<String, dynamic>>> getSuffaCenterData(
      String id) {
    return firestore
        .collection(suffahCenterCollection)
        .where('adminCreatedId', isEqualTo: id)
        .snapshots();
  }

  // Get The Login Donner Info
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLoginDonnerInfo() {
    return firestore
        .collection(donorinfoCollection)
        .where('uid', isEqualTo: user.uid)
        .snapshots();
  }

  // Add Suffah center Commettie members
  static Future<void> addSuffahCommitteMembers(File file, name, email,
      suffahemail, password, phoneno, city, country, address, adminid) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = imagestorage.ref().child('/Images/MasjidImages$id');
    storage.UploadTask uploadTask = ref.putFile(file);
    Future.value(uploadTask).then((value) async {
      var imageUrl = await ref.getDownloadURL();
      await firestore.collection(suffahCenterMembers).doc(id).set({
        'MuntazimId': adminid,
        'name': name,
        'email': email,
        'suffahemail': suffahemail,
        'password': password,
        'phoneno': phoneno,
        'masjidimg': imageUrl.toString(),
        'city': city,
        'country': country,
        'address': address,
        'MemberId': id,
        'status': "Requested",
        'Desig': "Member",
      });
    }).onError((error, stackTrace) {
      throw FirebaseException;
    });
  }

  // Accept The request of the admin
  static Future<void> acceptRequestofMember(id) async {
    firestore
        .collection(suffahCenterMembers)
        .doc(id)
        .update({'status': 'Verified'});
  }

  // get All Registered Suffa Center
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllSuffaCenterMembers(
      id) {
    return firestore
        .collection(suffahCenterMembers)
        .where('MuntazimId', isEqualTo: id)
        .where('status', isEqualTo: 'Verified')
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getSuffaCenterMembers() {
    return firestore
        .collection(suffahCenterMembers)
        .where('status', isEqualTo: 'Requested')
        .snapshots();
  }

  // Add Needy People To The database
  static Future<void> addNeedyPeople(
      File file,
      muntazimid,
      phoneno,
      address,
      masjidName,
      program,
      gender,
      cnicno,
      cardholdername,
      dob,
      doCardIssue,
      doCardExpire) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = imagestorage.ref().child('/Images/NeedyPeople$id');
    storage.UploadTask uploadTask = ref.putFile(file);
    Future.value(uploadTask).then((value) async {
      var imageUrl = await ref.getDownloadURL();
      await firestore.collection(suffahCenterNeedyPeople).doc(id).set({
        'personId': id,
        'MuntazimId': muntazimid,
        'PersonProfile': imageUrl.toString(),
        'PersonName': cardholdername,
        'PersonPhoneNo': phoneno,
        'PersonAddress': address,
        'MasjidName': masjidName,
        'program': program,
        'gender': gender,
        'CNICNo': cnicno,
        'CardHolderName': cardholdername,
        'DateofBirth': dob,
        'DateofCardIssue': doCardIssue,
        'DateofCardExpire': doCardExpire
      });
    }).onError((error, stackTrace) {
      throw Exception(error.toString());
    });
  }
}
