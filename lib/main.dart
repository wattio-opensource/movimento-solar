import 'package:flutter/material.dart';
import 'package:movimento_solar/ceu.dart';
import 'package:movimento_solar/estrelas.dart';
import 'package:movimento_solar/nuvens.dart';
import 'package:movimento_solar/passaros.dart';
import 'package:movimento_solar/sol.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const duracao = Duration(seconds: 6);
    return MaterialApp(
      title: 'Movimento Solar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black12,
        ),
      ),
      home: Scaffold(
        body: Stack(
          children: const [
            Ceu(
              corInicial: Color(0xff0c1445),
              corFinal: Color(0xff76d7ea),
              duracao: duracao,
            ),
            Estrelas(duracao: duracao, nEstrelas: 88),
            Sol(duracao: duracao),
            Passaros(duracao: duracao),
            Nuvens(duracao: duracao, nNuvens: 6),
          ],
        ),
      ),
    );
  }
}
