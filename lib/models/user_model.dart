
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'user_model.freezed.dart';

@freezed
@HiveType(typeId: 0)
class User with _$User {
  @HiveField(0)
  const factory User({
    required String id,
    required String name,
    required String email,
    required DateTime createdAt,
  }) = _User;
}
