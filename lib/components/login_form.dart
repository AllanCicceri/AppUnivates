import 'package:flutter/material.dart';
import 'package:univates_app/components/custom_dialog.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String loginText = "";

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 350,
          child: TextField(
            controller: userController,
            decoration: const InputDecoration(
                labelText: 'User', border: OutlineInputBorder()),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: 350,
          child: TextField(
            controller: passwordController,
            decoration: const InputDecoration(
                labelText: 'Password', border: OutlineInputBorder()),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
            child: const Text('Login'),
            onPressed: () {
              String loginReturn =
                  _onPressed(userController.text, passwordController.text);

              if (loginReturn.contains("-")) {
                String tip =
                    loginReturn.substring(loginReturn.indexOf("-") + 1);
                loginReturn =
                    loginReturn.substring(0, loginReturn.indexOf("-") - 1);

                showDialog(
                  context: context,
                  builder: (_) => const CustomDialog(),
                  barrierDismissible: false,
                ).then((value) => {
                      if (value != null)
                        {
                          if (value)
                            {
                              setState(() {
                                loginText = tip;
                              })
                            }
                          else
                            {
                              setState(() {
                                loginText = "";
                              })
                            }
                        }
                    });
              }

              setState(() {
                loginText = loginReturn;
              });

              if (loginText == "Usuário logado") {
                Navigator.pushReplacementNamed(
                  //aqui estou indo para a rota home, caso o usuário logue (user/pass validos)
                  context,
                  "/home",
                );
              }
            }),
        const SizedBox(
          height: 10,
        ),
        Text(
          loginText,
          style: const TextStyle(color: Colors.red),
        ),
      ],
    ));
  }
}

String _onPressed(String name, String pass) {
  List<User> users = [
    User("juca", "bala", "um prof da univates costuma usar este nome"),
    User("minha", "vo", "é uma velinha que todo mundo ama"),
    User("root", "root", "user e senha padrão de um mysql foda"),
  ];

  bool userExists = users.any((user) => user.name == name);
  bool userAndPassMatch =
      users.any((user) => user.name == name && user.password == pass);

  if (userAndPassMatch) return "Usuário logado";

  if (userExists) {
    String tip = users.where((e) => e.name == name).first.tip;
    return "Usuário existe mas senha não bate -$tip";
  }

  return "Usuário não existe";
}

class User {
  String name;
  String password;
  String tip;

  User(this.name, this.password, this.tip);
}
