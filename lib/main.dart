import 'package:flutter/material.dart';
import 'package:univates_app/components/home/home_page.dart';

import 'package:univates_app/login.dart';

void main() async {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute:
          "/login", //aqui ficam as rotas, quando o sistema inicia, inicia na initialRoute (posso empurrar a tela via rotas de qualquer lugar do código)
      routes: {
        '/login': (context) => const Login(),
        '/home': (context) => HomePage(
              route: "home",
            ),
      },
    );
  }
}
