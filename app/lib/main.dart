import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home()
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(49, 30, 5, 1),
          title: const Text('TrueGallery', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
        ),
        body: SafeArea(
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FittedBox(
                fit: BoxFit.fill,
                child: Image.asset('assets/frame.jpeg')
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: HomeBody()
              ),
              Expanded(
                child: Spacer()
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: HomeFooter()
              )
        ])));
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(0, 0, 0, 0),
            width: 10
          ),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(
          'Welcome!',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)
          ),
        Text(
          "It's your first day as museum curator! You've been tasked with putting together a gallery for visitors next week. Beware though - interspered among your choices are AI images.\n",
          style: TextStyle(fontSize: 16)
          )   
    ]));
  }
}

class HomeFooter extends StatelessWidget {
  const HomeFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const Divider(),
      Text(
        "AI art can sometimes look real",
        style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic)
      )   ]);
    }
}