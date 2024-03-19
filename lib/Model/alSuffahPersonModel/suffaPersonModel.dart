class SuffahPersonModel {
  final String personname;
  final String image;
  final String address;
  final String cnicno;
  final String? phoneno;
  final String program;
  final String masjidname;
  String tempstatus;
  final String status;
  final String personId;
  final String requiredDonnation;
  final String recivedDonnation;
  final String dateofBirth;
  final String dateofIssue;
  final String dateofExpire;
  final String gender;

  SuffahPersonModel({
    required this.personname,
    required this.image,
    required this.address,
    required this.cnicno,
    this.phoneno,
    required this.program,
    required this.masjidname,
    required this.tempstatus,
    required this.status,
    required this.personId,
    required this.requiredDonnation,
    required this.recivedDonnation,
    required this.dateofBirth,
    required this.dateofIssue,
    required this.dateofExpire,
    required this.gender,
  });
}
