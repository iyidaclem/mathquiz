import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/questions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
     ChangeNotifierProvider(
       create: (ctx)=>Questions()
     ),
     
      ],
      
      child: Consumer<Questions>(
        builder: (context, question, _) { 
          
       Provider.of<Questions>(context, listen: false).fetchHighScore();

          var children2 = [
            Text(!question.havePlayed ?"Click play to start":"Oops! game over",
                style: TextStyle(fontSize: 20)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.blue[900]),
              onPressed: () {
                question.startTimer();
              },
              child: Text(!question.havePlayed ? "Play" : "Play Again",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  )),
            ),
          ];
          
          var children3 = [
           Container( margin:EdgeInsets.only(bottom: 30) ,child:  Center( child:Text("Your score: ${question.score}",style: TextStyle(fontSize: 30))),),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(width: 1),
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 40),
              width: 100,
              height: 100,
              child: Center(child:Column(children: [Icon(Icons.alarm_on,color: Colors.blue[900],),Text("${question.getTime}",style: TextStyle(fontSize: 30))],)),
            ),
            Text("${question.num1} + ${question.num2} = ?", style: TextStyle(fontSize: 30)),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(onPressed: () {question.chooseAnswer(question.answers[0]);}, child: Text("${question.answers[0]}", style: TextStyle(fontSize: 20))),
                  OutlinedButton(onPressed: () {question.chooseAnswer(question.answers[1]);}, child: Text("${question.answers[1]}", style: TextStyle(fontSize: 20))),
                  OutlinedButton(onPressed: () {question.chooseAnswer(question.answers[2]);}, child: Text("${question.answers[2]}", style: TextStyle(fontSize: 20))),
                  OutlinedButton(onPressed: () {question.chooseAnswer(question.answers[3]);}, child: Text("${question.answers[3]}", style: TextStyle(fontSize: 20)))
                ],
              ),
            )
          ];

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primaryColor: Colors.blue[900],
              primarySwatch: Colors.orange,
            ),
            home: Scaffold(
              appBar: AppBar(
                title: Text("Math quiz"),
                actions: [
                  Center(
                      child: Text(
                    "High Score: ${question.getHighScore}",
                    style: TextStyle(fontSize: 20),
                  )),
                ],
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: question.getStatus != "3" ? children2 : children3,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
