import 'package:flutter/material.dart';

class Ceu extends StatefulWidget {
  final Color corInicial;
  final Color corFinal;
  final Duration duracao;

  const Ceu({
    this.corInicial = const Color(0xff0b2274),
    this.corFinal = Colors.blue,
    this.duracao = const Duration(seconds: 6),
    Key? key,
  }) : super(key: key);

  @override
  State<Ceu> createState() => _CeuState();
}

class _CeuState extends State<Ceu> with SingleTickerProviderStateMixin {
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
    return DecoratedBox(
      decoration: BoxDecoration(color: _cor),
      child: const Center(),
    );
  }

  Color get _cor => Color.lerp(
        widget.corInicial,
        widget.corFinal,
        controlador.value,
      )!;
}
