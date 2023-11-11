//Bibliotecas externas
import 'package:flutter/material.dart';
import 'package:typed_data/src/typed_buffer.dart';
import 'package:provider/provider.dart';

//Classes próprias
import 'package:appseniorcare/componentes/container.dart';
import 'package:appseniorcare/componentes/texto.dart';
import 'package:appseniorcare/componentes/botao.dart';
import 'package:appseniorcare/componentes/mensagem.dart';
import 'package:appseniorcare/mqtt.dart';

//----------------- Função 2: Identifica ocorrência de queda -------------------
// Le o estado do acelerômetro e giroscópio MPU6050 nos tópicos MPU_STATUS, que
// indica se o dispositivo está ligado ou não, e MPU_QUEDA, que indica se houve
// uma queda ou não.
//------------------------------------------------------------------------------

class identifica_queda extends StatefulWidget {
  const identifica_queda({super.key});

  @override
  State<identifica_queda> createState() => _identifica_quedaState();
}

class _identifica_quedaState extends State<identifica_queda> {
  String lMpuStatus = ''; //Armazena o tópico MPU_STATUS referente ao estado do MPU
  String lMpuQueda = ''; //Armazena o tópico MPU_QUEDA referente a ocorrência de queda
  bool status = false; //Controle do botão de liga/desliga

  //Contrução da tela
  @override
  Widget build(BuildContext context) {
    return Consumer<ConcreteMqttService>(
        builder: (context, mqttService, child) {

          // Recupera os valores dos tópicos
          lMpuStatus = mqttService.msgMpuStatus;
          lMpuQueda = mqttService.msgMpuQueda;

          // Determina o estado do dispositivo
          if (lMpuStatus == '1')
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
                        colors: [Colors.blue, Colors.white])),
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
                              TituloPrincipal(texto: "Identificador de queda", cor: Colors.white),
                              //Descrição da função
                              Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: TextoPadrao(
                                      texto: "Utilize um dispositivo que monitore a mobilidade da pessoa idosa e, no "
                                          "caso de queda, a Alexa prestará socorro por comando de voz. Você será "
                                          "notificado mediante a necessidade de ajuda.",
                                      cor: Colors.white70)),

                              //Botão liga-desliga
                              Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                child: BotaoLigaDesliga(
                                    value: status,
                                    onChanged: (bool val) {
                                      //Se o dispositivo estiver desligado envia notificação de alerta
                                      if (status == false) {
                                        AlertaMpuDesligado(context);
                                      }

                                      //Se estiver ligado pode mudar o estado para desligado
                                      else if (status == true) {
                                        setState(() {
                                          final message = '0';
                                          final uint8Buffer = Uint8Buffer(); // Converte a mensagem de string para binario
                                          uint8Buffer.addAll(message.codeUnits);
                                          mqttService.publishMessage('MPU_STATUS', uint8Buffer); //Publica mensagem MQTT
                                       });
                                      }
                                      status = val;
                                    })),
                              status == true ?
                              TextoPadrao (texto: "Dispositivo ligado", cor: Colors.white70) :
                              TextoPadrao(texto: "Dispositivo desligado", cor: Colors.white70)])),
                          Imagem(
                              caminho: "img/mpu3d.png",
                              distancia_antes: MediaQuery.of(context).size.height * 0.05,
                              distancia_depois: MediaQuery.of(context).size.height * 0.05),

                          lMpuQueda == "1" && (lMpuStatus == "1" || lMpuStatus == " 1")
                              ? TextoPadrao(texto: "Queda identificada!", cor: Colors.blue)
                              : TextoPadrao(texto: "Nenhuma queda identificada", cor: Colors.blue),

                  // BotaoPadrao(arquivo: "/horario", texto: "Definir horário", cor: Colors.blue),

                ],
              ))));
    });
  }
}
