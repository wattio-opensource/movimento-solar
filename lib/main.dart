import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movimento_solar/assets/ceu.dart';
import 'package:movimento_solar/assets/nuvem.dart';
import 'package:movimento_solar/assets/passaro.dart';
import 'package:movimento_solar/assets/sol.dart';
import 'package:movimento_solar/movimento.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movimento Solar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black12,
        ),
      ),
      home: const PaginaInicial(),
    );
  }
}

class PaginaInicial extends StatefulWidget {
  const PaginaInicial({Key? key}) : super(key: key);

  @override
  State<PaginaInicial> createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial>
    with TickerProviderStateMixin {
  late final controlador6s = AnimationController(
    duration: const Duration(seconds: 6),
    vsync: this,
  );
  late final controlador12s = AnimationController(
    duration: const Duration(seconds: 12),
    vsync: this,
  );
  final int nPassaros = 8;
  final int nNuvens = 5;
  final List<double> passarosOffsetY = [];
  final List<double> passarosOffsetX = [];
  final List<double> nuvensOffsetY = [];
  final List<double> nuvensOffsetX = [];
  bool amanheceu = false;
  @override
  void initState() {
    final rand = Random();

    // distribuição de espaços dos pássaros
    for (int i = 0; i < nPassaros; i++) {
      passarosOffsetY.add(0.4 * rand.nextDouble());
      passarosOffsetX.add(0.5 * rand.nextDouble());
    }

    // distribuição de espaços das nuvens
    for (int i = 0; i < nNuvens; i++) {
      nuvensOffsetY.add(0.4 * rand.nextDouble());
      nuvensOffsetX.add(0.8 * rand.nextDouble());
    }

    // fazendo com que o controlador redesenhe a tela sempre
    // e diga se amanheceu ou não, para mostrar ou não os pássaros e nuvens
    controlador6s.addListener(() => setState(() {
          if (controlador6s.value > 0.5) amanheceu = true;
        }));

    // fazendo com que os controladores reiniciem sempre que chegarem ao final
    controlador6s.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controlador6s.reset();
        controlador6s.forward();
      }
    });
    controlador12s.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controlador12s.reset();
        controlador12s.forward();
      }
    });

    // iniciando
    controlador6s.forward();
    controlador12s.forward();
    super.initState();
  }

  @override
  void dispose() {
    controlador6s.dispose();
    controlador12s.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Ceu(controlador: controlador6s),
          sol(),
          ...passaros(),
          ...nuvens(),
        ],
      ),
    );
  }

  Movimento sol() {
    // sol possui movimento em Y, X é estático
    return Movimento(
      repetir: false,
      controlador: controlador6s,
      posX: (valor) => 0.7,
      posY: (valor) => valor * 0.85,
      child: Sol(controlador: controlador6s),
    );
  }

  List<Widget> passaros() => [
        for (int i = 0; i < nPassaros; i++)
          // passaros se movimentam linearmente em X com um offset de espaçamento
          // passaros tem o Y fixo, cada um com um offset
          Visibility(
            visible: amanheceu,
            child: Movimento(
              posX: (valor) => valor + passarosOffsetX[i],
              posY: (valor) => 0.4 + passarosOffsetY[i],
              repetir: true,
              controlador: controlador6s,
              child: const Passaro(),
            ),
          )
      ];
  List<Widget> nuvens() => [
        for (int i = 0; i < nNuvens; i++)
          // nuvens se movimentam linearmente em X com um offset de espaçamento
          // nuvens tem o Y fixo, cada um com um offset
          Visibility(
            visible: amanheceu,
            child: Movimento(
              posX: (valor) => valor + nuvensOffsetX[i],
              posY: (valor) => 0.5 + nuvensOffsetY[i],
              repetir: true,
              controlador: controlador12s,
              child: const Nuvem(),
            ),
          )
      ];
}
