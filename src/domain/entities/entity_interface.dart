import 'package:equatable/equatable.dart';

abstract class IEntity extends Equatable {
  const IEntity(this.id);
  final int id;
}
