import 'dart:math';

import 'package:flutter/material.dart';

class Nuvens extends StatefulWidget {
  final int alturaDaNuvem;
  final int nNuvens;
  final Color cor;
  final Duration duracao;
  const Nuvens({
    this.nNuvens = 4,
    this.alturaDaNuvem = 128,
    this.cor = const Color(0xffcccccc),
    this.duracao = const Duration(seconds: 1),
    Key? key,
  }) : super(key: key);

  @override
  State<Nuvens> createState() => _NuvensState();
}

class _NuvensState extends State<Nuvens> with SingleTickerProviderStateMixin {
  final random = Random();
  List<Map<String, double>>? coordenadas;
  late final AnimationController controlador;
  bool visivel = false;

  @override
  void initState() {
    controlador = AnimationController(vsync: this, duration: widget.duracao)
      ..addListener(() => setState(() {
            // pra não aparecerem pássaros à noite.
            if (controlador.value > 0.5 && !visivel) {
              visivel = true;
              controlador.reset();
              controlador.forward();
            }
          }))
      ..addStatusListener((status) {
        // para os pássaros ficarem rodando
        if (status == AnimationStatus.completed) {
          controlador.reset();
          controlador.forward();
        }
      });
    super.initState();

    controlador.forward();
  }

  @override
  void dispose() {
    controlador.dispose();
    super.dispose();
  }

  void geradorDeNuvens(BuildContext context) {
    coordenadas = [];
    final screenHeight = MediaQuery.of(context).size.height;
    final passo = (screenHeight / widget.nNuvens) / screenHeight;
    for (int i = 0; i < widget.nNuvens; i++) {
      coordenadas!.add({'y': (-i * passo) + .1});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (coordenadas == null) {
      geradorDeNuvens(context);
    }
    return Stack(
      children: [
        for (int i = 0; i < coordenadas!.length; i++)
          () {
            final coord = coordenadas![i];
            final dx = i * (2 / widget.nNuvens);
            double posX = 1 - 2 * controlador.value - dx;
            posX += (posX <= -1) ? 2 : 0;
            return Visibility(
              visible: visivel,
              child: Opacity(
                opacity: .7,
                child: Align(
                  alignment: Alignment(
                    posX,
                    coord['y']!,
                  ),
                  child: Icon(
                    Icons.cloud_rounded,
                    size: widget.alturaDaNuvem.toDouble(),
                    color: widget.cor,
                    shadows: [
                      BoxShadow(
                          blurRadius: 12, spreadRadius: 32, color: widget.cor)
                    ],
                  ),
                ),
              ),
            );
          }()
      ],
    );
  }
}
