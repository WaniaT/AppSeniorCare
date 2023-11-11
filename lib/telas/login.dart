import 'package:flutter/material.dart';
import 'package:appseniorcare/componentes/texto.dart';
import 'package:appseniorcare/componentes/container.dart';
import 'package:appseniorcare/componentes/botao.dart';
import 'package:appseniorcare/componentes/campo_texto.dart';

//-------------------------------- Tela de Login -------------------------------
class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController _email = TextEditingController();
  TextEditingController _senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
        ),

        //Conteúdo
        body: Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.05,
                bottom: MediaQuery.of(context).size.height * 0.05,
                left: MediaQuery.of(context).size.height * 0.001,
                right: MediaQuery.of(context).size.height * 0.001
            ),
            child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TituloPrincipal(texto: "Login", cor: Colors.blue),

                    //Subtítulo
                    const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 15),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextoPadrao(
                                  texto: "Entre em sua conta ou  ",
                                  cor: Colors.black45),
                              BotaoLink(arquivo: "/telas/cadastro", texto: "cadastre-se")
                            ])),

                    //Campos
                    CampoEmail(texto: "E-mail", controlador: _email),
                    CampoSenha(controlador: _senha),

                    //Imagem
                    const Imagem(
                        caminho: "img/old-woman256.png",
                        distancia_antes: 30,
                        distancia_depois: 50),

                    //Botão Login
                    BotaoPadrao(
                        arquivo: "/menu_navegacao",
                        texto: "Entrar na conta",
                        cor: Colors.blue),
                  ],
                ))));
  }
}
