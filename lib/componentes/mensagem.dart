import 'package:appseniorcare/componentes/texto.dart';
import 'package:flutter/material.dart';

// Alerta de MPU desligado
void AlertaMpuDesligado(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: TextoMedio(texto: 'Não há comunicação com o dispositivo', cor: Colors.black),
        content: TextoPadrao(texto: 'Ligue-o manualmente pressionando o botão de boot e verifique se a rede wi-fi local está funcionando corretamente.', cor: Colors.black),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Feche o AlertDialog
            },
            child: Text('Fechar'),
          ),
        ],
      );
    },
  );
}

// Alerta de PIR desligado
void AlertaPirDesligado(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: TextoMedio(texto: 'Não há comunicação com o dispositivo', cor: Colors.black),
        content: TextoPadrao(texto: 'Verifique se ele está conectado a uma tomada e se a rede wi-fi local está funcionando corretamente.', cor: Colors.black),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Feche o AlertDialog
            },
            child: Text('Fechar'),
          ),
        ],
      );
    },
  );
}

// Alerta de PIR ligado
void AlertaPirLigado(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: TextoMedio(texto: 'O dispositivo está ligado', cor: Colors.black),
        content: TextoPadrao(texto: 'Se quiser desligá-lo remova da tomada.', cor: Colors.black),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Feche o AlertDialog
            },
            child: Text('Fechar'),
          ),
        ],
      );
    },
  );
}


// Alerta de queda identificada
void AlertaQuedaIdentificada(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: TextoMedio(texto: 'Queda identificada!', cor: Colors.black),
        content: TextoPadrao(texto: 'O idoso pode estar precisando de ajuda.', cor: Colors.black),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Feche o AlertDialog
            },
            child: Text('Fechar'),
          ),
        ],
      );
    },
  );
}

// Alerta de queda identificada
void ErroSemCompartimento(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: TextoMedio(texto: 'Selecione um compartimento', cor: Colors.black),
        content: TextoPadrao(texto: 'Clique no compartimento da caixa que você deseja colocar seu medicamento.', cor: Colors.black),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Feche o AlertDialog
            },
            child: Text('Fechar'),
          ),
        ],
      );
    },
  );
}

void CampoVazio(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: TextoMedio(texto: 'Preencha todos os campos', cor: Colors.black),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Feche o AlertDialog
            },
            child: Text('Fechar'),
          ),
        ],
      );
    },
  );
}