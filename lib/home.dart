import 'package:flutter/material.dart';
import 'package:univates_app/components/user/user_form.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro de Usuários"),
        backgroundColor: Colors.grey[200],
      ),
      body: const UserForm(),
    );
  }
}
