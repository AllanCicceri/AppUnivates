import 'package:flutter/material.dart';
import 'package:univates_app/components/hamburguer.dart';
import 'package:univates_app/components/home/home_screen.dart';
import 'package:univates_app/components/home/users_list.dart';
import 'package:univates_app/components/user/user_page.dart';

class HomePage extends StatefulWidget {
  String route = "";
  HomePage({Key? key, required this.route}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void GetRoute(String rota) {
    setState(() {
      widget.route = rota;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Usuários"),
        actions: [
          IconButton(
            onPressed: () => _onPressed(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: Hamburguer(
        callback: GetRoute,
      ),
      body: widget.route == "home"
          ? HomeScreen()
          : UsersList(
              context: context,
            ),
    );
  }
}

void _onPressed(context) async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const UserPage()),
  );

  if (result is bool && result == true) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Dados salvos com sucesso!')),
    );

    // Reconstruir a tela
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          route: "home",
        ),
      ),
    );
  }
}
