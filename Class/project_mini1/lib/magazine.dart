import './documnet.dart';
class Magazine extends Document {
  int issue;

  Magazine(super.id, super.title, super.year, this.issue);

  @override
  void showInfo() {
    print("Magazine: $title - Issue $issue ($year)");
  }
}
