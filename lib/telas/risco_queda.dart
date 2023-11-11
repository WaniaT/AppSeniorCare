//Bibliotecas externas
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typed_data/src/typed_buffer.dart';
import 'dart:async';

//Classes próprias
import 'package:appseniorcare/componentes/container.dart';
import 'package:appseniorcare/componentes/texto.dart';
import 'package:appseniorcare/componentes/botao.dart';
import 'package:appseniorcare/componentes/mensagem.dart';
import 'package:appseniorcare/mqtt.dart';

//-------------------- Função 1: Detecta o risco de queda ----------------------
// Le o estado do sensor de movimento PIR no tópico ESTADO_SENSOR. Se a mensagem
// no tópico for "Detectado", representa que há risco de queda, se for
// "no_moviment", não foi detectado risco. Além disso, verifica a cada 30 segundos
// se o sensor enviou alguma mensagem nova, para determinar se continua ligado ou não.
//------------------------------------------------------------------------------

class risco_queda extends StatefulWidget {
  const risco_queda({super.key});

  @override
  State<risco_queda> createState() => _risco_quedaState();
}

class _risco_quedaState extends State<risco_queda> {
  //Tópicos MQTT
  String lPirQueda = ''; // Le as mensagens do tópico ESTADO_SENSOR

  //Controle interno
  bool status = false;
  bool iniciouTela = false;
  bool enviouMensagem = false;
  Timer? timer;
  String ultimaMensagem = ''; // Variável para armazenar a última mensagem recebida

  @override
  Widget build(BuildContext context) {
    return Consumer<ConcreteMqttService>(
      builder: (context, mqttService, child) {
        // Recupera os valores dos tópicos
        lPirQueda = mqttService.msgPirQueda;

        //Manda um tópico vazio ao iniciar a tela para garantir que não há sujeira no tópico
        if (iniciouTela == false) {
          final message = ' ';
          final uint8Buffer = Uint8Buffer();
          uint8Buffer.addAll(message.codeUnits);
          mqttService.publishMessage('ESTADO_SENSOR', uint8Buffer);
          iniciouTela = true;
        }

        // Verifica se a mensagem atual é diferente da última mensagem recebida
        if (lPirQueda != ultimaMensagem) {
          // Atualiza a última mensagem
          ultimaMensagem = lPirQueda;

          if (lPirQueda == "Detectado" || lPirQueda == "no moviment") {
            status = true;
            print("testou está ligado");

            // Cancela o timer se estiver ativo
            timer?.cancel();
            timer = null;

            // Inicia um timer e envia a mensagem vazia novamente caso ele atinja 30 segundos
            timer = Timer(Duration(seconds: 30), () {
              if (!enviouMensagem) {
                final message = ' ';
                final uint8Buffer = Uint8Buffer();
                uint8Buffer.addAll(message.codeUnits);
                mqttService.publishMessage('ESTADO_SENSOR', uint8Buffer);
              }
              timer?.cancel();
              timer = null;
            });
          }

          else if (lPirQueda == " ") {
            status = false;
            print("testou está desligado");

            // Cancela o timer se estiver ativo
            timer?.cancel();
            timer = null;
          }
        }

        //Estrutura da tela
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                backgroundColor: Colors.blue,
                bottomOpacity: 0.0,
                elevation: 0.0),
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
                              texto: "Detector de risco de queda",
                              cor: Colors.white),

                          //Descrição da função
                          Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: TextoPadrao(
                                  texto:
                                      "Para pessoas que necessitem de maior amparo na mobilidade,"
                                      " posicione um sensor próximo ao pé da cama e receba um"
                                      " alerta quando o idoso precisar de ajuda para se locomover",
                                  cor: Colors.white70)),

                          //Botão liga-desliga
                          Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: BotaoLigaDesliga(
                                value: status,
                                onChanged: (bool val) {
                                  status = val;
                                  //Envia mensagem de alerta com o estado do dispositivo.
                                  status
                                      ? AlertaPirDesligado(context)
                                      : AlertaPirLigado(context);
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
                        caminho: "img/pir3d.png",
                        distancia_antes:
                            MediaQuery.of(context).size.height * 0.05,
                        distancia_depois:
                            MediaQuery.of(context).size.height * 0.05),

                    lPirQueda == "Detectado" //3&& status == true
                        ? TextoPadrao(
                            texto: "Risco de queda detectado!",
                            cor: Colors.blue)
                        : TextoPadrao(
                            texto: "Nenhum risco de queda detectado",
                            cor: Colors.blue),

                    // BotaoPadrao(arquivo: "/horario", texto: "Definir horário", cor: Colors.blue),
                  ],
                ))));
      },
    );
  }
}
