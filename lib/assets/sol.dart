import 'package:flutter/material.dart';

class Sol extends StatefulWidget {
  final Color corInicial;
  final Color corFinal;
  final AnimationController controlador;
  const Sol({
    this.corInicial = const Color(0xffe65100),
    this.corFinal = Colors.yellow,
    required this.controlador,
    Key? key,
  }) : super(key: key);

  @override
  State<Sol> createState() => _SolState();
}

class _SolState extends State<Sol> {
  bool completou = false;
  @override
  void initState() {
    widget.controlador.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => completou = true);
      }
    });
    // lógica interna para controlar o mudança de cor do sol
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _cor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: _cor,
            blurRadius: 24,
            spreadRadius: 84,
          ),
        ],
      ),
    );
  }

  Color get _cor {
    return Color.lerp(
      widget.corInicial,
      widget.corFinal,
      completou ? 1 : widget.controlador.value,
    )!;
  }
  // interpolação linear entre as cores
}
