import 'package:network_connection_checker/network_connection_checker.dart';

import '../../domain/entities/entity_interface.dart';
import '../../domain/repositories/crud_repository.dart';
import '../datasources/crud_source_interface.dart';
import '../models/request_type.dart';
import '../models/sources_type.dart';

class CRUDRepositoryImpl<T extends IEntity> implements CRUDRepository<T> {
  CRUDRepositoryImpl({
    required this.networkConnectionChecker,
    List<CRUDSource<T>>? sources,
  }) : _sources = sources ?? const [];

  final List<CRUDSource<T>> _sources;
  final NetworkConnectionChecker networkConnectionChecker;

  Future<bool> isMatchedSource(CRUDSource source, RequestType type) async {
    var connectionStatus = await networkConnectionChecker.status.last;
    if (type == RequestType.any) return true;
    return connectionStatus == false
        ? type == RequestType.local
        : source.type == SourceType.local
            ? type == RequestType.local
            : type == RequestType.remote;
  }

  @override
  Future<T> addItem(T item) async {
    try {
      for (var source in _sources) {
        await source.addItem(item);
      }
      return item;
    } catch (e) {
      throw Exception(
          'MyBeautifulException ---> $CRUDRepositoryImpl.addItem() ---> error: $e');
    }
  }

  @override
  Future<T> deleteItem(T item) async {
    try {
      for (var source in _sources) {
        await source.deleteItem(item);
      }
      return item;
    } catch (e) {
      throw Exception(
          'MyBeautifulException => $CRUDRepositoryImpl.getItemsByIds() =>  error: $e');
    }
  }

  @override
  Future<T> updateItem(T item) async {
    try {
      for (var source in _sources) {
        return await source.updateItem(item);
      }
      return item;
    } catch (e) {
      throw Exception(
          'MyBeautifulException => $CRUDRepositoryImpl.updateItem() =>  error: $e');
    }
  }

  @override
  Future<T?> getItem(int id) async {
    for (var source in _sources) {
      try {
        return await source.getItem(id);
      } catch (e) {
        throw Exception(
            'MyBeautifulException => $source.getItem() =>  error: $e');
      }
    }
    return null;
  }

  @override
  Future<List<T>> getItems({
    RequestType requestType = RequestType.any,
  }) async {
    for (var source in _sources) {
      if (await isMatchedSource(source, requestType) == true) {
        try {
          return source.getItems();
        } catch (e) {
          throw Exception(
              'MyBeautifulException => $source.getItems() =>  error: $e');
        }
      }
    }
    return <T>[];
  }

  @override
  Future<List<T>> getItemsByIds(
    List<int> ids, {
    RequestType requestType = RequestType.any,
  }) async {
    for (var source in _sources) {
      if (await isMatchedSource(source, requestType) == true) {
        try {
          return source.getItemsByIds(ids);
        } catch (e) {
          throw Exception(
              'MyBeautifulException => $source.getItemsByIds() =>  error: $e');
        }
      }
    }
    return <T>[];
  }

  @override
  Stream<T?> listenItem({
    RequestType requestType = RequestType.any,
  }) async* {
    for (var source in _sources) {
      if (await isMatchedSource(source, requestType) == true) {
        try {
          yield* source.listenItem();
        } catch (e) {
          throw Exception(
              'MyBeautifulException => $source.listenItem() =>  error: $e');
        }
      }
    }
    yield* Stream.fromIterable(<T>[]);
  }

  @override
  Stream<T?> listenItemByIds(
    List<int> ids, {
    RequestType requestType = RequestType.any,
  }) async* {
    for (var source in _sources) {
      if (await isMatchedSource(source, requestType) == true) {
        try {
          yield* source.listenItemByIds(ids);
        } catch (e) {
          throw Exception(
              'MyBeautifulException => $source.listenItemByIds() =>  error: $e');
        }
      }
    }
    yield* Stream.fromIterable(<T>[]);
  }
}
