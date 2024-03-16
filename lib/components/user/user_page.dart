import 'package:flutter/material.dart';
import 'package:univates_app/components/user/user_form.dart';

class UserPage extends StatelessWidget {
  final Map<String, dynamic>? user;

  const UserPage({
    super.key,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro de Usuário"),
      ),
      body: Center(
        child: UserForm(
          user: user,
        ),
      ),
    );
  }
}
