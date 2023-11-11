//Bibliotecas externas
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:provider/provider.dart';
import 'package:typed_data/src/typed_buffer.dart';

//Classes próprias
import 'package:appseniorcare/componentes/texto.dart';
import 'package:appseniorcare/componentes/container.dart';
import 'package:appseniorcare/componentes/botao.dart';
import '../mqtt.dart';

//-------------------------------- Tela Inicial --------------------------------
class inicio extends StatefulWidget {
  const inicio({super.key});

  @override
  State<inicio> createState() => _inicioState();
}

class _inicioState extends State<inicio> {
  bool mandouMensagem = false; //Controle de envio de mensagem

  @override
  Widget build(BuildContext context) {
    //Cria instância de conexão ao HiveMQ usando Provider para ser acessível às outras telas
    final mqttService =
        Provider.of<ConcreteMqttService>(context, listen: false);
    mqttService.connectAndNotify();

    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
            backgroundColor: Colors.blue, bottomOpacity: 0.0, elevation: 0.0),
        body: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.05,
                bottom: MediaQuery.of(context).size.height * 0.05),
            child: const SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, //eixo x
              mainAxisAlignment: MainAxisAlignment.center, //eixo y
              children: <Widget>[
                TituloPrincipal(texto: "SeniorCare", cor: Colors.white),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: TextoPadrao(
                      texto: "A sua assistência, sempre à mão.",
                      cor: Colors.white70),
                ),

                Imagem(
                    caminho: "img/nursing-home.png", //nursing-home
                    distancia_antes: 40,
                    distancia_depois: 40),
                //(texto: "Login", cor: Colors.white, arquivo: "/telas/login"),
                //BotaoPadrao(texto: "Cadastre-se", cor: Colors.white, arquivo: "/telas/cadastro"),
                BotaoPadrao(
                    texto: "Começar",
                    cor: Colors.white,
                    arquivo: "/telas/menu_navegacao"),
                BotaoPadrao(
                    texto: "Sobre o app",
                    cor: Colors.white,
                    arquivo: "/telas/explicacao"),
              ],
            ))));
  }
}
