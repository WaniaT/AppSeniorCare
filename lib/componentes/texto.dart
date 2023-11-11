import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//---------------------------- Estilos de texto --------------------------------
//Título principal
class TituloPrincipal extends StatelessWidget {
  const TituloPrincipal({super.key, required this.texto, required this.cor});

  final String texto;
  final Color cor;

  @override
  Widget build(BuildContext context) {
    return Text(texto,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.02,
          fontSize: 34,
          color: cor,
        ));
  }
}

//------------------------------------------------------------------------------
//Título secundário
class TituloSecundario extends StatelessWidget {
  const TituloSecundario({super.key, required this.texto, required this.cor});

  final String texto;
  final Color cor;

  @override
  Widget build(BuildContext context) {
    return Text(texto,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.02,
          fontSize: 22,
          color: cor,
        ));
  }
}

//------------------------------------------------------------------------------
//Texto padrão
class TextoPadrao extends StatelessWidget {
  const TextoPadrao({super.key, required this.texto, required this.cor});

  final String texto;
  final Color cor;

  @override
  Widget build(BuildContext context) {
    return Text(
        texto,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'Poppins',
            fontStyle: FontStyle.normal,
            fontSize: 14,
            letterSpacing: -0.02,
            color: cor));
  }
}

//------------------------------------------------------------------------------
//Texto padrão justificado
class TextoPadraoJustificado extends StatelessWidget {
  const TextoPadraoJustificado({super.key, required this.texto, required this.cor});

  final String texto;
  final Color cor;

  @override
  Widget build(BuildContext context) {
    return  Text(
        texto,
        textAlign: TextAlign.justify,
        style: TextStyle(
            fontFamily: 'Poppins',
            fontStyle: FontStyle.normal,
            fontSize: 14,
            letterSpacing: -0.02,
            color: cor));
  }
}

//------------------------------------------------------------------------------
//Texto médio
class TextoMedio extends StatelessWidget {
  const TextoMedio({super.key, required this.texto, required this.cor});

  final String texto;
  final Color cor;

  @override
  Widget build(BuildContext context) {
    return Text(
        texto,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'Poppins',
            fontStyle: FontStyle.normal,
            fontSize: 16,
            letterSpacing: -0.02,
            color: cor));
  }
}