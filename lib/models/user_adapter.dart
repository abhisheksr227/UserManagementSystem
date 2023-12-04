import 'package:hive/hive.dart';
import 'package:usermanagementsystem/models/user_model.dart';

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    // Placeholder for a default user
    User defaultUser = User(id: '', name: '', email: '', createdAt: DateTime.now());

    try {
      // Implement logic to read data from Hive box
      // Example: return User(...);
    } catch (e) {
      // Log or handle the exception, and return the default user
      print('Error reading user data: $e');
    }

    // Return the default user in case of an error or if reading is incomplete
    return defaultUser;
  }

  @override
  void write(BinaryWriter writer, User obj) {
    // Implement logic to write data to Hive box
    // Example: writer.write(obj.id);
    // writer.write(obj.name);
    // writer.write(obj.email);
    // writer.write(obj.createdAt);
  }
}
