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
        'masjidname': masjidname,
        'centerId': id.toString()
      }).onError((error, stackTrace) {
        log(error.toString());
      });
    }).onError((error, stackTrace) {
      throw FirebaseException;
    });
  }

  // get All Registered Suffa Center
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllSuffaCenterByProgram(
      program) {
    return firestore
        .collection(suffahCenterCollection)
        .where('Programs', arrayContains: program)
        .snapshots();
  }

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
  static Future<void> addSuffahCommitteMembers(
    File file,
    name,
    email,
    suffahemail,
    password,
    phoneno,
    city,
    country,
    address,
    adminid,
    masjidid,
    state,
  ) async {
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
        'centerId': masjidid,
        'state': state,
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
        'DateofCardExpire': doCardExpire,
        'status': 'waiting',
        'tempStatus': 'waiting',
        'donerSelectionId': '',
      });
    }).onError((error, stackTrace) {
      throw Exception(error.toString());
    });
  }

  // Get All Needy people According to there Program and By Masjid
  static Stream<QuerySnapshot<Map<String, dynamic>>>
      getAllNeedyPeopleByProgramMasjid(program, muntazimid) {
    return firestore
        .collection(suffahCenterNeedyPeople)
        .where('program', isEqualTo: program)
        .where('MuntazimId', isEqualTo: muntazimid)
        .where('status', isEqualTo: 'waiting')
        .snapshots();
  }

  // Get All Needy people According to there Program and By Masjid Count
  static AggregateQuery getAllNeedyPeopleByProgramMasjidCount(
      program, muntazimid) {
    return firestore
        .collection(suffahCenterNeedyPeople)
        .where('program', isEqualTo: program)
        .where('MuntazimId', isEqualTo: muntazimid)
        .where('status', isEqualTo: 'waiting')
        .count();
  }

  // Get All Needy people According to there Program and By Masjid How Recived Donnation
  static AggregateQuery getAllNeedyPeopleByProgramMasjidDonate(
      program, muntazimid) {
    return firestore
        .collection(suffahCenterNeedyPeople)
        .where('program', isEqualTo: program)
        .where('MuntazimId', isEqualTo: muntazimid)
        .where('status', isEqualTo: 'Pending')
        .count();
  }

  // Get All Needy people According to there Program
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllNeedyPeopleByProgram(
      program) {
    return firestore
        .collection(suffahCenterNeedyPeople)
        .where('program', isEqualTo: program)
        .snapshots();
  }

  // Bulk and Single Donnation Collection
  static Future<void> donnatationTark() async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    await firestore.collection(donnationTrack).doc(id).set({
      'suffaPerson': {},
      'status': 'Waiting',
    });
  }

  // Update the temporary status of the Al-suffa Person
  static Future<void> updateStatusAlSuffahPerson(id, status) async {
    await firestore.collection(suffahCenterNeedyPeople).doc(id).update({
      'tempStatus': status,
      'donerSelectionId': user.uid,
    });
  }

  // get the selected count for the donner to donate
  static Stream<QuerySnapshot<Map<String, dynamic>>>
      getAllNeedyPeopleDonateCount(program) {
    return firestore
        .collection(suffahCenterNeedyPeople)
        .where('program', isEqualTo: program)
        .where('donerSelectionId', isEqualTo: user.uid)
        .where('tempStatus', isEqualTo: 'Added')
        .snapshots();
  }

  // add Affiliated Program into the database
  static Future<void> addAffiliatedProgramByAdmin(
      file, title, status, price) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = imagestorage.ref().child('/Images/Affiliatedprogram$id');
    storage.UploadTask uploadTask = ref.putFile(file);
    Future.value(uploadTask).then((value) async {
      var imageUrl = await ref.getDownloadURL();
      await firestore.collection(suffahAffiliatedprogram).doc(id).set({
        'programId': id,
        'image': imageUrl.toString(),
        'programTitle': title,
        'Status': status,
        'Price': price,
      });
    });
  }

  // Get All Suffah Affiliated Program
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllPrograms() {
    return firestore.collection(suffahAffiliatedprogram).snapshots();
  }

  // Add Programs into The Suffa center Collection
  static Future<void> updateTheSuffaCenterPrograms(
    List<dynamic> programs,
    id,
  ) async {
    firestore.collection(suffahCenterCollection).doc(id).update({
      'Programs': [
        programs,
      ],
    });
  }

  // Update The Status of The  Suffa Person Who's Payment is On The Way
  static Future<void> updateStatusAlSuffahPersonGotDonnation(id, status) async {
    firestore.collection(suffahCenterNeedyPeople).doc(id).update({
      'status': status,
      'tempStatus': 'Success',
    });
  }

  // add Center Program By Suffa Center into the database
  static Future<void> addAffiliatedProgramBySuffahCenter(
    file,
    title,
    status,
    price,
    purpose,
    muntazimId,
    masjidname,
    masjidId,
    cnicno,
    dob,
    dateofIssue,
    dateofExpire,
  ) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = imagestorage.ref().child('/Images/Affiliatedprogram$id');
    storage.UploadTask uploadTask = ref.putFile(file);
    Future.value(uploadTask).then((value) async {
      var imageUrl = await ref.getDownloadURL();
      await firestore.collection(suffahCenterDefineProgram).doc(id).set({
        'programId': id,
        'image': imageUrl.toString(),
        'programTitle': title,
        'Status': status,
        'Price': price,
        'purpose': purpose,
        'MasjidId': masjidId,
        'masjidname': masjidname,
        'muntazimId': muntazimId,
        'CnicNo': cnicno,
        'dob': dob,
        'doIssue': dateofIssue,
        'doExpire': dateofExpire,
      });
    });
  }

  // get all the requested Suffah Desfine Programs
  static Stream<QuerySnapshot<Map<String, dynamic>>> suffahRequestedProgram(
      status) {
    return firestore
        .collection(suffahCenterDefineProgram)
        .where('Status', isEqualTo: status)
        .snapshots();
  }

  // If Accept or Reject Then Update the Status
  static Future<void> updateSuffahProgramStatus(
      String programId, String status) async {
    firestore
        .collection(suffahCenterDefineProgram)
        .doc(programId)
        .update({'Status': status});
  }

  // Add The Suffa Stores into thee database
  static Future<void> addSuffahStore(
    File file,
    cnicno,
    dob,
    dateofIssue,
    dateofExpire,
    shopTitle,
    address,
    country,
    city,
    phone,
    muntazimId,
    masjidid,
    masjidname,
    username,
    password,
    email,
    state,
  ) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = imagestorage.ref().child('/Images/ShopImage$id');
    storage.UploadTask uploadTask = ref.putFile(file);
    Future.value(uploadTask).then((value) async {
      var imageUrl = await ref.getDownloadURL();
      await firestore.collection(suffahShop).doc(id).set({
        'CnicNo': cnicno,
        'dob': dob,
        'doIssue': dateofIssue,
        'doExpire': dateofExpire,
        'ShopTitle': shopTitle,
        'Address': address,
        "Country": country,
        "City": city,
        'Image': imageUrl.toString(),
        'Status': 'Verified',
        'ShopId': id,
        'Phoneno': phone,
        "muntazimId": muntazimId,
        'masjidId': masjidid,
        'masjidname': masjidname,
        'genUsername': username,
        'genPassword': password,
        'email': email,
        'state': state,
      });
    });
  }

  // Display Shuffah Shop According to masjid
  static Stream<QuerySnapshot<Map<String, dynamic>>> getShopsforMasjid(
      masjidid) {
    return firestore
        .collection(suffahShop)
        .where('masjidId', isEqualTo: masjidid)
        .snapshots();
  }
}
