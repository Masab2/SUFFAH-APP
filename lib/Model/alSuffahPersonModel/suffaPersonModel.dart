class SuffahPersonModel implements Comparable<SuffahPersonModel> {
  final String personname;
  final String image;
  final String address;
  final String cnicno;
  final String? phoneno;
  final String program;
  final String masjidname;
  final String tempstatus;
  final String status;
  final String personId;

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
  });
  @override
  int compareTo(SuffahPersonModel other) {
    return personname.compareTo(other.personname);
  }
}
