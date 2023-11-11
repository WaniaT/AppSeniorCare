import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//-------------------------------- Containers ----------------------------------
//Imagem
class Imagem extends StatelessWidget {
  const Imagem({super.key, required this.distancia_antes,
    required this.distancia_depois,
    required this.caminho});

  final double distancia_antes;
  final double distancia_depois;
  final String caminho;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
        EdgeInsets.only(top: distancia_antes, bottom: distancia_depois),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[Image.asset(caminho)],
        ));
  }
}

//------------------------------------------------------------------------------
class Compartimento extends StatefulWidget {
  final int compartimentoId;
  final bool inicialmenteSelecionado;
  final ValueChanged<int> onChanged;

  Compartimento({
    required this.compartimentoId,
    required this.inicialmenteSelecionado,
    required this.onChanged,
  });

  @override
  _CompartimentoState createState() => _CompartimentoState();
}

class _CompartimentoState extends State<Compartimento> {
  late bool selecionado;

  @override
  void initState() {
    super.initState();
    selecionado = widget.inicialmenteSelecionado;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selecionado = !selecionado;
            widget.onChanged(widget.compartimentoId);
        });
      },
      child: Container(
        height: 55,
        width: 55,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: selecionado ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }
}
