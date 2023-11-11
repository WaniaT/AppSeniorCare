import 'package:flutter/material.dart';
import 'package:appseniorcare/componentes/texto.dart';
import 'package:appseniorcare/componentes/container.dart';
import 'package:appseniorcare/componentes/botao.dart';

//----------------------------- Tela explicação --------------------------------
class explicacao1 extends StatefulWidget {
  const explicacao1({super.key});

  @override
  State<explicacao1> createState() => _explicacao1State();
}

class _explicacao1State extends State<explicacao1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
            backgroundColor: Colors.blue,
            bottomOpacity: 0.0,
            elevation: 0.0),
        body:Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.045,
                bottom: MediaQuery.of(context).size.height * 0.05,

                //Tratamento pra larguras diferentes de telas
                left: MediaQuery.of(context).size.width < 500 ?
                MediaQuery.of(context).size.width * 0.05:
                MediaQuery.of(context).size.width * 0.30,

                right: MediaQuery.of(context).size.width < 500 ?
                MediaQuery.of(context).size.width * 0.05:
                MediaQuery.of(context).size.width * 0.30,

            ),
            child: const SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center, //eixo x
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, //eixo y
                  children: <Widget>[
                    TituloPrincipal(texto: "Funções", cor: Colors.white),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: TextoPadrao(
                          texto: "O sistema SeniorCare possui três funções principais: Detecção de risco de queda, Identificação de incidente de queda e Gerenciador de remédios, "
                              "você pode ativá-las e configurá-las conforme preferir. ",
                          cor: Colors.white70),
                    ),

                    Imagem(caminho: "img/quarto.png", distancia_antes: 30, distancia_depois: 50),
                    //(texto: "Login", cor: Colors.white, arquivo: "/telas/login"),
                    //BotaoPadrao(texto: "Cadastre-se", cor: Colors.white, arquivo: "/telas/cadastro"),
                    BotaoPadrao(texto: "Começar", cor: Colors.white, arquivo: "/telas/menu_navegacao"),
                  ],
                )))
    );
  }
}
