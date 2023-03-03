import '../../../domain/entities/entity_interface.dart';
import '../../models/sources_type.dart';
import '../../models/target_platform.dart';
import '../crud_source_interface.dart';

class RemoteFirebaseSource<T extends IEntity> extends CRUDSource<T> {
  @override
  List<IPlatform> get platforms => [
        IPlatform.android,
        IPlatform.iOS,
        IPlatform.macOS,
        IPlatform.web,
      ];

  @override
  SourceType get type => SourceType.remote;

  @override
  Future<T> addItem(IEntity item) {
    //   implement addItem
    throw UnimplementedError('implement addItem');
  }

  @override
  Future<T> deleteItem(IEntity item) {
    //   implement deleteItem
    throw UnimplementedError('implement deleteItem');
  }

  @override
  Future<T?> getItem(int id) {
    //   implement getItem
    throw UnimplementedError('implement getItem');
  }

  @override
  Future<List<T>> getItems() {
    //   implement getItems
    throw UnimplementedError('implement getItems');
  }

  @override
  Future<List<T>> getItemsByIds(List<int> ids) {
    //   implement getItemsByIds
    throw UnimplementedError('implement getItemsByIds');
  }

  @override
  Stream<T?> listenItem() {
    //   implement listenItem
    throw UnimplementedError('implement listenItem');
  }

  @override
  Stream<T?> listenItemByIds(List<int> ids) {
    //   implement listenItemByIds
    throw UnimplementedError('implement listenItemByIds');
  }

  @override
  Future<T> updateItem(IEntity item) {
    //   implement updateItem
    throw UnimplementedError('implement updateItem');
  }
}
