import '../../domain/entities/entity_interface.dart';
import '../../domain/repositories/crud_repository.dart';
import '../models/sources_type.dart';
import '../models/target_platform.dart';

abstract class CRUDSource<T extends IEntity> extends CRUDRepository<T> {
  List<IPlatform> get platforms;
  SourceType get type;
}
