import 'package:flutter/material.dart';
import 'package:univates_app/db/sqllite.dart';

class HomeScreen extends StatelessWidget {
  final dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    Future<int> getUserCount() async {
      DatabaseHelper db = DatabaseHelper();
      List<Map<String, dynamic>> result = await db.query('usuario');
      return result.length;
    }

    return FutureBuilder<int>(
      future: getUserCount(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final userCount = snapshot.data!;
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Text(
                "Bem-Vindo! Neste momento, $userCount usuários cadastrados",
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Erro ao carregar dados do banco de dados"),
          );
        } else {
          return const Center(
            child:
                CircularProgressIndicator(), // Mostra um indicador de carregamento enquanto os dados estão sendo carregados
          );
        }
      },
    );
  }
}
