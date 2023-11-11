//Bibliotecas externas
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Classes próprias
import 'package:appseniorcare/mqtt.dart';

//Telas
import 'package:appseniorcare/telas/inicio.dart';
import 'package:appseniorcare/telas/menu.dart';
import 'package:appseniorcare/telas/menu_navegacao.dart';
import 'package:appseniorcare/telas/login.dart';
import 'package:appseniorcare/telas/cadastro.dart';
import 'package:appseniorcare/telas/explicacao.dart';
import 'package:appseniorcare/telas/explicacao1.dart';
import 'package:appseniorcare/telas/gerencia_remedio.dart';
import 'package:appseniorcare/telas/identifica_queda.dart';
import 'package:appseniorcare/telas/risco_queda.dart';
import 'package:appseniorcare/telas/gerencia_remedio_caixa.dart';
import 'package:appseniorcare/telas/gerencia_remedio_medicamento.dart';

// Inicializa app
void main() {
  runApp(MyApp());
}

// Retorna a classe ChangeNotifierProvider, que notifica os ouvintes (widgets) quando os dados do broker forem alterados.
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ConcreteMqttService(),
      child: MaterialApp (
          initialRoute: "/",
          routes: {
            "/telas/login": (context) => login(),
            "/telas/cadastro": (context) => cadastro(),
            "/telas/inicio": (context) => inicio(),
            "/telas/menu_navegacao": (context) => menu_navegacao(),
            "/telas/menu": (context) => menu(),
            "/telas/risco_queda": (context) => risco_queda(),
            "/telas/identifica_queda": (context) => identifica_queda(),
            "/telas/gerencia_remedio": (context) => gerencia_remedio(),
            "/telas/explicacao": (context) => explicacao(),
            "/telas/explicacao1": (context) => explicacao1(),
            "/telas/gerencia_remedio_caixa": (context) => gerencia_remedio_caixa(),
            "/telas/gerencia_remedio_medicamento": (context) => gerencia_remedio_medicamento(),
          },
        title: "SeniorCare",
        theme: ThemeData(primarySwatch: Colors.blue),
        home: inicio(),
        debugShowCheckedModeBanner: false
      ),
    );
  }
}