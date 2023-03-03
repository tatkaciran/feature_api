import '../entities/entity_interface.dart';
import 'repository_interface.dart';

abstract class CRUDRepository<T extends IEntity> extends IRepository {
  Future<T> addItem(T item);
  Future<T> updateItem(T item);
  Future<T?> getItem(int id);
  Future<T> deleteItem(T item);
  Stream<T?> listenItem();
  Stream<T?> listenItemByIds(List<int> ids);
  Future<List<T>> getItems();
  Future<List<T>> getItemsByIds(List<int> ids);
}
