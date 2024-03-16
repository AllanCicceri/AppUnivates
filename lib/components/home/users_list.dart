import 'package:flutter/material.dart';
import 'package:univates_app/components/home/home_page.dart';
import 'package:univates_app/components/user/user_page.dart';
import 'package:univates_app/db/sqllite.dart';

class UsersList extends StatelessWidget {
  final BuildContext context;
  const UsersList({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _getUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Erro ao carregar os usuários'));
        } else {
          List<Map<String, dynamic>> users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  _editUser(context, users[index]);
                },
                child: ListTile(
                  leading: Text(users[index]['id'].toString()),
                  title: Text(users[index]['nome']),
                  subtitle: Text(users[index]['email']),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _removeUser(context, users[index]['id']),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  Future<List<Map<String, dynamic>>> _getUsers() async {
    DatabaseHelper db = DatabaseHelper();
    List<Map<String, dynamic>> users = await db.query("usuario");
    return users;
  }
}

void _removeUser(context, id) {
  DatabaseHelper db = DatabaseHelper();
  db.delete("usuario", id);
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
        builder: (context) => HomePage(
              route: "lista",
            )),
  );
}

void _editUser(context, user) async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => UserPage(
              user: user,
            )),
  );

  if (result is bool && result == true) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => HomePage(
                route: "lista",
              )),
    );
  }
}
