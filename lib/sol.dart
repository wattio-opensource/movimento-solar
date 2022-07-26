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

class _SolState extends State<Sol> with TickerProviderStateMixin {
  late final AnimationController controladorNascimento;
  late final AnimationController controladorDia;

  @override
  void initState() {
    super.initState();

    controladorNascimento =
        AnimationController(vsync: this, duration: widget.duracao)
          ..addListener(() => setState(() {}));
    controladorNascimento.forward();
  }

  @override
  void dispose() {
    controladorNascimento.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(
        .65,
        .75 - 1.5 * controladorNascimento.value,
      ),
      child: _sol1(_cor),
    );
  }

  Color get _cor => Color.lerp(
        widget.corInicial,
        widget.corFinal,
        controladorNascimento.value,
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
}
