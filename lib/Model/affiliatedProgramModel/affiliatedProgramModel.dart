class AffiliatedProgramModel {
  final String programTitle;
  final String? status;
  final String? image;
  final String? programId;
  bool isSelected;

  AffiliatedProgramModel({
    required this.programTitle,
    this.status,
    this.image,
    this.programId,
    this.isSelected = false,
  });
}
