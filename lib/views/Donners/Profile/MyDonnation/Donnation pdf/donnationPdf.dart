import 'dart:developer';

import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/utils/constant/constant.dart';

class MyDonnationPdf {
  static Future<void> generateDonationHistoryPDF() async {
    var donationsSnapshot = await Apis.firestore
        .collection(donnationTrackDonnerAll)
        .get(); // Use get() to fetch all documents
    // Prepare donation data for PDF generation
    List<Map<String, dynamic>> donations =
        donationsSnapshot.docs.map((doc) => doc.data()).toList();
    final pdf = pw.Document();

    // Define text style for the PDF
    const textStyle = pw.TextStyle(fontSize: 12);

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Title
            pw.Align(
              alignment: pw.Alignment.center,
              child: pw.Text(
                'Donation History',
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
              ),
            ),

            pw.SizedBox(height: 20), // Add space below the title
            // Donation details
            for (var donation in donations) ...[
              pw.Text('CNIC: ${donation['cnicNo']}', style: textStyle),
              pw.Text('Name: ${donation['name']}', style: textStyle),
              pw.Text('Address: ${donation['address']}', style: textStyle),
              pw.Text('Location: ${donation['location']}', style: textStyle),
              pw.Text('Program: ${donation['program']}', style: textStyle),
              pw.Text(
                'Amount: ${donation['Ammount']} ${donation['currency']}',
                style: textStyle,
              ),
              pw.Divider(
                  height: 20, thickness: 1), // Add divider between donations
            ],
          ],
        ),
      ),
    );

    final directory = await getExternalStorageDirectory();

    // Save the PDF to the document directory
    final file = File('${directory?.path}/donation_history.pdf');
    log(file.toString());
    log(directory?.path.toString() ?? '');
    try {
      await file.writeAsBytes(await pdf.save()).then((value) {
        Get.snackbar(
          'PDF Downloaded',
          'Donation history PDF downloaded successfully',
        );
      }).onError((error, stackTrace) {
        log(error.toString());
      });

      // Show a message to indicate the PDF is downloaded
      await OpenFile.open(file.path);
    } catch (e) {
      // Show error message
      Get.snackbar(
        'Error',
        'Failed to save PDF: $e',
      );
    }
  }
}
