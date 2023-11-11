//Bibliotecas externas
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Classes próprias
import 'package:appseniorcare/componentes/container.dart';
import 'package:appseniorcare/componentes/texto.dart';
import 'package:appseniorcare/componentes/botao.dart';
import 'package:appseniorcare/componentes/mensagem.dart';
import 'package:appseniorcare/mqtt.dart';

//-------------------------- Função 3: Gerencia remédios -----------------------
// Le o estador do gerenciado de remédios no tópico CAIXA_STATUS, que indica se
// o dispositivo está ligado ou não (1 ou 0). Essa função se estende para as
// telas: gerenciador_remedio_caixa e gerenciador_remedio_medicamento, onde
// outros tópicos são usados para configurar elementos da caixa de remédios.
//------------------------------------------------------------------------------

class gerencia_remedio extends StatefulWidget {
  const gerencia_remedio({super.key});

  @override
  State<gerencia_remedio> createState() => _gerencia_remedioState();
}

class _gerencia_remedioState extends State<gerencia_remedio> {
  String lCaixaStatus = ''; //Armazena o tópico CAIXA_STATUS referente ao estado do caixa
  String lCaixaDados = ''; //Armazena o tópico NOVO_INPUT referente ao estado do MPU
  bool status = false; //Controle do botão de liga/desliga

  //Construção da tela
  @override
  Widget build(BuildContext context) {
    return Consumer<ConcreteMqttService>(
        builder: (context, mqttService, child) {
      //Le a mensagem dos tópicos
      lCaixaStatus = mqttService.msgCaixaStatus;
      lCaixaDados = mqttService.msgCaixaDados;

      if (lCaixaStatus == "1")
        status = true;
      else
        status = false;

      //Estrutura da tela
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              backgroundColor: Colors.blue, bottomOpacity: 0.0, elevation: 0.0),
          body: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.05),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.center,
                colors: [Colors.blue, Colors.white],
              )),
              child: SingleChildScrollView(
                  child: Column(
                children: <Widget>[
                  //Cabeçalho azul arredondado
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.05,
                        bottom: MediaQuery.of(context).size.height * 0.04,
                        left: MediaQuery.of(context).size.width * 0.07,
                        right: MediaQuery.of(context).size.width * 0.07,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                              bottomLeft: const Radius.circular(50.0),
                              bottomRight: const Radius.circular(50.0))),
                      child: Column(children: <Widget>[
                        TituloPrincipal(
                            texto: "Gerenciador de remédios",
                            cor: Colors.white),

                        //Descrição da função
                        Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: TextoPadrao(
                                texto:
                                    "Utilize uma caixa de remédios personalizada que,"
                                    " no horário em que se deve tomar a medicação, informará em qual compartimento"
                                    " está localizado o comprimido que deve ser ingerido.",
                                cor: Colors.white70)),

                        //Botão liga-desliga
                        Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: BotaoLigaDesliga(
                              value: status,
                              onChanged: (bool val) {
                                status = val;
                                //Envia mensagem de alerta com o estado do dispositivo.
                                if (lCaixaStatus == "0") {
                                  AlertaPirDesligado(context);
                                }
                                if (lCaixaStatus == "1") {
                                  AlertaPirLigado(context);
                                }
                              }),
                        ),

                        status == true
                            ? TextoPadrao(
                                texto: "Dispositivo ligado",
                                cor: Colors.white70)
                            : TextoPadrao(
                                texto: "Dispositivo desligado",
                                cor: Colors.white70),
                      ])),

                  Imagem(
                      caminho: "img/caixa3d.png",
                      distancia_antes:
                          MediaQuery.of(context).size.height * 0.05,
                      distancia_depois:
                          MediaQuery.of(context).size.height * 0.05),

                  BotaoPadrao(
                      arquivo: "/telas/gerencia_remedio_caixa",
                      texto: "Personalizar caixa",
                      cor: Colors.blue),
                ],
              ))));
    });
  }
}
