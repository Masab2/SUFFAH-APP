import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:suffa_app/Model/donnerModel/donnerModel.dart';
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
    await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
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
        .where('email', isEqualTo: email)
        .limit(1)
        .get();
    if (userDoc.docs.isEmpty) {
      firestore.collection(donorinfoCollection).doc(user.uid).set({
        'email': email,
        'uid': user.uid,
        'profilePic': '',
        'phoneno': '',
      });
    }
  }

  // Donner Login To Dashboard Via Email
  static Future<void> loginAccount(var email, password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  // LogOut from Donner DashBoard
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
  static Future<void> addSuffahCenter(
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
    masjidname,
    state,
  ) async {
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
        'state': state,
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
        'state': state,
        'address': address,
        'MemberId': adminid,
        'status': 'Verified',
        'Desig': 'Muntazim',
        'masjidname': masjidname,
        'centerId': id.toString(),
      }).onError((error, stackTrace) {
        log(error.toString());
      });
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }

  // get All Registered Suffa Center
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllSuffaCenterByProgram(
      program, country) {
    return firestore
        .collection(suffahCenterCollection)
        .where('Programs', arrayContains: program)
        .where('country', isEqualTo: country)
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
    doCardExpire,
    masjidId,
    masjidEmail,
    masjidCountry,
    masjidState,
    masjidCity,
    masjidAddress,
    donatePrice,
  ) async {
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
        'recivedDonnation': '0',
        'masjidId': masjidId,
        'masjidEmail': masjidEmail,
        'masjidCountry': masjidCountry,
        'masjidState': masjidState,
        'masjidCity': masjidCity,
        'masjidAddress': masjidAddress,
        'requiredDonnation': donatePrice,
      });
    }).onError((error, stackTrace) {
      throw Exception(error.toString());
    });
  }

  // Update the Bar For the Donnation
  static Future<void> updateDonationAmount(id, donationAmount) async {
    // Retrieve the current receivedDonation value
    DocumentSnapshot snapshot =
        await firestore.collection(suffahCenterNeedyPeople).doc(id).get();
    String currentReceivedDonationStr = snapshot['recivedDonnation'];
    log(currentReceivedDonationStr);
    int currentReceivedDonation = int.parse(currentReceivedDonationStr);
    log(currentReceivedDonation.toString());
    // Increment the receivedDonation by the recent donation amount
    int newReceivedDonation =
        currentReceivedDonation + int.parse(donationAmount);
    log(newReceivedDonation.toString());
    // Update the receivedDonation field with the new value
    await firestore.collection(suffahCenterNeedyPeople).doc(id).update(
      {
        'recivedDonnation': newReceivedDonation.toString(),
      },
    );
  }

  //! Update Shuffa Center Recived Donnation Array Creation
  static Future<void> updateSuffaCenterProgramAndDonation(
      suffaCenterId, List<Map<String, dynamic>> programs) async {
    await firestore
        .collection(suffahCenterCollection)
        .doc(suffaCenterId)
        .update(
      {
        'RecivedDonnation': FieldValue.arrayUnion(programs),
      },
    );
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

  // Update the Status of the Needy People
  static Future<void> updateNeedyPeopleStatus(id) async {
    await firestore.collection(suffahCenterNeedyPeople).doc(id).update({
      'status': 'Recived',
    });
  }

  // Get All Needy people According to there Program and By Masjid
  static Stream<QuerySnapshot<Map<String, dynamic>>>
      getAllNeedyPeopleOneClick() {
    return firestore.collection(suffahCenterNeedyPeople).snapshots();
  }

  // Single Donnation Collection by Multiple People
  static Future<void> donnatationTarkPerson(
    program,
    requiredDonnation,
    masjidname,
    masjidId,
    muntazimId,
    masjidAddress,
    masjidCountry,
    masjidCity,
    masjidstate,
    masjidEmail,
    personcnic,
    personame,
    dateofBirth,
    dateofCardExpire,
    dateofCardIssue,
    personId,
    personPhoneNo,
    personaddress,
    personprofile,
    personGender,
    List<DonnerModel> donnerlist,
  ) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch.toString();
      Map<String, dynamic> donnerTrack = {
        'program': program,
        'requiredDonnation': requiredDonnation,
        'masjidname': masjidname,
        'masjidId': masjidId,
        'muntazimId': muntazimId,
        'masjidAddress': masjidAddress,
        'countryMasjid': masjidCountry,
        'masjidCity': masjidCity,
        'masjidState': masjidstate,
        'masjidEmail': masjidEmail,
        'personcnic': personcnic,
        'personname': personame,
        'dateofBirth': dateofBirth,
        'dateofCardExpire': dateofCardExpire,
        'dateofCardIssue': dateofCardIssue,
        'personId': personId,
        'PersonPhoneNo': personPhoneNo,
        'PersonAddress': personaddress,
        'PersonProfile': personprofile,
        'personGender': personGender,
        'trackId': id.toString(),
        'recivedDonnation': '0',
        'donners': donnerlist.map((donner) => donner.toJson()).toList(),
      };
      // Get the existing received donation amount from Firestore
      final existingDoc =
          await firestore.collection(donnationTrackPerson).doc(personId).get();
      int existingReceivedDonation = 0;
      if (existingDoc.exists) {
        existingReceivedDonation =
            int.tryParse(existingDoc.get('recivedDonnation') ?? '0') ?? 0;
        // Calculate the total received donation including the latest donation
        int totalReceivedDonation = existingReceivedDonation +
            donnerlist.fold<int>(
              0,
              (sum, donner) => sum + int.parse(donner.donateAbleAmmount),
            );
        // Update existing document with entire donor list and received donation
        await firestore.collection(donnationTrackPerson).doc(personId).update({
          'donners': FieldValue.arrayUnion(
            donnerlist.map((donner) => donner.toJson()).toList(),
          ),
          'recivedDonnation': totalReceivedDonation.toString(),
        });
      } else {
        donnerTrack['recivedDonnation'] =
            donnerlist.first.donateAbleAmmount.toString();
        await firestore
            .collection(donnationTrackPerson)
            .doc(personId)
            .set(donnerTrack);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // Update the Total donnationn in the  main bar

  // Masjid Donation For there Program
  static Future<void> donnatationTarkMasjid(
    program,
    requiredDonnation,
    masjidname,
    masjidId,
    muntazimId,
    masjidAddress,
    masjidCountry,
    masjidCity,
    masjidstate,
    masjidEmail,
    cnic,
    muntazimname,
    dateofBirth,
    dateofCardExpire,
    dateofCardIssue,
    programId,
    List<DonnerModel> donnerlist,
  ) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch.toString();
      Map<String, dynamic> donnerTrack = {
        'program': program,
        'requiredDonnation': requiredDonnation,
        'masjidname': masjidname,
        'masjidId': masjidId,
        'muntazimId': muntazimId,
        'masjidAddress': masjidAddress,
        'countryMasjid': masjidCountry,
        'masjidCity': masjidCity,
        'masjidState': masjidstate,
        'masjidEmail': masjidEmail,
        'Muntazimcnic': cnic,
        'Muntazimname': muntazimname,
        'dateofBirth': dateofBirth,
        'dateofCardExpire': dateofCardExpire,
        'dateofCardIssue': dateofCardIssue,
        'trackId': id.toString(),
        'recivedDonnation': '0',
        'programId': programId,
        'donners': donnerlist.map((donner) => donner.toJson()).toList(),
      };
      // Get the existing received donation amount from Firestore
      final existingDoc =
          await firestore.collection(donnationTrackMasjid).doc(programId).get();
      int existingReceivedDonation = 0;

      if (existingDoc.exists) {
        existingReceivedDonation =
            int.tryParse(existingDoc.get('recivedDonnation') ?? '0') ?? 0;
        // Calculate the total received donation including the latest donation
        int totalReceivedDonation = existingReceivedDonation +
            donnerlist.fold<int>(
                0, (sum, donner) => sum + int.parse(donner.donateAbleAmmount));
        await firestore.collection(donnationTrackMasjid).doc(programId).update({
          'donners': FieldValue.arrayUnion(
            donnerlist.map((donner) => donner.toJson()).toList(),
          ),
          'recivedDonnation': totalReceivedDonation.toString(),
        });
      } else {
        donnerTrack['recivedDonnation'] =
            donnerlist.first.donateAbleAmmount.toString();
        await firestore
            .collection(donnationTrackMasjid)
            .doc(programId)
            .set(donnerTrack);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // Update the Bar For the Donnation Masjid
  static Future<void> updateDonationAmountForMasjid(id, donationAmount) async {
    // Retrieve the current receivedDonation value
    DocumentSnapshot snapshot =
        await firestore.collection(suffahCenterDefineProgram).doc(id).get();
    String currentReceivedDonationStr = snapshot['recivedDonnation'];
    log(currentReceivedDonationStr);
    int currentReceivedDonation = int.parse(currentReceivedDonationStr);
    log(currentReceivedDonation.toString());
    // Increment the receivedDonation by the recent donation amount
    int newReceivedDonation =
        currentReceivedDonation + int.parse(donationAmount);
    log(newReceivedDonation.toString());
    // Update the receivedDonation field with the new value
    await firestore.collection(suffahCenterDefineProgram).doc(id).update({
      'recivedDonnation': newReceivedDonation.toString(),
    });
  }

  // add Affiliated Program into the database
  static Future<void> addAffiliatedProgramByAdmin(
      file, title, status, price, currency, purpose) async {
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
        'Currency': currency,
        'personDefine': 'forPerson',
        'purpose': purpose,
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
    holdername,
    masjidEmail,
    phoneNo,
    address,
    country,
    state,
    city,
  ) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = imagestorage.ref().child('/Images/Affiliatedprogram$id');
    storage.UploadTask uploadTask = ref.putFile(file);
    Future.value(uploadTask).then((value) async {
      var imageUrl = await ref.getDownloadURL();
      await firestore.collection(suffahCenterDefineProgram).doc(id).set(
        {
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
          'CardHolderName': holdername,
          'masjidEmail': masjidEmail,
          'recivedDonnation': "0",
          'PhoneNo': phoneNo,
          'MasjidAddress': address,
          'countryMasjid': country,
          'masjidCity': city,
          'masjidState': state,
          'centerDefine': 'forMasjid',
        },
      );
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
    program,
    cardholdername,
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
        'program': program,
        'CardHolderName': cardholdername,
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

  // Get All Shops With Respect To Programs
  static Stream<QuerySnapshot<Map<String, dynamic>>> getShopsforByProgram(
      program) {
    return firestore
        .collection(suffahShop)
        .where('program', isEqualTo: program)
        .snapshots();
  }

  // Get All Suffah Center Define Program
  static Stream<QuerySnapshot<Map<String, dynamic>>>
      getAllSuffahCenterDefinePrograms() {
    return firestore
        .collection(suffahCenterDefineProgram)
        .where('Status', isEqualTo: 'Active')
        .snapshots();
  }

  // Notification Collection for the Donner transprency
  static Future<void> addNotification(
    String title,
    String body,
    String ammount,
    String currency,
  ) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    await firestore.collection(notifsCollection).doc(id).set({
      'notifId': id,
      'title': title,
      'body': body,
      'time': DateTime.now().toString(),
      'seen': 'false',
      'donnnerId': user.uid,
      'Ammount': ammount,
      'currency': currency,
    });
  }

  // get all the  Donnation Track by Stepper for Donner
  static Future<void> addDonationTrack(
    String title,
    String body,
    String ammount,
    String currency,
    String status,
    String cnicNo,
    String name,
    String address,
    String location,
    String program,
    String donnationStatus,
  ) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    await firestore.collection(donnationTrackDonnerAll).doc(id).set({
      'trackId': id,
      'title': title,
      'body': body,
      'time': DateTime.now().toString(),
      'seen': 'false',
      'donnnerId': user.uid,
      'Ammount': ammount,
      'currency': currency,
      'Status': status,
      'cnicNo': cnicNo,
      'name': name,
      'address': address,
      'location': location,
      'program': program,
      'DonnationStatus': donnationStatus,
    });
  }

  // Notification Collection for the Donner transprency Fetch Notifs
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllNotifs() {
    return firestore
        .collection(notifsCollection)
        .where('donnnerId', isEqualTo: user.uid)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllDonnationTrack() {
    return firestore
        .collection(donnationTrackDonnerAll)
        .where('donnnerId', isEqualTo: user.uid)
        .snapshots();
  }

  // Get all the donnation track For Admin to Proceeed the Donnation for Person
  static Stream<QuerySnapshot<Map<String, dynamic>>>
      getAllDonationTrackForPerson() {
    return firestore.collection(donnationTrackPerson).snapshots();
  }

  // Donnation Track for the Shuffa Center
  static Stream<QuerySnapshot<Map<String, dynamic>>>
      getAllDonationTrackForPersonForSuffaCenter(masjidid, muntazimId) {
    return firestore
        .collection(donnationTrackPerson)
        .where('masjidId', isEqualTo: masjidid)
        .where('muntazimId', isEqualTo: muntazimId)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>>
      getAllDonationTrackForMasjidForSuffaCenter(masjidid, muntazimId) {
    return firestore
        .collection(donnationTrackMasjid)
        .where('masjidId', isEqualTo: masjidid)
        .where('muntazimId', isEqualTo: muntazimId)
        .snapshots();
  }

  // Get all the donnation track For Admin to Proceeed the Donnation for Masjid
  static Stream<QuerySnapshot<Map<String, dynamic>>>
      getAllDonationTrackForMasjid() {
    return firestore.collection(donnationTrackMasjid).snapshots();
  }
}
