import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appseniorcare/componentes/texto.dart';



//---------------------------------- Botões ------------------------------------
// Botão liga/desliga
class BotaoLigaDesliga extends StatefulWidget {
  final bool value; // Valor atual do botão (ligado ou desligado)
  final ValueChanged<bool> onChanged; // Função chamada quando o botão é pressionado

  const BotaoLigaDesliga({super.key, required this.value, required this.onChanged});

  @override
  State<BotaoLigaDesliga> createState() => _BotaoLigaDesligaState();
}

class _BotaoLigaDesligaState extends State<BotaoLigaDesliga> with SingleTickerProviderStateMixin {
  Animation? _circleAnimation;
  AnimationController? _animationController;
  late bool status;

  @override
  void initState() {
    super.initState();
    status = widget.value;
    // Inicializa a animação e o controlador de animação
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 40));
    // Define a animação da alavanca com base no estado atual do botão
    _circleAnimation = AlignmentTween(
        begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
        end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
        parent: _animationController!, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            final newValue = !status;
            status = newValue;

            if (widget.value != status) {
              widget.onChanged(status); // Atualiza o valor do botão com o novo estado
              if (_animationController!.isCompleted) {
                _animationController!.reverse();
              } else {
                _animationController!.forward();
              }
            }
          },
          child: Container(
            width: 45.0,
            height: 28.0,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black45),
              borderRadius: BorderRadius.circular(30.0),
              color: widget.value == true
                  ? Colors.white
                  : Colors.black45,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  top: 2.0, bottom: 2.0, right: 2.0, left: 2.0),
              child: Container(
                alignment: widget.value
                    ? ((Directionality.of(context) == TextDirection.rtl)
                    ? Alignment.centerLeft
                    : Alignment.centerRight)
                    : ((Directionality.of(context) == TextDirection.rtl)
                    ? Alignment.centerRight
                    : Alignment.centerLeft),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.value == true
                          ? Colors.blue
                          : Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}




//------------------------------------------------------------------------------
//Botão link
class BotaoLink extends StatelessWidget {
  final String arquivo;
  final String texto;

  const BotaoLink({super.key, required this.arquivo, required this.texto});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, arquivo);
        },
        child: Text(texto,
            style: TextStyle(
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontSize: 16,
              letterSpacing: -0.02,
              color: Colors.black45,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
            )));
  }
}

//------------------------------------------------------------------------------
//Botão Padrão
class BotaoPadrao extends StatelessWidget {
  final String arquivo;
  final String texto;
  final Color cor;

  const BotaoPadrao(
      {super.key,
        required this.arquivo,
        required this.texto,
        required this.cor});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, arquivo);
              },
              child: Container(
                padding: EdgeInsets.all(17),
                decoration: BoxDecoration (
                    color: cor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(40.0))),
                //color: cor,
                child: cor == Colors.blue
                    ? TextoPadrao(texto: texto, cor: Colors.white)
                    : TextoPadrao(texto: texto, cor: Colors.black45),
              ))
        ]));
  }
}

//------------------------------------------------------------------------------
//Botão Função
class BotaoFuncao extends StatelessWidget {

  final String arquivo;
  final String nome_imagem;

  const BotaoFuncao({super.key, required this.arquivo, required this.nome_imagem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, arquivo);
        },
        child: Container(
            height: 110,
            width: 110,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(
                  Radius.circular(40.0),
                )),
            child: Column(
              children: <Widget>[Image.asset(nome_imagem)],
            )));
  }
}

//------------------------------------------------------------------------------
//Botão funcionalidades complementares
class BotaoFuncaoComplementar extends StatelessWidget {

  final String descricao;
  final String arquivo;
  final String nome_imagem;

  const BotaoFuncaoComplementar({super.key, required this.descricao, required this.arquivo, required this.nome_imagem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, arquivo);
      },
      //Botão
      child: Container(
          height: 50,
          width: 330,
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
            BorderRadius.all(Radius.circular(30.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  offset: Offset(
                      0.0, //horizontal
                      5.0))
            ],
          ),
          child: Row(
            children: <Widget>[
              //Icone azul
              Padding(
                  padding: EdgeInsets.all(0),
                  child: Container(
                      height: 50,
                      width: 65,
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(
                            Radius.circular(30.0)),
                      ),
                      child: Image.asset(nome_imagem))),

              //Descrição botão
              Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: TextoPadrao(texto: descricao, cor: Colors.black45)),
            ],
          )),
    );
  }
}
