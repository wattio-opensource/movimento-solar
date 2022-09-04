import 'package:flutter/material.dart';

class Nuvem extends StatelessWidget {
  final double altura;
  final Color cor;
  const Nuvem({
    super.key,
    this.altura = 98,
    this.cor = const Color(0xff999999),
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: .7,
      child: Icon(
        Icons.cloud_rounded,
        size: altura,
        color: cor,
        shadows: [
          BoxShadow(
            blurRadius: 12,
            spreadRadius: 32,
            color: cor,
          )
        ],
      ),
    );
  }
}
