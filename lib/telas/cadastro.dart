import 'package:flutter/material.dart';
import 'package:appseniorcare/componentes/texto.dart';
import 'package:appseniorcare/componentes/container.dart';
import 'package:appseniorcare/componentes/botao.dart';
import 'package:appseniorcare/componentes/campo_texto.dart';

//------------------------------ Tela de Cadastro ------------------------------
class cadastro extends StatefulWidget {
  const cadastro({super.key});

  @override
  State<cadastro> createState() => _cadastroState();
}

class _cadastroState extends State<cadastro> {

  bool status = false; //pegar do banco - estado que o usuario deixou a funcao
  bool value = false;

  TextEditingController _nome = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _telefone = TextEditingController();
  TextEditingController _senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    TituloPrincipal(texto: "Cadastre-se", cor: Colors.blue),

                    //Subtítulo
                    const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 15),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextoPadrao(
                                  texto: "Crie uma conta ou  ",
                                  cor: Colors.black45),
                              BotaoLink(arquivo: "/telas/login", texto: "faça login")
                            ])),

                    //Campos
                    CampoTexto(texto: "Nome", controlador: _nome),
                    CampoEmail(texto: "E-mail", controlador: _email),
                    CampoSenha(controlador: _senha),
                    CampoNumero(texto: "Telefone", controlador: _telefone),

                    //Ler política de privacidade
                    Container(
                        width: 300,
                        padding: EdgeInsets.only(top: 30),
                        child: Row(children: [
                          Padding(
                            padding: EdgeInsets.only(top: 1, left: 0),
                            child: BotaoLigaDesliga(
                              value: status,
                              onChanged: (bool val) {
                                setState(() {
                                  status = val;
                                });
                              },
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: TextoPadrao(
                                  texto: "Li e concordo com os  ",
                                  cor: Colors.black45)),
                          BotaoLink(arquivo: "/termos", texto: "termos")
                        ])),

                    //Imagem
                    Imagem(caminho: "img/old-man128.png", distancia_antes: 20, distancia_depois: 20),

                    //Botão Login
                    BotaoPadrao(
                        arquivo: "/menu_navegacao",
                        texto: "Criar conta",
                        cor: Colors.blue),
                  ],
                ))));
  }
}