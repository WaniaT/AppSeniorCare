import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//---------------------------- Campos de texto ---------------------------------
//Tipo texto
class CampoTexto extends StatelessWidget {
  const CampoTexto({super.key, required this.texto, required this.controlador});

  final String texto;
  final TextEditingController controlador;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: texto,
            alignLabelWithHint: true,
          ),
          maxLength: 25,
          style: const TextStyle (
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontSize: 16,
              letterSpacing: -0.02,
              color: Colors.black45),
          controller: controlador,
        ));
  }
}

//---------------------------- Campos de texto ---------------------------------
//Tipo texto
class CampoHora extends StatelessWidget {
  const CampoHora({super.key, required this.texto, required this.controlador});

  final String texto;
  final TextEditingController controlador;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: texto,
            enabled: false, // Define como false para desabilitar a edição
            alignLabelWithHint: true,
          ),
          style: const TextStyle (
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontSize: 16,
              letterSpacing: -0.02,
              color: Colors.black45),
          controller: controlador,
        ));
  }
}

//------------------------------------------------------------------------------
//Tipo senha
class CampoSenha extends StatelessWidget {
  const CampoSenha({super.key, required this.controlador});

  final TextEditingController controlador;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        child: TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: "Senha",
          ),
          obscureText: true,
          style: const TextStyle(
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontSize: 16,
              letterSpacing: -0.02,
              color: Colors.black45),
          controller: controlador,
        ));
  }
}

//------------------------------------------------------------------------------
//Tipo email
class CampoEmail extends StatelessWidget {
  const CampoEmail({super.key, required this.texto, required this.controlador});

  final String texto;
  final TextEditingController controlador;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: "E-mail",
          ),
          style: const TextStyle(
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontSize: 16,
              letterSpacing: -0.02,
              color: Colors.black45),
          controller: controlador,
        ));
  }
}

//------------------------------------------------------------------------------
//Tipo número
class CampoNumero extends StatelessWidget {
  const CampoNumero({super.key, required this.texto, required this.controlador});

  final String texto;
  final TextEditingController controlador;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        child: TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: texto,
          ),
          style: const TextStyle(
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontSize: 16,
              letterSpacing: -0.02,
              color: Colors.black45),
          controller: controlador,
        ));
  }
}

//Numero dropdown
//Numero dropdown
class CampoNumeroDropdown extends StatelessWidget {
  const CampoNumeroDropdown({Key? key, required this.texto, required this.controlador})
      : super(key: key);

  final String texto;
  final TextEditingController controlador;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: DropdownButtonFormField<int>(
        value: int.tryParse(controlador.text) ?? 1,
        onChanged: (int? value) {
          if (value != null) {
            controlador.text = value.toString();
          }
        },
        items: List.generate(
          3,
              (index) => DropdownMenuItem<int>(
            value: index + 1,
            child: Text((index + 1).toString()),
          ),
        ),
        decoration: InputDecoration(
          labelText: texto,
        ),
        style: const TextStyle(
          fontFamily: 'Inter',
          fontStyle: FontStyle.normal,
          fontSize: 16,
          letterSpacing: -0.02,
          color: Colors.black45,
        ),
      ),
    );
  }
}

