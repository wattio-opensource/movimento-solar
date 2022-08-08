import 'dart:math';

import 'package:flutter/material.dart';

class Ceu extends StatefulWidget {
  final Color corInicial;
  final Color corFinal;
  final Color corDaEstrela;
  final int nEstrelas;
  final AnimationController controlador;

  const Ceu({
    this.corInicial = const Color(0xff0c1445),
    this.corFinal = const Color(0xff76d7ea),
    this.corDaEstrela = Colors.white,
    this.nEstrelas = 36,
    required this.controlador,
    Key? key,
  }) : super(key: key);

  @override
  State<Ceu> createState() => _CeuState();
}

class _CeuState extends State<Ceu> {
  final List<Map<String, double>> coordenadas = [];
  bool completou = false;
  @override
  void initState() {
    widget.controlador.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => completou = true);
      }
    });
    // lógica interna para controlar o mudança de cor do céu
    final rand = Random();
    for (int i = 0; i < widget.nEstrelas; i++) {
      coordenadas.add({
        'x': -1 + rand.nextDouble() * 2,
        'y': -1 + rand.nextDouble() * 2,
      });
    }
    // coordenadas das estrelas
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final nEstrelas =
        (completou ? 0 : (1 - widget.controlador.value)) * widget.nEstrelas;
    // lógica para estrelas irem desaparecendo
    return DecoratedBox(
      decoration: BoxDecoration(color: _cor),
      child: Stack(
        children: [
          for (int i = 0; i < nEstrelas.toInt(); i++)
            Align(
              alignment: Alignment(
                coordenadas[i]['x']!,
                coordenadas[i]['y']!,
              ),
              child: Icon(
                Icons.star,
                size: 12,
                color: widget.corDaEstrela,
              ),
            )
        ],
      ),
    );
  }

  Color get _cor => Color.lerp(
        widget.corInicial,
        widget.corFinal,
        completou ? 1 : widget.controlador.value,
      )!;
  // interpolação linear entre as cores
}
