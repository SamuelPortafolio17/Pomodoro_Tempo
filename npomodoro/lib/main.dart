import 'package:flutter/material.dart';
import 'dart:async';
import 'package:npomodoro/notificaciones.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initNotifications();
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
    _inicio != 0 ? _timer = Timer.periodic(oneSec, _resta) : notificacion;
  }

  void _pararTimer() {
    _timer?.cancel();
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
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Colors.red, Colors.orange],
        )),
        width: double.infinity,
        child: Column(
          children: <Widget>[
            const Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Text(
                  'ASISTENTE POMODORO',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                  ),
                )),
            const Padding(padding: EdgeInsets.only(bottom: 100)),
            _inicio != 0
                ? Text(
                    '${_inicio ~/ 60}:${(_inicio % 60).toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 48, color: Colors.black),
                  )
                : Text(
                    '${_desc ~/ 60}:${(_desc % 60).toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 48, color: Colors.black),
                  ),
            const SizedBox(
              height: 100.0,
            ),
            Expanded(
                child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.white12, Colors.orange]),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0))),
              child: Row(
                children: [
                  SizedBox(
                    width: (MediaQuery.of(context).size.width * (1 / 5)),
                  ),
                  IconButton(
                    onPressed: _inicio != 0 ? _iniciarTimer : _iniciarTimerDesc,
                    tooltip: "EMPEZAR TEMPORIZADOR",
                    style: ButtonStyle(
                      side: MaterialStateBorderSide.resolveWith(
                          (states) => const BorderSide(color: Colors.black)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      )),
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.orange.shade500),
                      fixedSize: MaterialStateProperty.resolveWith(
                        (states) => Size(
                            (MediaQuery.of(context).size.width / 5),
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        )),
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.orange.shade500),
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
                      tooltip: "REINICIAR POMODORO",
                      style: ButtonStyle(
                        side: MaterialStateBorderSide.resolveWith(
                            (states) => const BorderSide(color: Colors.black)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        )),
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.orange.shade500),
                        fixedSize: MaterialStateProperty.resolveWith(
                          (states) => Size(
                              (MediaQuery.of(context).size.width / 5),
                              (MediaQuery.of(context).size.height / 2.5) / 5),
                        ),
                      ),
                      icon: const Icon(Icons.refresh_rounded),
                      color: Colors.white),
                ],
              ),
            ))
          ],
        ),
      ),
      /*backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Center(
          child: Text("ASISTENTE POMODORO"),
        ),
        backgroundColor: Colors.red[200],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
                    padding: EdgeInsets.only(bottom: 200),
                    child: Text(
                      'CONTADOR DE POMODOROS',
                    ),
                  ),
            _inicio != 0
                ? Text(
                    '${_inicio ~/ 60}:${(_inicio % 60).toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 48),
                  )
                : Text(
                    '${_desc ~/ 60}:${(_desc % 60).toString().padLeft(2, '0')}',
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
                        MaterialStateColor.resolveWith((states) => Colors.red),
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
                          (states) => Colors.red),
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
                    tooltip: "REINICIAR POMODORO",
                    style: ButtonStyle(
                      side: MaterialStateBorderSide.resolveWith(
                          (states) => const BorderSide(color: Colors.black)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      )),
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.red),
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
          color: Colors.red[200],
          child: Row(
            children: [
              SizedBox(
                width: (MediaQuery.of(context).size.width / 3),
              ),
              IconButton(
                onPressed: _inicio != 0 ? null : _iniciarTimerDesc,
                tooltip: "INICIAR DESCANSO",
                icon: const Icon(Icons.play_circle_fill_rounded),
                color: Colors.white,
                iconSize: 30,
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateColor.resolveWith((states) => Colors.red),
                  side: MaterialStateBorderSide.resolveWith(
                      (states) => const BorderSide(color: Colors.black)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  )),
                  fixedSize: MaterialStateProperty.resolveWith(
                    (states) => Size(
                        (MediaQuery.of(context).size.width * (1 / 5)),
                        (MediaQuery.of(context).size.height / 2.5) / 5),
                  ),
                ),
              ),
            ],
          )),*/
    );
  }
}
