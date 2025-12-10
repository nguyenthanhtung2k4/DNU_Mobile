import '../lib/LibraryManager.dart';
import '../lib/book.dart';
import '../lib/magazine.dart';
import '../lib/newspaper.dart';
import '../lib/Ebook.dart';

void main() {
  var manager = LibraryManager();

  manager.add(Book("B01", "Dart Basics", 2023, "John", 300));
  manager.add(Magazine("M01", "Tech Today", 2024, 12));
  manager.add(Newspaper("N01", "Daily News", 2024, "12/03/2024"));
  manager.add(Newspaper("N02", "Daily News", 2024, "12/03/2024"));
  manager.add(Ebook('N1', 'Thanhtung', 2022, 'tung.nt'));

  print('Show:');
  manager.showAll();
  print('Delete:');
  manager.delete("M01");
  print('Show:');
  manager.showAll();
  print('Cout');
  print(manager.coutData());
  print('Search_Year');
  manager.searchYear(2024);
  print('Search');
  manager.search('Dart');
}
