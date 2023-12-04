
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usermanagementsystem/screens/user_list_screen.dart';
import '../models/user_model.dart';
import '../view_models/user_list_view_model.dart';

class AddUserScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Add User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
              validator: (value) {
                if (value == null || value.isEmpty || !value.contains('@')) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text;
                final email = emailController.text;

                if (name.isNotEmpty && email.isNotEmpty && email.contains('@')) {
                  final newUser = User(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: name,
                    email: email,
                    createdAt: DateTime.now(),
                  );

                  try {
                    Provider.of<UserListViewModel>(context, listen: false).addUser(newUser);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserListScreen()));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('An error occurred while adding the user'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter valid name and email'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: Text('Add User'),
            ),
          ],
        ),
      ),
    );
  }
}
