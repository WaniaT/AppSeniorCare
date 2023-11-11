import 'package:flutter/material.dart';
import 'package:appseniorcare/componentes/texto.dart';
import 'package:appseniorcare/componentes/container.dart';
import 'package:appseniorcare/componentes/botao.dart';

//----------------------------- Tela explicação --------------------------------
class explicacao extends StatefulWidget {
  const explicacao({super.key});

  @override
  State<explicacao> createState() => _explicacaoState();
}

class _explicacaoState extends State<explicacao> {
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
                    TituloPrincipal(texto: "Público-alvo", cor: Colors.white),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: TextoPadrao(
                          texto: "O aplicativo SeniorCare se destina a cuidadores de idosos e pessoas na terceira idade, que possuam um ou mais dipositivos SeniorCare.",
                          cor: Colors.white70),
                    ),

                    Imagem(caminho: "img/ajuda.png", distancia_antes: 50, distancia_depois: 50),
                    //(texto: "Login", cor: Colors.white, arquivo: "/telas/login"),
                    //BotaoPadrao(texto: "Cadastre-se", cor: Colors.white, arquivo: "/telas/cadastro"),
                    BotaoPadrao(texto: "Próximo", cor: Colors.white, arquivo: "/telas/explicacao1"),
                  ],
                )))
    );
  }
}
