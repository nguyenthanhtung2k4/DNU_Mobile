import './documnet.dart';
class Newspaper extends Document {
  String date;

  Newspaper(super.id, super.title, super.year, this.date);

  @override
  void showInfo() {
    print("Newspaper: $title - Date $date ($year)");
  }
}