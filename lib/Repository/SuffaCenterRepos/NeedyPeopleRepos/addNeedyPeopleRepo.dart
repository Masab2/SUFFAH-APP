// ignore_for_file: unnecessary_null_comparison, body_might_complete_normally_nullable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/utils/constant/constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class AddNeedyPeopleRepo {
  Future<String?> addNeedyPeople(String file, TextEditingController phoneno,
      TextEditingController address, masjid) async {
    if (file == null || phoneno.text.isEmpty || address.text.isEmpty || file.isEmpty) {
      return 'Please Fill the Required Feilds';
    }  else {
      QuerySnapshot snapshot =
          await Apis.firestore.collection(suffahCenterNeedyPeople).get();
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        if (data['PersonAddress'] == address.text) {
          return 'This address is available';
        } else {
          return null;
        }
      }
    }
  }

  Future<String?> addCnicDataManually(
      TextEditingController holdername,
      TextEditingController cnicNo,
      TextEditingController dob,
      TextEditingController doCardissue,
      TextEditingController doCardExpire,
      File file,
      String phoneno,
      String address,
      String masjid,
      program,
      muntazimid,
      gender,
      masjidid) async {
    if (holdername.text.isEmpty ||
        cnicNo.text.isEmpty ||
        dob.text.isEmpty ||
        doCardissue.text.isEmpty ||
        doCardExpire.text.isEmpty) {
      return 'Please enter all the required data';
    }

    // Validate CNIC uniqueness
    QuerySnapshot snapshot =
        await Apis.firestore.collection(suffahCenterNeedyPeople).get();
    for (var doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      if (data["CNICNo"] == cnicNo.text) {
        return 'This CNIC is already registered';
      }
    }
    try {
      // Add the needy person
      await Apis.addNeedyPeople(
        file,
        muntazimid,
        phoneno,
        address,
        masjid,
        program,
        gender,
        cnicNo.text,
        holdername.text,
        dob.text,
        doCardissue.text,
        doCardExpire.text,
      );
      // Check if the program is available in the suffa center collection
      final DocumentSnapshot<Map<String, dynamic>> programDoc =
          await FirebaseFirestore.instance
              .collection(suffahCenterCollection)
              .doc(masjidid)
              .get();

      if (!programDoc.exists) {
        return 'Suffa center not found';
      }
      // Extract current programs from the suffa center document
      List<dynamic> currentPrograms =
          List.from(programDoc.data()!['Programs'] ?? []);
      // Check if the program is already added
      if (currentPrograms.contains(program)) {}
      // Add the program to the suffa center collection
      currentPrograms.add(program);
      await FirebaseFirestore.instance
          .collection(suffahCenterCollection)
          .doc(masjidid)
          .update({
        'Programs': currentPrograms,
      });

      return null; // Return null if successful
    } catch (e) {
      return e.toString(); // Return error message if any
    }
  }

  // Add Cnic Data While Scanning
  Future<String?> addCnicDataScan(
    TextEditingController holdername,
    TextEditingController cnicNo,
    TextEditingController dob,
    TextEditingController doCardissue,
    TextEditingController doCardExpire,
    File file,
    String phoneno,
    String address,
    String masjid,
    program,
    muntazimid,
    gender,
    masjidid,
  ) async {
    if (holdername.text.isEmpty ||
        cnicNo.text.isEmpty ||
        dob.text.isEmpty ||
        doCardissue.text.isEmpty ||
        doCardExpire.text.isEmpty) {
      return 'Please enter all the required data';
    }

    // Validate CNIC uniqueness
    QuerySnapshot snapshot =
        await Apis.firestore.collection(suffahCenterNeedyPeople).get();
    for (var doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      if (data["CNICNo"] == cnicNo.text) {
        return 'This CNIC is already registered';
      }
    }
    try {
      // Add the needy person
      await Apis.addNeedyPeople(
        file,
        muntazimid,
        phoneno,
        address,
        masjid,
        program,
        gender,
        cnicNo.text,
        holdername.text,
        dob.text,
        doCardissue.text,
        doCardExpire.text,
      );
      // Check if the program is available in the suffa center collection
      final DocumentSnapshot<Map<String, dynamic>> programDoc =
          await FirebaseFirestore.instance
              .collection(suffahCenterCollection)
              .doc(masjidid)
              .get();

      if (!programDoc.exists) {
        return 'Program not found in Suffa center';
      }

      // Extract current programs from the suffa center document
      List<dynamic> currentPrograms =
          List.from(programDoc.data()!['Programs'] ?? []);

      // Check if the program is already added
      if (currentPrograms.contains(program)) {}
      // Add the program to the suffa center collection
      currentPrograms.add(program);
      await FirebaseFirestore.instance
          .collection(suffahCenterCollection)
          .doc(masjidid)
          .update({
        'Programs': currentPrograms,
      });

      return null; // Return null if successful
    } catch (e) {
      return e.toString(); // Return error message if any
    }
  }
}
