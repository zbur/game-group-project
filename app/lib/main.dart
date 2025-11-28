import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/exported_data.dart';
import 'dart:math';

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
            "It's your first day as museum curator! You've been tasked with putting together a gallery for visitors next week. Beware though - among your choices are AI images.\n",
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
             Navigator.push(
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
             Navigator.push(
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
        "AI creations sometimes look like art. That doesn't mean they are.",
        style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic)
      )   ]);
    }
}

class Game extends StatelessWidget {

  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 249, 195),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 86, 53, 11),
        title: const Text('TrueGallery', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Text("Click on a door to curate art for a theme.\nBe careful - half of what you see is AI."),
            Text("Themes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              Door("Despair"),
              Door("Fantasy")
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              Door("Love"),
              Door("Nature")
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              Door("Religion"),
              Door("War")
            ]),
            HomeFooter()
          ]
          ),
        )
      )
    );
  }
}

class Door extends StatelessWidget {
  final String name;

  const Door(this.name, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      IconButton(
        icon: Image.asset("assets/$name-Door.png", height: 125),
        iconSize: 125,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => GamePage(name),
            )
          );
        }
      ),
      Text(name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
    ]);
  }
}

class GamePage extends StatelessWidget {
  final String theme;
  final Gallery allWorks = Gallery();
  late Painting random1;
  late Painting random2;

  GamePage(this.theme, {super.key}) {
    int rn1 = Random().nextInt(6)+1;
    int rn2 = Random().nextInt(6)+1;
    random1 = allWorks.returnPainting(theme, "AI", rn1);
    random2 = allWorks.returnPainting(theme, "Real", rn2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: allWorks.themeColors[allWorks.themes.indexOf(theme)],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: allWorks.themeColors[allWorks.themes.indexOf(theme)],
        title: Text('TrueGallery: $theme', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Changed from center to start
            crossAxisAlignment: CrossAxisAlignment.center, // Ensure horizontal centering
            children: [
              SizedBox(
                width: 200, 
                child: Image.asset('assets/$theme-AI-${random1.number}.png', fit: BoxFit.fitHeight)
              ),
              SizedBox(height: 10), // Add spacing between images
              SizedBox(
                width: 200, 
                child: Image.asset('assets/$theme-Real-${random2.number}.png', fit: BoxFit.fitHeight)
              ),
              // This spacer will push everything to the top and leave space at bottom
              Expanded(child: Container()), // This creates flexible space at the bottom
            ]
          )
        )
      )
    );
  }
}