import 'package:flutter/material.dart';

class Movimento extends StatefulWidget {
  final double Function(double valor) posX;
  // definir posição em X, variando de 0 a 1;
  // esquerda: 0; direita: 1;
  final double Function(double valor) posY;
  // definir posição em Y, variando de 0 a 1;
  // chão: 0; topo: 1;
  final AnimationController controlador;
  final bool repetir;
  final Widget child;
  const Movimento({
    required this.posX,
    required this.posY,
    required this.child,
    required this.controlador,
    this.repetir = false,
    Key? key,
  }) : super(key: key);

  @override
  State<Movimento> createState() => _MovimentoState();
}

class _MovimentoState extends State<Movimento> {
  bool completou = false;
  @override
  void initState() {
    widget.controlador.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => completou = true);
      }
    });
    // lógica interna para evitar repetição dos movimentos
    // quando widget.repetir=false;
    super.initState();
  }

  double get _posX {
    var x = widget
        .posX((completou && !widget.repetir) ? 1 : widget.controlador.value);

    x %= 1;
    // se a função retorna algo maior que 1,
    // o valor é truncado para algo entre 0 e 1;
    return -1 + 2 * x;
    // o flutter usa uma lógica de -1 a 1 para definir a posição na tela;
    // esquerda: -1; direita: 1;
  }

  double get _posY {
    var y = widget
        .posY((completou && !widget.repetir) ? 1 : widget.controlador.value);
    y %= 1;
    // se a função retorna algo maior que 1,
    // o valor é truncado para algo entre 0 e 1;
    return 1 - 2 * y;
    // o flutter usa uma lógica de -1 a 1 para definir a posição na tela;
    // topo: -1; chão: 1;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(
        _posX,
        _posY,
      ),
      child: widget.child,
    );
  }
}
