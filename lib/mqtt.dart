import 'dart:async';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:typed_data/src/typed_buffer.dart';
import 'package:flutter/material.dart';

abstract class MqttService {
  //Declaração das funções que o método _onData irá atualizar
  void updateMpuStatus(String message) {}
  void updateMpuQueda(String message) {}
  void updatePirStatus(String message) {}
  void updatePirQueda(String message) {}
  void updateCaixaStatus(String message) {}
  void updateCaixaCompartimento(String message) {}
  void updateCaixaDados(String message) {}

  //...

  bool isConnected = false;

  //Configuração da conexão MQTT
  final String host = "broker.hivemq.com"; //"broker.hivemq.com";
  final int    port = 1883; //1883;
  final String clientId = 'mqttclient${DateTime.now().millisecondsSinceEpoch}'; //numero baseado na hora
  final String topic = "";
  final String userName = "";
  final String password = "";
  final String identificador = "AppSeniorCare";
  final String receivedMessage = "";
  late MqttServerClient mqttClient;

  Future<void> connect() async {
    mqttClient = MqttServerClient(host, clientId);

    mqttClient.port = port;
    mqttClient.keepAlivePeriod = 60;
    mqttClient.secure = false;
    mqttClient.onDisconnected = _onDisconnected;
    mqttClient.onConnected = _onConnected;
    mqttClient.onSubscribed = _onSubscribed;
    mqttClient.setProtocolV311();
    mqttClient.logging(on: false); //mudar p/ true pra ver o log

    // Criando um objeto MqttConnectMessage com as configurações desejadas
    final connMess = MqttConnectMessage()
        .withClientIdentifier(clientId) // ID de cliente gerado
        .withWillTopic('') // If you set this you must set a will message
        .withWillMessage('')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce); //Qualidade de serviço nível 1: envia confimação de recebimento p/ o publisher.
                                           //Se o publisher também estiver usando QoS 1 e não tiver confirmação de recebimento,
                                           //reenvia a mensagem. Aqui é necessário que o publisher e subscriber usem Qos 1.

    print('HiveMQ cliente conectando....');

    //Checa se conectou
    final MqttClientConnectionStatus? connectionStatus = await mqttClient.connect();
    if (connectionStatus?.state == MqttConnectionState.connected)
    {
      // Assine os tópicos MQTT que você deseja receber
      mqttClient.subscribe('MPU_STATUS', MqttQos.atLeastOnce);
      mqttClient.subscribe('MPU_QUEDA', MqttQos.atLeastOnce);
      mqttClient.subscribe('ESTADO_SENSOR', MqttQos.atLeastOnce); //PIR_QUEDA
      mqttClient.subscribe('PIR_STATUS', MqttQos.atLeastOnce);
      mqttClient.subscribe('CAIXA_STATUS', MqttQos.atLeastOnce);
      mqttClient.subscribe('NOVO_INPUT', MqttQos.atLeastOnce); //CAIXA_DADOS
      mqttClient.subscribe('CAIXA_COMPARTIMENTO', MqttQos.atLeastOnce); //INPUT

      // Configure o listener para mensagens MQTT
      mqttClient.updates?.listen((List<MqttReceivedMessage<MqttMessage>> messages) {
        print("update mensagem (mqttClient.updates?.listen)");
        _onData(messages);
      });

      print('Sucesso na conexão MQTT');
      isConnected = true;
    }
    else
    {
      print('Erro na conexão MQTT');
      isConnected = false;
      // Tente reconectar após uma pausa
      _scheduleReconnect();
    }
  }

  // Agendando uma tentativa de reconexão
  void _scheduleReconnect() {
    if (isConnected) {
      // Se já está conectado, não agende a reconexão
      return;
    }

    // Definindo um período de espera antes de tentar novamente
    const reconnectDelay = Duration(seconds: 10);

    // Usando um temporizador para agendar a tentativa de reconexão
    Timer(reconnectDelay, () {
      print ("Tentando reconectar");
      connect(); // Tente reconectar
    });
  }

  void subscribeToTopic(String topic) {
    print ("Se inscrevendo em topico");
    mqttClient.subscribe(topic, MqttQos.atMostOnce);
  }

  void publishMessage(String topic, Uint8Buffer message) {
    final messageString = message;
    print ("Publicando mensagem no tópico:  $topic");
    mqttClient.publishMessage(topic, MqttQos.atLeastOnce, messageString as Uint8Buffer);
  }

  void _onConnected() {
    print('Conectado ao servidor MQTT');
  }

  void _onSubscribed(String topic) {
    print('Inscrito em $topic');
  }

  void _onDisconnected() {
    print('Desconectado do servidor MQTT');
  }

  void _onData(List<MqttReceivedMessage<MqttMessage>> messages) {
    for (var message in messages) {
      final MqttPublishMessage receivedMessage = message.payload as MqttPublishMessage;
      final messageText = MqttPublishPayload.bytesToStringAsString(receivedMessage.payload.message!);

      // Atualizando as variáveis com base no tópico da mensagem
      switch (message.topic) {
        case 'MPU_STATUS': updateMpuStatus(messageText); break;
        case 'MPU_QUEDA': updateMpuQueda(messageText); break;
        case 'ESTADO_SENSOR': updatePirQueda(messageText); break;
        case 'PIR_STATUS': updatePirStatus(messageText); break;
        case 'CAIXA_STATUS': updateCaixaStatus(messageText); break;
        case 'NOVO_INPUT': updateCaixaDados(messageText); break;
        case 'CAIXA_COMPARTIMENTO': updateCaixaCompartimento(messageText); break;
        default: /* Lida com outros tópicos, se necessário. */ break;
      }
    }
  }
}

//-----------------------------------------------------------------------------
class ConcreteMqttService extends MqttService with ChangeNotifier {
  ConcreteMqttService() : super(); // Chama o construtor da classe pai

  //Variáveis de mensagem
  String msgMpuStatus = "";
  String msgMpuQueda = "";
  String msgPirQueda = "";
  String msgPirStatus = "";
  String msgCaixaStatus = "";
  String msgCaixaDados = "";
  String msgCaixaCompartimento = "";

  //Atualiza as variáveis quando uma mensagem é recebida
  void updateMpuStatus(String message) {
    msgMpuStatus = message;
    notifyListeners();
  }

  void updateMpuQueda(String message) {
    msgMpuQueda = message;
    notifyListeners();
  }

  void updatePirQueda(String message) {
    msgPirQueda = message;
    notifyListeners();
  }

  void updatePirStatus(String message) {
    msgPirStatus = message;
    notifyListeners();
  }

  void updateCaixaStatus(String message) {
    msgCaixaStatus = message;
    notifyListeners();
  }

  void updateCaixaDados(String message) {
    msgCaixaDados = message;
    notifyListeners();
  }

  void updateCaixaCompartimento(String message) {
    msgCaixaCompartimento = message;
    notifyListeners();
  }

  // Método para chamar o connect() da classe pai e notificar as classes filhas
  Future<void> connectAndNotify() async {
    await connect(); // Chama o connect() da classe pai
    notifyListeners(); // Notifica as classes filhas
  }
}