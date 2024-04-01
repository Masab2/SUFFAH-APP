class DonnerModel {
  final String donnerId;
  final String donateAbleAmmount;
  final String currency;

  DonnerModel(
      {required this.donnerId,
      required this.donateAbleAmmount,
      required this.currency});

  Map<String, dynamic> toJson() {
    return {
      'donnerId': donnerId,
      'donateAmmount': donateAbleAmmount,
      'currency': currency,
    };
  }    
}
