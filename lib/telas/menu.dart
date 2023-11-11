import 'package:flutter/material.dart';
import 'package:appseniorcare/componentes/texto.dart';
import 'package:appseniorcare/componentes/botao.dart';

//-------------------------------- Tela de Menu --------------------------------
class menu extends StatefulWidget {
  const menu({super.key});

  @override
  State<menu> createState() => _menuState();
}

class _menuState extends State<menu> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.10,
            bottom: MediaQuery.of(context).size.height * 0.05,

            //Tratamento pra larguras diferentes de telas
            left: MediaQuery.of(context).size.width < 500 ?
            MediaQuery.of(context).size.width * 0.001:
            MediaQuery.of(context).size.width * 0.30,

            right: MediaQuery.of(context).size.width < 500 ?
            MediaQuery.of(context).size.width * 0.001:
            MediaQuery.of(context).size.width * 0.30,
        ),
        child: const SingleChildScrollView(
            child: Column(

              children: <Widget>[
                //Título
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: TituloPrincipal(texto: "Bem vindo!", cor: Colors.blue),
                ),

                //Subtítulo
                Padding(
                    padding:
                    EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
                    child: TextoPadrao( texto:
                        "Personalize os seus dispositivos assistentes como preferir",
                        cor: Colors.black45)),

                //Funcionalidades
                Padding(
                    padding: EdgeInsets.all(10), //espaço entre os componentes
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        BotaoFuncao(arquivo: "/telas/risco_queda", nome_imagem: "img/icon/motion.png"),
                        BotaoFuncao(arquivo: "/telas/identifica_queda", nome_imagem: "img/icon/smartwatch.png"),
                        BotaoFuncao(arquivo: "/telas/gerencia_remedio", nome_imagem: "img/icon/drug.png"),
                      ],
                    )),

                //Legenda das funcionalidades
                Padding(
                    padding: EdgeInsets.all(10), //espaço entre os componentes
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: [
                              Row(children: <Widget>[
                                Text("Detector de",
                                    style: TextStyle(fontSize: 13, color: Colors.black45))
                              ]),
                              Row(children: <Widget>[
                                Text("risco de queda",
                                    style: TextStyle(fontSize: 13, color: Colors.black45))
                              ])
                            ],
                          ),
                          Column(
                            children: [
                              Row(children: <Widget>[
                                Text("Identificador",
                                    style: TextStyle(fontSize: 13, color: Colors.black45))
                              ]),
                              Row(children: <Widget>[
                                Text("de queda",
                                    style: TextStyle(fontSize: 13, color: Colors.black45))
                              ]),
                            ],
                          ),
                          Column(
                            children: [
                              Row(children: <Widget>[
                                Text("Gerenciador",
                                    style: TextStyle(fontSize: 13, color: Colors.black45))
                              ]),
                              Row(children: <Widget>[
                                Text("de remédios",
                                    style: TextStyle(fontSize: 13, color: Colors.black45))
                              ])
                            ],
                          ),
                        ])),

                Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //Complementos
                          BotaoFuncaoComplementar(
                              arquivo: "/telas/contatos",
                              nome_imagem: "img/icon/phone-call.png",
                              descricao: "Contatos de emergência"),
                          BotaoFuncaoComplementar(
                              arquivo: "/telas/guia",
                              nome_imagem: "img/icon/information.png",
                              descricao: "Guia: prevenção de quedas"),
                        ])),
              ],
            )));
  }
}
