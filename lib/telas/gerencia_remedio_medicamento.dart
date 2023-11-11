//Bibliotecas externas
import 'package:provider/provider.dart';
import 'package:typed_data/src/typed_buffer.dart';
import 'package:flutter/material.dart';

//Classes próprias
import 'package:appseniorcare/componentes/campo_texto.dart';
import 'package:appseniorcare/componentes/mensagem.dart';
import 'package:appseniorcare/componentes/texto.dart';
import 'package:appseniorcare/mqtt.dart';

//-------------------------- Adicionar medicamento -----------------------------
// Recupera a identificação do compartimento que está selecionado pelo tópico
// CAIXA_COMPARTIMENTO e envia as informações do medicamento através do tópico
// NOVO_INPUT
//------------------------------------------------------------------------------
class gerencia_remedio_medicamento extends StatefulWidget {
  const gerencia_remedio_medicamento({super.key});

  @override
  State<gerencia_remedio_medicamento> createState() =>
      _gerencia_remedio_medicamentoState();
}

class _gerencia_remedio_medicamentoState
    extends State<gerencia_remedio_medicamento> {

  TextEditingController _nome = TextEditingController();
  TextEditingController _comprimido = TextEditingController();
  TextEditingController _alarme = TextEditingController();

  //Declaração de tópicos referentes a MPU
  String lCaixaCompartimento = '';
  String lCaixaDados = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<ConcreteMqttService>(
        builder: (context, mqttService, child) {

      //Le a mensagem dos tópicos
      lCaixaCompartimento = mqttService.msgCaixaCompartimento;
      lCaixaDados = mqttService.msgCaixaDados;

      //Variaveis auxiliares
      int hora = -1;
      int minuto = -1;
      String message = "";
      bool clicou = false;

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.blue, bottomOpacity: 0.0, elevation: 0.0),
        body: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.05),
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
                  child: Column(
                    children: <Widget>[
                      TituloPrincipal(
                          texto: "Adicionar medicamento", cor: Colors.white),
                    ],
                  ),
                ),

                //Campos
                Padding(
                    padding: EdgeInsets.only(top: 50, bottom: 10),
                    child: Column(children: <Widget>[
                      CampoTexto(texto: "Nome", controlador: _nome),
                      CampoNumeroDropdown(texto: "Quantidade de comprimidos",
                          controlador: _comprimido),
                    ])),

                GestureDetector(
                  onTap: () async {
                    TimeOfDay? selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (selectedTime != null) {
                      setState(() {
                        _alarme.text = selectedTime.format(context);
                      });
                    }
                  },
                  //Botão
                  child: Column (
                    children: <Widget>[
                      CampoHora(texto: "Defina um alarme", controlador: _alarme),
                      //Icone azul
                      Padding(
                          padding: EdgeInsets.only(
                              top: 10,
                              left: MediaQuery.of(context).size.width * 0.70),
                          child: Container(
                              height: 50,
                              width: 50,
                              padding: EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                              ),
                              child: Image.asset("img/icon/alarme.png")

                          )
                          ),
                        ],
                      ),
                ),

                //Botão salvar
                Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: GestureDetector(
                        onTap: () {
                          //evita clique duplicado
                          if (clicou == false) {
                            //Formata hora
                            final parts = _alarme.text.split(":");
                            if (parts.length == 2) {
                              hora = int.tryParse(parts[0]) ?? 0;
                              minuto = int.tryParse(parts[1]) ?? 0;
                            }

                            //Verifica se todos os campos estao preenchidos
                            if (_nome.text == "" ||
                                hora == -1 ||
                                minuto == -1 ) {
                              print(_nome.text);
                              print(hora);
                              print(minuto);
                              print(_comprimido.text);
                              CampoVazio(context);
                            } else {
                              message = '''
                              {
                                "name": "${_nome.text}",
                                "container": $lCaixaCompartimento,
                                "qtdPills": ${_comprimido.text},
                                "horaDespertar": $hora,
                                "minutoDespertar": $minuto,
                                "onOff": 1
                              }
                              ''';

                              final uint8Buffer =
                                  Uint8Buffer(); // Converte a mensagem de string para binario
                              uint8Buffer.addAll(message.codeUnits);
                              mqttService.publishMessage('NOVO_INPUT',
                                  uint8Buffer); //Publica mensagem MQTT
                              Navigator.pushNamed(
                                  context, "/telas/menu_navegacao");
                            }

                            clicou = true;
                          } else
                            clicou = false;
                        },
                        child: Container(
                            padding: EdgeInsets.all(17),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.0))),
                            //color: cor,
                            child: TextoPadrao(
                                texto: "Salvar", cor: Colors.white)))),
              ],
            ))),
      );
    });
  }
}
