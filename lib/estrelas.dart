import 'dart:math';

import 'package:flutter/material.dart';

class Estrelas extends StatefulWidget {
  final int nEstrelas;
  final Color cor;
  final Duration duracao;
  const Estrelas({
    this.nEstrelas = 24,
    this.cor = Colors.white,
    this.duracao = const Duration(seconds: 1),
    Key? key,
  }) : super(key: key);

  @override
  State<Estrelas> createState() => _EstrelasState();
}

class _EstrelasState extends State<Estrelas>
    with SingleTickerProviderStateMixin {
  final random = Random();
  final List<Map<String, double>> coordenadas = [];
  late final AnimationController controlador;

  @override
  void initState() {
    controlador = AnimationController(vsync: this, duration: widget.duracao)
      ..addListener(() {});
    super.initState();
    geradorDeEstrelas();
    controlador.forward();
  }

  @override
  void dispose() {
    controlador.dispose();
    super.dispose();
  }

  void geradorDeEstrelas() {
    for (int i = 0; i < widget.nEstrelas; i++) {
      coordenadas.add({
        'x': -1 + 2 * random.nextDouble(),
        'y': -1 + 2 * random.nextDouble(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final passo = 1 / widget.nEstrelas;
    return Stack(
      children: [
        for (final coord in coordenadas.getRange(
            0, widget.nEstrelas - controlador.value ~/ passo))
          Align(
            alignment: Alignment(
              coord['x']!,
              coord['y']!,
            ),
            child: Icon(
              Icons.star,
              size: 12,
              color: widget.cor,
            ),
          )
      ],
    );
  }
}
