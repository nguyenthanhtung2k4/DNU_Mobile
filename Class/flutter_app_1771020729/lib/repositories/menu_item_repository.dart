import '../models/menu_item_model.dart';
import '../services/firestore_service.dart';

class MenuItemRepository {
  final _service = FirestoreService.instance;

  /// CRUD
  Future<void> add(MenuItemModel item) async {
    await _service.menuItemsRef
        .doc(item.id)
        .set(item.toMap());
  }

  Future<void> update(MenuItemModel item) async {
    await _service.menuItemsRef
        .doc(item.id)
        .update(item.toMap());
  }

  Future<void> delete(String id) async {
    await _service.menuItemsRef.doc(id).delete();
  }

  /// Get all (real-time)
  Stream<List<MenuItemModel>> getAll() {
    return _service.menuItemsRef.snapshots().map(
          (snap) => snap.docs
              .map((d) =>
                  MenuItemModel.fromMap(
                      d.id, d.data()))
              .toList(),
        );
  }

  /// SEARCH (name, description, ingredients)
  /// Firestore không hỗ trợ contains đa trường → filter phía client
  Future<List<MenuItemModel>> search(String keyword) async {
    final snap = await _service.menuItemsRef.get();

    return snap.docs
        .map((d) =>
            MenuItemModel.fromMap(d.id, d.data()))
        .where((item) {
      final k = keyword.toLowerCase();
      return item.name.toLowerCase().contains(k) ||
          item.description.toLowerCase().contains(k) ||
          item.ingredients
              .any((i) => i.toLowerCase().contains(k));
    }).toList();
  }

  /// FILTER (category, vegetarian, spicy)
  Future<List<MenuItemModel>> filter({
    String? category,
    bool? isVegetarian,
    bool? isSpicy,
  }) async {
    final snap = await _service.menuItemsRef.get();
    return snap.docs
        .map((d) =>
            MenuItemModel.fromMap(d.id, d.data()))
        .where((item) {
      if (category != null &&
          item.category != category) {
        return false;
      }
      if (isVegetarian != null &&
          item.isVegetarian != isVegetarian) {
        return false;
      }
      if (isSpicy != null &&
          item.isSpicy != isSpicy) {
        return false;
      }
      return true;
    }).toList();
  }
}
