import 'package:flutter/material.dart';

class Sol extends StatefulWidget {
  final Color corInicial;
  final Color corFinal;
  final Duration duracao;
  const Sol({
    this.corInicial = const Color(0xffe65100),
    this.corFinal = Colors.yellow,
    this.duracao = const Duration(seconds: 1),
    Key? key,
  }) : super(key: key);

  @override
  State<Sol> createState() => _SolState();
}

class _SolState extends State<Sol> with SingleTickerProviderStateMixin {
  late final AnimationController controlador;

  @override
  void initState() {
    controlador = AnimationController(vsync: this, duration: widget.duracao)
      ..addListener(() => setState(() {}));
    super.initState();
    controlador.forward();
  }

  @override
  void dispose() {
    controlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(
        .65,
        // -1 esquerda -- direita 1
        .75 - 1.5 * controlador.value,
        // -1 cima -- baixo 1
      ),
      child: _sol1(_cor),
    );
  }

  Color get _cor => Color.lerp(
        widget.corInicial,
        widget.corFinal,
        controlador.value,
      )!;
  Widget _sol1(final Color color) => DecoratedBox(
        decoration: BoxDecoration(
          color: color,
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
  Widget _sol2(final Color color) => Icon(Icons.sunny, color: color, size: 64);
}
