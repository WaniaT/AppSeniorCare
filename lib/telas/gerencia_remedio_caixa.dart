//Bibliotecas externas
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typed_data/src/typed_buffer.dart';

//Classes próprias
import 'package:appseniorcare/componentes/container.dart';
import 'package:appseniorcare/componentes/mensagem.dart';
import 'package:appseniorcare/componentes/texto.dart';
import 'package:appseniorcare/mqtt.dart';

//-------------------------- Caixa de remédios ---------------------------------
// Seleciona um compartimento da caixa e manda a sua identificação (de 0 a 15)
// para o tópico CAIXA_COMPARTIMENTO.
//------------------------------------------------------------------------------
class gerencia_remedio_caixa extends StatefulWidget {
  const gerencia_remedio_caixa({super.key});

  @override
  State<gerencia_remedio_caixa> createState() => _gerencia_remedio_caixaState();
}

class _gerencia_remedio_caixaState extends State<gerencia_remedio_caixa> {
  String lCompartimento = ''; //Armazena o tópico CAIXA_COMPARTIMENTO
  int idSelecionado = -1;
  int ultimoSelecionado = -1;

  Color corNaoSelecionado = Colors.white54;
  Color corSelecionado = Colors.lightBlue;

  @override
  Widget build(BuildContext context) {
    return Consumer<ConcreteMqttService>(
        builder: (context, mqttService, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          bottomOpacity: 0.0,
          elevation: 0.0,
        ),
        body: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.05,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
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
                      bottomRight: const Radius.circular(50.0),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      TituloPrincipal(
                        texto: "Configurar caixa",
                        cor: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: TextoPadrao(
                          texto:
                              "Selecione um compartimento da caixa e clique em 'Adicionar medicamento'.",
                          cor: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: 340,
                  margin: EdgeInsets.only(
                    top: 50,
                    bottom: 25,
                    left: 15,
                    right: 15,
                  ),
                  padding: EdgeInsets.all(20),
                  decoration: new BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.all(
                      const Radius.circular(30),
                    ),
                  ),
                  child: SizedBox(
                    height: (55 * 4 * 1.4),
                    // Defina a altura com base no número de compartimentos e na altura de cada um
                    child: GridView.count(
                        crossAxisCount: 4, // 4 colunas
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                idSelecionado = 0;
                                if (ultimoSelecionado == -1)
                                  ultimoSelecionado = idSelecionado;
                                else {
                                  if (ultimoSelecionado == idSelecionado) {
                                    ultimoSelecionado = -1;
                                    idSelecionado = -1;
                                  } else
                                    ultimoSelecionado = idSelecionado;
                                }
                              });
                            },
                            child: Container(
                              height: 55,
                              width: 55,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: idSelecionado == 0
                                    ? corSelecionado
                                    : corNaoSelecionado,
                                borderRadius: BorderRadius.circular(5.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: idSelecionado == 0 ? Colors.white : Colors.transparent,
                                    spreadRadius: 2.0,
                                    blurRadius: 4.0,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                idSelecionado = 1;
                                if (ultimoSelecionado == -1)
                                  ultimoSelecionado = idSelecionado;
                                else {
                                  if (ultimoSelecionado == idSelecionado) {
                                    ultimoSelecionado = -1;
                                    idSelecionado = -1;
                                  } else
                                    ultimoSelecionado = idSelecionado;
                                }
                              });
                            },
                            child: Container(
                              height: 55,
                              width: 55,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: idSelecionado == 1
                                    ? corSelecionado
                                    : corNaoSelecionado,
                                borderRadius: BorderRadius.circular(5.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: idSelecionado == 1 ? Colors.white : Colors.transparent,
                                    spreadRadius: 2.0,
                                    blurRadius: 4.0,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                idSelecionado = 2;
                                if (ultimoSelecionado == -1)
                                  ultimoSelecionado = idSelecionado;
                                else {
                                  if (ultimoSelecionado == idSelecionado) {
                                    ultimoSelecionado = -1;
                                    idSelecionado = -1;
                                  } else
                                    ultimoSelecionado = idSelecionado;
                                }
                              });
                            },
                            child: Container(
                              height: 55,
                              width: 55,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: idSelecionado == 2
                                    ? corSelecionado
                                    : corNaoSelecionado,
                                borderRadius: BorderRadius.circular(5.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: idSelecionado == 2 ? Colors.white : Colors.transparent,
                                    spreadRadius: 2.0,
                                    blurRadius: 4.0,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                idSelecionado = 3;
                                if (ultimoSelecionado == -1)
                                  ultimoSelecionado = idSelecionado;
                                else {
                                  if (ultimoSelecionado == idSelecionado) {
                                    ultimoSelecionado = -1;
                                    idSelecionado = -1;
                                  } else
                                    ultimoSelecionado = idSelecionado;
                                }
                              });
                            },
                            child: Container(
                              height: 55,
                              width: 55,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: idSelecionado == 3
                                    ? corSelecionado
                                    : corNaoSelecionado,
                                borderRadius: BorderRadius.circular(5.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: idSelecionado == 3 ? Colors.white : Colors.transparent,
                                    spreadRadius: 2.0,
                                    blurRadius: 4.0,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                idSelecionado = 4;
                                if (ultimoSelecionado == -1)
                                  ultimoSelecionado = idSelecionado;
                                else {
                                  if (ultimoSelecionado == idSelecionado) {
                                    ultimoSelecionado = -1;
                                    idSelecionado = -1;
                                  } else
                                    ultimoSelecionado = idSelecionado;
                                }
                              });
                            },
                            child: Container(
                              height: 55,
                              width: 55,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: idSelecionado == 4
                                    ? corSelecionado
                                    : corNaoSelecionado,
                                borderRadius: BorderRadius.circular(5.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: idSelecionado == 4 ? Colors.white : Colors.transparent,
                                    spreadRadius: 2.0,
                                    blurRadius: 4.0,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                idSelecionado = 5;
                                if (ultimoSelecionado == -1)
                                  ultimoSelecionado = idSelecionado;
                                else {
                                  if (ultimoSelecionado == idSelecionado) {
                                    ultimoSelecionado = -1;
                                    idSelecionado = -1;
                                  } else
                                    ultimoSelecionado = idSelecionado;
                                }
                              });
                            },
                            child: Container(
                              height: 55,
                              width: 55,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: idSelecionado == 5
                                    ? corSelecionado
                                    : corNaoSelecionado,
                                borderRadius: BorderRadius.circular(5.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: idSelecionado == 5 ? Colors.white : Colors.transparent,
                                    spreadRadius: 2.0,
                                    blurRadius: 4.0,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                idSelecionado = 6;
                                if (ultimoSelecionado == -1)
                                  ultimoSelecionado = idSelecionado;
                                else {
                                  if (ultimoSelecionado == idSelecionado) {
                                    ultimoSelecionado = -1;
                                    idSelecionado = -1;
                                  } else
                                    ultimoSelecionado = idSelecionado;
                                }
                              });
                            },
                            child: Container(
                              height: 55,
                              width: 55,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: idSelecionado == 6
                                    ? corSelecionado
                                    : corNaoSelecionado,
                                borderRadius: BorderRadius.circular(5.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: idSelecionado == 6 ? Colors.white : Colors.transparent,
                                    spreadRadius: 2.0,
                                    blurRadius: 4.0,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                idSelecionado = 7;
                                if (ultimoSelecionado == -1)
                                  ultimoSelecionado = idSelecionado;
                                else {
                                  if (ultimoSelecionado == idSelecionado) {
                                    ultimoSelecionado = -1;
                                    idSelecionado = -1;
                                  } else
                                    ultimoSelecionado = idSelecionado;
                                }
                              });
                            },
                            child: Container(
                              height: 55,
                              width: 55,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: idSelecionado == 7
                                    ? corSelecionado
                                    : corNaoSelecionado,
                                borderRadius: BorderRadius.circular(5.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: idSelecionado == 7 ? Colors.white : Colors.transparent,
                                    spreadRadius: 2.0,
                                    blurRadius: 4.0,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                idSelecionado = 8;
                                if (ultimoSelecionado == -1)
                                  ultimoSelecionado = idSelecionado;
                                else {
                                  if (ultimoSelecionado == idSelecionado) {
                                    ultimoSelecionado = -1;
                                    idSelecionado = -1;
                                  } else
                                    ultimoSelecionado = idSelecionado;
                                }
                              });
                            },
                            child: Container(
                              height: 55,
                              width: 55,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: idSelecionado == 8
                                    ? corSelecionado
                                    : corNaoSelecionado,
                                borderRadius: BorderRadius.circular(5.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: idSelecionado == 8 ? Colors.white : Colors.transparent,
                                    spreadRadius: 2.0,
                                    blurRadius: 4.0,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                idSelecionado = 9;
                                if (ultimoSelecionado == -1)
                                  ultimoSelecionado = idSelecionado;
                                else {
                                  if (ultimoSelecionado == idSelecionado) {
                                    ultimoSelecionado = -1;
                                    idSelecionado = -1;
                                  } else
                                    ultimoSelecionado = idSelecionado;
                                }
                              });
                            },
                            child: Container(
                              height: 55,
                              width: 55,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: idSelecionado == 9
                                    ? corSelecionado
                                    : corNaoSelecionado,
                                borderRadius: BorderRadius.circular(5.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: idSelecionado == 9 ? Colors.white : Colors.transparent,
                                    spreadRadius: 2.0,
                                    blurRadius: 4.0,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                idSelecionado = 10;
                                if (ultimoSelecionado == -1)
                                  ultimoSelecionado = idSelecionado;
                                else {
                                  if (ultimoSelecionado == idSelecionado) {
                                    ultimoSelecionado = -1;
                                    idSelecionado = -1;
                                  } else
                                    ultimoSelecionado = idSelecionado;
                                }
                              });
                            },
                            child: Container(
                              height: 55,
                              width: 55,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: idSelecionado == 10
                                    ? corSelecionado
                                    : corNaoSelecionado,
                                borderRadius: BorderRadius.circular(5.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: idSelecionado == 10 ? Colors.white : Colors.transparent,
                                    spreadRadius: 2.0,
                                    blurRadius: 4.0,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                idSelecionado = 11;
                                if (ultimoSelecionado == -1)
                                  ultimoSelecionado = idSelecionado;
                                else {
                                  if (ultimoSelecionado == idSelecionado) {
                                    ultimoSelecionado = -1;
                                    idSelecionado = -1;
                                  } else
                                    ultimoSelecionado = idSelecionado;
                                }
                              });
                            },
                            child: Container(
                              height: 55,
                              width: 55,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: idSelecionado == 11
                                    ? corSelecionado
                                    : corNaoSelecionado,
                                borderRadius: BorderRadius.circular(5.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: idSelecionado == 11 ? Colors.white : Colors.transparent,
                                    spreadRadius: 2.0,
                                    blurRadius: 4.0,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                idSelecionado = 12;
                                if (ultimoSelecionado == -1)
                                  ultimoSelecionado = idSelecionado;
                                else {
                                  if (ultimoSelecionado == idSelecionado) {
                                    ultimoSelecionado = -1;
                                    idSelecionado = -1;
                                  } else
                                    ultimoSelecionado = idSelecionado;
                                }
                              });
                            },
                            child: Container(
                              height: 55,
                              width: 55,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: idSelecionado == 12
                                    ? corSelecionado
                                    : corNaoSelecionado,
                                borderRadius: BorderRadius.circular(5.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: idSelecionado == 12 ? Colors.white : Colors.transparent,
                                    spreadRadius: 2.0,
                                    blurRadius: 4.0,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                idSelecionado = 13;
                                if (ultimoSelecionado == -1)
                                  ultimoSelecionado = idSelecionado;
                                else {
                                  if (ultimoSelecionado == idSelecionado) {
                                    ultimoSelecionado = -1;
                                    idSelecionado = -1;
                                  } else
                                    ultimoSelecionado = idSelecionado;
                                }
                              });
                            },
                            child: Container(
                              height: 55,
                              width: 55,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: idSelecionado == 13
                                    ? corSelecionado
                                    : corNaoSelecionado,
                                borderRadius: BorderRadius.circular(5.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: idSelecionado == 13 ? Colors.white : Colors.transparent,
                                    spreadRadius: 2.0,
                                    blurRadius: 4.0,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                idSelecionado = 14;
                                if (ultimoSelecionado == -1)
                                  ultimoSelecionado = idSelecionado;
                                else {
                                  if (ultimoSelecionado == idSelecionado) {
                                    ultimoSelecionado = -1;
                                    idSelecionado = -1;
                                  } else
                                    ultimoSelecionado = idSelecionado;
                                }
                              });
                            },
                            child: Container(
                              height: 55,
                              width: 55,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: idSelecionado == 14
                                    ? corSelecionado
                                    : corNaoSelecionado,
                                borderRadius: BorderRadius.circular(5.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: idSelecionado == 14 ? Colors.white : Colors.transparent,
                                    spreadRadius: 2.0,
                                    blurRadius: 4.0,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                idSelecionado = 15;
                                if (ultimoSelecionado == -1)
                                  ultimoSelecionado = idSelecionado;
                                else {
                                  if (ultimoSelecionado == idSelecionado) {
                                    ultimoSelecionado = -1;
                                    idSelecionado = -1;
                                  } else
                                    ultimoSelecionado = idSelecionado;
                                }
                              });
                            },
                            child: Container(
                              height: 55,
                              width: 55,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: idSelecionado == 15
                                    ? corSelecionado
                                    : corNaoSelecionado,
                                borderRadius: BorderRadius.circular(5.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: idSelecionado == 15 ? Colors.white : Colors.transparent,
                                    spreadRadius: 2.0,
                                    blurRadius: 4.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]

                        //compartimentos, // Renderize os compartimentos em uma grade
                        ),
                  ),
                ),

                //Botão
                GestureDetector(
                    onTap: () {
                      if (ultimoSelecionado == -1)
                        ErroSemCompartimento(context);
                      else {
                        final message = idSelecionado.toString();
                        final uint8Buffer =
                            Uint8Buffer(); // Converte a mensagem de string para binario
                        uint8Buffer.addAll(message.codeUnits);
                        mqttService.publishMessage('CAIXA_COMPARTIMENTO',
                            uint8Buffer); //Publica mensagem MQTT
                        Navigator.pushNamed(
                            context, '/telas/gerencia_remedio_medicamento');
                      }
                    },
                    child: Container(
                        padding: EdgeInsets.all(17),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0))),
                        //color: cor,
                        child: TextoPadrao(
                            texto: "Adicionar medicamento",
                            cor: Colors.white))),
              ],
            ),
          ),
        ),
      );
    });
  }
}
