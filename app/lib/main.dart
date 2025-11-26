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
        backgroundColor: const Color.fromARGB(255, 249, 249, 195),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 86, 53, 11),
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
          ),
          HomeButtons()
    ]));
  }
}

class HomeButtons extends StatelessWidget {
  const HomeButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
            WidgetStateProperty.all<Color>(Color.fromARGB(255, 52, 77, 82)),
            foregroundColor:
            WidgetStateProperty.all<Color>(Colors.white),
          ),
          onPressed: () {
             Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const Game(),
              )
             );
          },
          child: const Text('Play')
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
            WidgetStateProperty.all<Color>(Colors.white),
            foregroundColor:
            WidgetStateProperty.all<Color>(Colors.black),
          ),
          onPressed: () {
             Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const Game(),
              )
             );
          },
          child: const Text('Resume')
        )
    ]);
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

class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}