import 'package:flutter/material.dart';
import 'package:movimento_solar/estrelas.dart';
import 'package:movimento_solar/sol.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movimento Solar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black12,
        ),
      ),
      home: const Ceu(
        corInicial: Color(0xff0c1445),
        corFinal: Color(0xff76d7ea),
      ),
    );
  }
}

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
    return Scaffold(
      backgroundColor: _cor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Estrelas(
            duracao: widget.duracao,
            nEstrelas: 88,
          ),
          Sol(duracao: widget.duracao),
        ],
      ),
    );
  }

  Color get _cor => Color.lerp(
        widget.corInicial,
        widget.corFinal,
        controlador.value,
      )!;
}
