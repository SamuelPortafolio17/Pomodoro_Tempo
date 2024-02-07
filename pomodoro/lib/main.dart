import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? _timer;
  int _inicio = 25 * 60;
  int _desc = 5 * 60;

  void _restadesc(Timer timer) {
    setState(() {
      if (_desc == 0) {
        timer.cancel();
      } else {
        _desc--;
      }
    });
  }

  void _iniciarTimerDesc() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, _restadesc);
  }

  void _resta(Timer timer) {
    setState(() {
      if (_inicio == 0) {
        timer.cancel();
      } else {
        _inicio--;
      }
    });
  }

  void _iniciarTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, _resta);
  }

  void _pararTimer() {
    _timer!.cancel();
  }

  void _reinicioTimer() {
    _pararTimer();
    setState(() {
      _inicio = 25 * 60;
    });
  }

  @override
  void dispose() {
    _pararTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Center(
        child: Text("ASISTENTE POMODORO"),
      ),
      backgroundColor: Colors.cyan,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${_inicio ~/ 60}:${(_inicio % 60).toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 48),
            ),
            Row(
              children: [
                SizedBox(
                  width: (MediaQuery.of(context).size.width * (1 / 5)),
                ),
                IconButton(
                  onPressed: _iniciarTimer,
                  tooltip: "EMPEZAR TEMPORIZADOR",
                  style: ButtonStyle(
                    side: MaterialStateBorderSide.resolveWith(
                        (states) => const BorderSide(color: Colors.black)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    )),
                    backgroundColor:
                        MaterialStateColor.resolveWith((states) => Colors.cyan),
                    fixedSize: MaterialStateProperty.resolveWith(
                      (states) => Size((MediaQuery.of(context).size.width / 5),
                          (MediaQuery.of(context).size.height / 2.5) / 5),
                    ),
                  ),
                  icon: const Icon(Icons.play_circle_rounded),
                  color: Colors.white,
                ),
                IconButton(
                    onPressed: _pararTimer,
                    tooltip: "DETENER TEMPORIZADOR",
                    style: ButtonStyle(
                      side: MaterialStateBorderSide.resolveWith(
                          (states) => const BorderSide(color: Colors.black)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      )),
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.cyan),
                      fixedSize: MaterialStateProperty.resolveWith(
                        (states) => Size(
                            (MediaQuery.of(context).size.width / 5),
                            (MediaQuery.of(context).size.height / 2.5) / 5),
                      ),
                    ),
                    icon: const Icon(Icons.pause_circle_outline_rounded),
                    color: Colors.white),
                IconButton(
                    onPressed: _reinicioTimer,
                    tooltip: "REINICIAR TEMPORIZADOR",
                    style: ButtonStyle(
                      side: MaterialStateBorderSide.resolveWith(
                          (states) => const BorderSide(color: Colors.black)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      )),
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.cyan),
                      fixedSize: MaterialStateProperty.resolveWith(
                        (states) => Size(
                            (MediaQuery.of(context).size.width / 5),
                            (MediaQuery.of(context).size.height / 2.5) / 5),
                      ),
                    ),
                    icon: const Icon(Icons.refresh_rounded),
                    color: Colors.white),
                SizedBox(
                  width: (MediaQuery.of(context).size.width * (1 / 5)),
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.cyan,
        child: IconButton(
          onPressed: null,
          tooltip: "INICIAR DESCANSO",
          icon: const Icon(Icons.play_circle_fill_rounded),
          color: Colors.cyan,
          iconSize: 30,
          style: ButtonStyle(
            backgroundColor:
                MaterialStateColor.resolveWith((states) => Colors.white),
            side: MaterialStateBorderSide.resolveWith(
                (states) => const BorderSide(color: Colors.black)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            )),
            fixedSize: MaterialStateProperty.resolveWith(
              (states) => Size((MediaQuery.of(context).size.width *(1/ 5)),
                  (MediaQuery.of(context).size.height / 2.5) / 5),
            ),
          ),
        ),
      ),
    );
  }
}