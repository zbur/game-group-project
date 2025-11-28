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

class GamePage extends StatefulWidget {
  final String theme;
  final int round;
  final Painting? prev1;
  final Painting? prev2;

  const GamePage(
    this.theme, {
    this.round = 1,
    this.prev1,
    this.prev2,
    super.key,
  });

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final Gallery allWorks = Gallery();

  late Painting random1;
  late Painting random2;

  Painting? previous1;
  Painting? previous2;

  int round = 1;
  List<Painting> chosenGallery = [];

  @override
  void initState() {
    super.initState();

    round = widget.round;
    previous1 = widget.prev1;
    previous2 = widget.prev2;

    generateNewPaintings();
  }

  void generateNewPaintings() {
    Painting new1;
    Painting new2;

    do {
      int rn1 = Random().nextInt(6) + 1;
      int rn2 = Random().nextInt(6) + 1;

      new1 = allWorks.returnPainting(widget.theme, "AI", rn1);
      new2 = allWorks.returnPainting(widget.theme, "Real", rn2);

    } while (
        (previous1 != null &&
            new1.number == previous1!.number &&
            new1.type == previous1!.type) ||
        (previous2 != null &&
            new2.number == previous2!.number &&
            new2.type == previous2!.type));

    random1 = new1;
    random2 = new2;

    setState(() {});
  }

  void choosePainting(Painting chosen) {
    chosenGallery.add(chosen);

    if (round == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => GamePage(
            widget.theme,
            round: 2,
            prev1: random1,
            prev2: random2,
          ),
        ),
      );
    }
    else {
      allWorks.markThemeCompleted(widget.theme);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Game()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          allWorks.themeColors[allWorks.themes.indexOf(widget.theme)],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor:
            allWorks.themeColors[allWorks.themes.indexOf(widget.theme)],
        title: Text('TrueGallery: ${widget.theme}',
            style:
                const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FullscreenImageHero(
                        tag: 'ai-${random1.number}-${widget.theme}',
                        assetPath:
                            'assets/${widget.theme}-AI-${random1.number}.png',
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: 'ai-${random1.number}-${widget.theme}',
                  child: SizedBox(
                    width: 200,
                    child: Image.asset(
                        'assets/${widget.theme}-AI-${random1.number}.png',
                        fit: BoxFit.fitHeight),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FullscreenImageHero(
                        tag: 'real-${random2.number}-${widget.theme}',
                        assetPath:
                            'assets/${widget.theme}-Real-${random2.number}.png',
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: 'real-${random2.number}-${widget.theme}',
                  child: SizedBox(
                    width: 200,
                    child: Image.asset(
                        'assets/${widget.theme}-Real-${random2.number}.png',
                        fit: BoxFit.fitHeight),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () => choosePainting(random1),
                    child: const Text("Painting 1"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () => choosePainting(random2),
                    child: const Text("Painting 2"),
                  ),
                ],
              ),

              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}

class FullscreenImageHero extends StatelessWidget {
  final String tag;
  final String assetPath;

  const FullscreenImageHero({
    required this.tag,
    required this.assetPath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Hero(
            tag: tag,
            child: Image.asset(assetPath),
          ),
        ),
      ),
    );
  }
}
