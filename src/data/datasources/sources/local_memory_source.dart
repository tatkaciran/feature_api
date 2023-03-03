// ignore_for_file: avoid_print

import '../../../domain/entities/entity_interface.dart';
import '../../models/sources_type.dart';
import '../../models/target_platform.dart';
import '../crud_source_interface.dart';

class LocalMemorySource<T extends IEntity> extends CRUDSource<T> {
  final Map<String, T> cacheditems;
  void setCache(Map<String, T> cacheitems) {
    cacheditems.addAll(cacheitems);
  }

  LocalMemorySource({Map<String, T>? items})
      : cacheditems = items ?? <String, T>{};

  @override
  List<IPlatform> get platforms => [IPlatform.all];

  @override
  SourceType get type => SourceType.local;

  @override
  Future<T> addItem(T item) async {
    try {
      cacheditems['${item.id}'] = item;
      print('LocalMemorySource.addItem() => $item');
      return cacheditems['${item.id}']!;
    } catch (e) {
      throw Exception(
          'MyBeautifulException => LocalMemorySource.addItem()  => $e');
    } finally {
      print('addItem executed');
    }
  }

  @override
  Future<T> deleteItem(T item) async {
    try {
      await Future(() => cacheditems.containsKey(item.id)
          ? cacheditems.remove(item.id)
          : null);
      print('LocalMemorySource.deleteItem() => $item');
      return item;
    } catch (e) {
      throw Exception(
          'MyBeautifulException => LocalMemorySource.deleteItem() => $e');
    } finally {
      print('deleteItem executed');
    }
  }

  @override
  Future<T> updateItem(T item) async {
    try {
      cacheditems['${item.id}'] = item;
      print('LocalMemorySource.getItemsByIds() => $item');
      return item;
    } catch (e) {
      throw Exception(
          'MyBeautifulException => LocalMemorySource.updateItem() => $e');
    } finally {
      print('updateItem executed');
    }
  }

  @override
  Future<T?> getItem(int id) async {
    if (!cacheditems.containsKey("$id")) {
      return null;
    }
    print('LocalMemorySource.getItem() => ${cacheditems["$id"]}');
    return cacheditems["$id"]!;
  }

  @override
  Future<List<T>> getItems() async => cacheditems.values.toList();

  @override
  Future<List<T>> getItemsByIds(List<int> ids) async =>
      cacheditems.values.where((item) {
        for (var id in ids) {
          print('LocalMemorySource.getItemsByIds() => ${cacheditems[id]}');
          return item.id == id;
        }
        return false;
      }).toList();

  @override
  Stream<T?> listenItem() {
    return Stream.fromIterable(cacheditems.values);
  }

  @override
  Stream<T?> listenItemByIds(List<int> ids) {
    return Stream.fromIterable(cacheditems.values.where((item) {
      for (var id in ids) {
        print('LocalMemorySource.getItemsByIds() => ${cacheditems[id]}');
        return id == item.id;
      }
      return false;
    }));
  }
}
