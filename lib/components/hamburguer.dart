import 'package:flutter/material.dart';
import 'package:univates_app/components/user/user_page.dart';

class Hamburguer extends StatelessWidget {
  final void Function(String) callback;

  Hamburguer({Key? key, required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(240, 240, 240, 1.0),
            ),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text("juca"),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              callback("home");
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Lista de Usuários'),
            onTap: () {
              callback("lista");
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

void _NavigateToLista(context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const UserPage()),
  );
}

void _NavigateToCadastro(context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const UserPage()),
  );
}
