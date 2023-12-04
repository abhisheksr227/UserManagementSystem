import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../view_models/user_list_view_model.dart';
import 'add_user_screen.dart';
import 'user_details_screen.dart';

class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserListViewModel>(
      builder: (context, userViewModel, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey,
            title: Text('User Management System'),
          ),
          body: userViewModel.users.isEmpty
              ? _buildEmptyState(context)
              : _buildUserList(context, userViewModel),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddUserScreen(),
                ),
              );
              if (result != null) {
                // Handle the result if needed
              }
            },
            child: Icon(Icons.add,color: Colors.white),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No users found !',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 16),
          Text(
            'Click the + button to add a new user',

            style: TextStyle(color: Colors.green),
          ),
          SizedBox(height: 10),
          Text(
            'Long press to delete a  user',

            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildUserList(BuildContext context, UserListViewModel userViewModel) {
    return ListView.separated(
      itemCount: userViewModel.users.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) {
        final user = userViewModel.users[index];
        return Card(
          color: Colors.teal,
          elevation: 5,
          child: ListTile(
            title: Text(user.name),
            subtitle: Text(user.email),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDetailsScreen(user),
                ),
              );
            },
            onLongPress: () {
              _showDeleteConfirmationDialog(context, user, userViewModel);
            },
          ),
        );
      },
    );
  }

  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, User user, UserListViewModel userViewModel) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete User'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete ${user.name}?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                try {
                  userViewModel.deleteUser(user.id);
                  Navigator.of(context).pop();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('An error occurred while deleting the user'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
