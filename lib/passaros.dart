import 'dart:math';

import 'package:flutter/material.dart';

class Passaros extends StatefulWidget {
  final int alturaDoPassaro;
  final int nPassaros;
  final Color? cor;
  final Duration duracao;
  const Passaros({
    this.nPassaros = 8,
    this.alturaDoPassaro = 86,
    this.cor,
    this.duracao = const Duration(seconds: 1),
    Key? key,
  }) : super(key: key);

  @override
  State<Passaros> createState() => _PassarosState();
}

class _PassarosState extends State<Passaros>
    with SingleTickerProviderStateMixin {
  final random = Random();
  List<Map<String, double>>? coordenadas;
  late final AnimationController controlador;
  bool visivel = false;

  @override
  void initState() {
    controlador = AnimationController(vsync: this, duration: widget.duracao)
      ..addListener(
        () => setState(
          () {
            // pra não aparecerem pássaros à noite.
            if (controlador.value > 0.5 && !visivel) {
              visivel = true;
              controlador.reset();
              controlador.forward();
            }
          },
        ),
      )
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

  void geradorDePassaros(BuildContext context) {
    coordenadas = [];
    final screenHeight = MediaQuery.of(context).size.height;

    final passo = ((screenHeight / 2) / widget.nPassaros) / screenHeight;
    for (int i = 0; i < widget.nPassaros; i++) {
      coordenadas!.add({
        'y': 0 - i * (passo * 2),
        'dx': 0.4 * random.nextDouble(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (coordenadas == null) {
      geradorDePassaros(context);
    }
    return Stack(
      children: [
        for (int i = 0; i < coordenadas!.length; i++)
          () {
            final coord = coordenadas![i];
            double posX = -1 + 2 * controlador.value - coord['dx']!;
            posX -= (posX >= 1) ? 2 : 0;
            return Visibility(
              visible: visivel,
              child: Align(
                alignment: Alignment(
                  posX, // indo da esquerda para a direita
                  coord['y']!,
                ),
                child: Image(
                  height: widget.alturaDoPassaro.toDouble(),
                  image: const AssetImage('assets/passaro-branco.gif'),
                  color: widget.cor,
                ),
              ),
            );
          }()
      ],
    );
  }
}
