import 'dart:async';
import './history.dart';
import './settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ponto Digital',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Ponto Digital'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  bool flag = true;
  Stream<int> timerStream;
  StreamSubscription<int> timerSubscription;
  String hoursStr = '00';
  String minutesStr = '00';
  String secondsStr = '00';

  Stream<int> stopWatchStream() {
    StreamController<int> streamController;
    Timer timer;
    Duration timerInterval = Duration(seconds: 1);
    int counter = 0;

    void stopTimer() {
      if (timer != null) {
        timer.cancel();
        timer = null;
        counter = 0;
        streamController.close();
      }
    }

    void tick(_) {
      counter++;
      streamController.add(counter);
      if (!flag) {
        stopTimer();
      }
    }

    void startTimer() {
      timer = Timer.periodic(timerInterval, tick);
    }

    streamController = StreamController<int>(
      onListen: startTimer,
      onCancel: stopTimer,
      onResume: startTimer,
      onPause: stopTimer,
    );
    return streamController.stream;
  }

  DateTime initialJourneyTime;
  bool setInitialJourney = true;
  String initialJourney;

  void startJourney() {
    setState(() {
      if(setInitialJourney == true){
        initialJourneyTime = DateTime.now();
        initialJourney = DateFormat('Hm').format(initialJourneyTime);
      }
      setInitialJourney = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(children: <Widget>[

          // Botão de inicio de jornada
          Container(
            margin: EdgeInsets.only(top: 15),
            width: 400,
            height: 120,
            // ignore: deprecated_member_use
            child: RaisedButton(
              child: Text(
                setInitialJourney ? 'Início de Jornada': initialJourney+' - '+"$hoursStr:$minutesStr:$secondsStr",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w500
                )
              ),
              color: Colors.purple[400],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(10),
                side: BorderSide(color: Colors.black, width: 2)
              ),
              onPressed: () {
                startJourney();

                timerStream = stopWatchStream();
                timerSubscription = timerStream.listen((int newTick) {
                  setState(() {
                    hoursStr = ((newTick / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
                    minutesStr = ((newTick / 60) % 60).floor().toString().padLeft(2, '0');
                    secondsStr = (newTick % 60).floor().toString().padLeft(2, '0');
                  });
                });

              }
            ),
          ),

                // Botão de inicio de descanso
          Container(
            margin: EdgeInsets.only(top: 15),
            width: 400,
            height: 120,
            child: RaisedButton(
              onPressed: () {},
              child: Text('Início de Descanso', style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w500
                )
              ),
              color: Colors.amber,
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(10),
              side: BorderSide(color: Colors.black, width: 2)
              ),
            ),
          ),

          // Botão de final de descanso
          Container(
            margin: EdgeInsets.only(top: 15),
            width: 400,
            height: 120,
            child: RaisedButton(
              onPressed: () {},
              child: Text('Final de Descanso', style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w500
              )),
              color: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(10),
                  side: BorderSide(color: Colors.black, width: 2)
              ),
            ),
          ),

          // Botão do final de jornada
          Container(
            margin: EdgeInsets.only(top: 15),
            width: 400,
            height: 120,
            child: RaisedButton(
              onPressed: () {},
              child: Text('Final de Jornada', style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w500
              )),
              color: Colors.red.shade700,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(10),
                  side: BorderSide(color: Colors.black, width: 2)
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 15),
            width: 400,
            height: 120,
            child: Row(children: [
              Container(
                width: 190,
                height: 120,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => History()),
                    );
                  },
                  child: Text('Histórico', style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w500
                  )),
                  color: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(10),
                      side: BorderSide(color: Colors.black, width: 2)
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(left: 20),
                width: 190,
                height: 120,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Settings())
                    );
                  },
                  child: Text('Configurações', style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500
                  )),
                  color: Colors.black38,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(10),
                      side: BorderSide(color: Colors.black, width: 2)
                  ),
                ),
              )
            ]),
          )
        ])
      ),
    );
  }
}
