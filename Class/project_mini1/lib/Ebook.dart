import './documnet.dart';
class Ebook extends Document {
  String fileFormat;

  Ebook(String id, String title, int releaseYear, this.fileFormat)
      : super(id, title, releaseYear);

  @override
  void showInfo() {
    print('Ebook - ID: $id, Tiêu đề: $title, Năm: $year, Định dạng: $fileFormat');
  }
}