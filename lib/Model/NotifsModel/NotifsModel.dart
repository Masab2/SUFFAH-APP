class NotifsModel {
  final String title;
  final String body;
  final String seen;
  final String time;
  final String id;
  final String userId;
  final String ammount;
  final String currency;

  NotifsModel(
      {required this.title,
      required this.body,
      required this.seen,
      required this.time,
      required this.id,
      required this.userId,
      required this.ammount,
      required this.currency});
}
