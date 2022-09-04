import 'package:flutter/material.dart';

class Passaro extends StatelessWidget {
  final double altura;
  const Passaro({this.altura = 86, super.key});

  @override
  Widget build(BuildContext context) {
    return Image(
      height: altura,
      image: const AssetImage('assets/passaro-branco.gif'),
    );
  }
}
