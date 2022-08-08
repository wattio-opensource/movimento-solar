import 'package:flutter/material.dart';

class Movimento extends StatefulWidget {
  final double Function(double valor) posX;
  final double Function(double valor) posY;
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
    super.initState();
  }

  double get _posX {
    var x = widget
        .posX((completou && !widget.repetir) ? 1 : widget.controlador.value);
    x %= 1;
    return -1 + 2 * x;
  }

  double get _posY {
    var y = widget
        .posY((completou && !widget.repetir) ? 1 : widget.controlador.value);
    y %= 1;
    return 1 - 2 * y;
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
