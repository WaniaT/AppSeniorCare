//Bibliotecas externas
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Classes próprias
import 'package:appseniorcare/telas/menu.dart';
import '../mqtt.dart';

//--------------------- Tela menu navegação - rodape ---------------------------
class menu_navegacao extends StatefulWidget {
  const menu_navegacao({super.key});

  @override
  State<menu_navegacao> createState() => _menu_navegacaoState();
}

class _menu_navegacaoState extends State<menu_navegacao> {

  int _indiceAtual = 0; // Variável para controlar o índice das telas
  //bool mandouMensagem = false; //Controle de envio de mensagem

  final List<Widget> _telas = [
    menu(),
   // perfil(),
   // configuracao()
  ];

  void onTabTapped(int index) {
    setState(() {
      _indiceAtual = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConcreteMqttService>(
        builder: (context, mqttService, child)
    {
      // Recupera os valores do tópico ESTADO_SENSOR
      //final lPirQueda = mqttService.msgPirQueda;
      // Manda uma mensagem vazia ao inicializar a tela para garantir que não
      // há sujeira no tópico
      //if (mandouMensagem == false) {
      //  final message = ' ';
      //  final uint8Buffer =
      //  Uint8Buffer(); // Converte a mensagem de string para binario
      //  uint8Buffer.addAll(message.codeUnits);
      //  mqttService.publishMessage('ESTADO_SENSOR', uint8Buffer);
      //  mandouMensagem = true;
     // }

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.blue,
            elevation: 0
        ),
        body: _telas[_indiceAtual],
        //bottomNavigationBar: BottomNavigationBar(
        //  onTap: onTabTapped,
        //  currentIndex: _indiceAtual,
        //   items: [
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.menu), label: "Início"),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.person), label: "Minha conta"),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.app_registration), label: "Configurações"),
        //   ],
        //  ),
      );
    });
        }
}
