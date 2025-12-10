import './documnet.dart';
class Book extends Document {
  String author;
  int pages;

  Book(super.id, super.title, super.year, this.author, this.pages);

  @override
  void showInfo() {
    print("Book: $title - $author ($year), $pages pages");
  }


}
