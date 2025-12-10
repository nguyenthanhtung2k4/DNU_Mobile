import 'Ebook.dart';
import 'documnet.dart';
import 'magazine.dart';
import 'newspaper.dart';
import 'book.dart';


class LibraryManager {
  List<Document> documents = [];

  void add(Document doc) {
    documents.add(doc);
  }

  void showAll() {
    for (var d in documents) {
      d.showInfo();
    }
  }

  void search(String keyword) {
    for (var d in documents) {
      if (d.title.toLowerCase().contains(keyword.toLowerCase())) {
        d.showInfo();
      }
    }
  }
 
  void searchYear(int keyword) {
    for (var d in documents) {
      if (d.year == keyword) {
        d.showInfo();
      }
    }
  }

  void delete(String id) {
    documents.removeWhere((doc) => doc.id == id);
  }
  
  Map<String, int> coutData() {
    int coutBook = 0;
    int coutPaper = 0;
    int coutMaga = 0;
    int coutEbook = 0;

    for (var doc in documents) {
      if (doc is Book) {
        coutBook++;
      } else if (doc is Newspaper) {
        coutMaga++;
      } else if (doc is Magazine) {
        coutPaper++;
      } else if (doc is Ebook) {
        coutEbook++;
      }
    }
    return {'Book': coutBook, 'Newspaper': coutPaper, 'Magazine': coutMaga , 'Ebook': coutEbook };
  }
}
