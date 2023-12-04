
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'user_model.freezed.dart';

@freezed
@HiveType(typeId: 0)
class User with _$User {
  @HiveField(0)
  const factory User({
    @HiveField(1) required String id,
    @HiveField(2) required String name,
    @HiveField(3) required String email,
    @HiveField(4) required DateTime createdAt,
  }) = _User;
}
