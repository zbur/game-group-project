import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/exported_data.dart';
import 'dart:math';

void main() {
  runApp(
    GameStateProvider(
      notifier: ValueNotifier<GameState>(GameState()),
      child: const MainApp()
    )
  );
}

class GameState {
  late Gallery _allWorks;
  late Gallery _savedWorks;

  GameState():
    _allWorks = Gallery(),
    _savedWorks = Gallery();

  GameState.from(Gallery allWorks, Gallery savedWorks)
    : _allWorks = allWorks,
    _savedWorks = savedWorks;

  void reset() {
    _allWorks = Gallery();
    _savedWorks = Gallery();
  }
}

class GameStateProvider extends InheritedNotifier<ValueNotifier<GameState>> {
  const GameStateProvider(
    {super.key,
    required super.child,
    required ValueNotifier<GameState> super.notifier});

  static ValueNotifier<GameState> of(BuildContext context) {
    return context
    .dependOnInheritedWidgetOfExactType<GameStateProvider>()!
    .notifier!;
  }
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
        title: const Text('TrueGallery', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
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
  final String theme;

  const Door(this.theme, {super.key});

  @override
  Widget build(BuildContext context) {

    // Get current game state
    ValueNotifier<GameState> gsNotifier = GameStateProvider.of(context);
    GameState gameState = gsNotifier.value;

    if(gameState._allWorks.themes.contains(theme)) {
      return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        IconButton(
          icon: Image.asset("assets/$theme-Door.png", height: 125),
          iconSize: 125,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                builder: (context) => GamePage(theme),
              )
            );
          }
        ),
        Text(theme, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
      ]);
    } else {
      return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        IconButton(
          icon: Image.asset("assets/$theme-Door-Complete.png", height: 125),
          iconSize: 125,
          onPressed: () {
            null;
          }
        ),
        Text(theme, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
      ]);
    }
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
  late Painting random1;
  late Painting random2;

  Painting? previous1;
  Painting? previous2;

  late GameState gameState;
  int round = 1;

  @override
  void initState() {
    super.initState();

    round = widget.round;
    previous1 = widget.prev1;
    previous2 = widget.prev2;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Get current game state
      ValueNotifier<GameState> gsNotifier = GameStateProvider.of(context);
      gameState = gsNotifier.value;
      
      generateNewPaintings();
    });
  }

  void generateNewPaintings() {
    Painting new1;
    Painting new2;

    do {
      int rn1 = Random().nextInt(6) + 1;
      int rn2 = Random().nextInt(6) + 1;

      new1 = gameState._allWorks.returnPainting(widget.theme, "AI", rn1);
      new2 = gameState._allWorks.returnPainting(widget.theme, "Real", rn2);

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
    gameState._savedWorks.gallery.add(chosen);

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
    } else {
      gameState._allWorks.themes.remove(widget.theme);

      if(gameState._allWorks.themes.isEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const EndPage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Game()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Set appbar text color depending on theme
    Color appBarColor = Colors.white;
    if(widget.theme == "Religion") {
      appBarColor = Colors.black;
    }
  
    // Randomise display order
    bool consecutiveOrder = Random().nextBool();
    Painting display1 = random1;
    Painting display2 = random2;
    String type1 = "AI";
    String type2 = "Real";

    if(!consecutiveOrder) {
      display1 = random2;
      display2 = random1;
      type1 = "Real";
      type2 = "AI";
    }

    return Scaffold(
      backgroundColor:
          gameState._allWorks.themeColors[gameState._allWorks.themes.indexOf(widget.theme)],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor:
            gameState._allWorks.themeColors[gameState._allWorks.themes.indexOf(widget.theme)],
        title: Text('TrueGallery: ${widget.theme}',
            style:
                TextStyle(color: appBarColor, fontWeight: FontWeight.bold)),
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
                        tag: '$type1-${display1.number}-${widget.theme}',
                        assetPath:
                            'assets/${widget.theme}-$type1-${display1.number}.png',
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: '$type1-${display1.number}-${widget.theme}',
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 200),
                    child: Image.asset('assets/${widget.theme}-$type1-${display1.number}.png', fit: BoxFit.contain),
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
                        tag: '$type2-${display2.number}-${widget.theme}',
                        assetPath:
                            'assets/${widget.theme}-$type2-${display2.number}.png',
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: '$type2-${display2.number}-${widget.theme}',
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 200),
                    child: Image.asset('assets/${widget.theme}-$type2-${display2.number}.png', fit: BoxFit.contain),
                    ),
                ),
              ),

                         const SizedBox(height: 20),

        //parchment style dialogue box
Container(
  padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 22),
  margin: const EdgeInsets.only(top: 20, bottom: 25),
  decoration: BoxDecoration(
    color: const Color(0xFFF7E7C1),
    borderRadius: BorderRadius.circular(14),
    border: Border.all(
      color: const Color(0xFF3C2F17),
      width: 3,
    ),
    gradient: const LinearGradient(
      colors: [
        Color(0xFFF7E7C1),
        Color(0xFFF0DDAF),
        Color(0xFFF7E7C1),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  child: const Text(
    "Which painting will you choose for your gallery?",
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Color(0xFF3C2F17),
      height: 1.35,
    ),
  ),
),


            //Buttons for choosing paintings
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                  onPressed: () => choosePainting(display1),
                  child: const Text("Painting 1"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                  onPressed: () => choosePainting(display2),
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
}}

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
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        backgroundColor: Colors.black,
        child: Icon(Icons.close, color: Colors.white),
      ),
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

class EndPage extends StatefulWidget {
  const EndPage({super.key});

  @override
  State<EndPage> createState() => _EndPageState();
}

class _EndPageState extends State<EndPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Get current game state
    ValueNotifier<GameState> gsNotifier = GameStateProvider.of(context);
    GameState gameState = gsNotifier.value;

    List<Painting> savedGallery = gameState._savedWorks.gallery;
  // Work out accuracy percentage
    double accuracy = 100 *
        savedGallery.where((item) => item.type != "AI").toList().length /
        savedGallery.length;

    String displayText;
    //Win
    if (accuracy > 60) {
      displayText =
          "Success! Your gallery was hugely successful, and people are visiting in droves.";
    } else {
      //Loss
      //Inaccuracy percentage
      double inaccuracy = 100 - accuracy;
      displayText =
          "Failure! At first, people seemed indifferent to the work you had put together. But when they found out it was ${inaccuracy.toInt()}% AI, controversy grew.";
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 249, 195),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 86, 53, 11),
        title: const Text('TrueGallery',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                displayText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 40),
              
SizedBox(
  width: double.infinity,
  height: 260,
  child: AnimatedBuilder(
    animation: controller,
    builder: (_, __) {
      final double progress = controller.value; 
      final double screenWidth = MediaQuery.of(context).size.width;

      const double paintingSize = 170;     
      const double gap = 60;               
      final double totalWidthPerPainting = paintingSize + gap;
// Total virtual width = enough space for all paintings + extra loop room
      final double totalSpan =
          totalWidthPerPainting * savedGallery.length + screenWidth;

      return Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              "Your Gallery",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.brown[900],
              ),
            ),
          ),

          ...List.generate(savedGallery.length, (index) {
            final painting = savedGallery[index];
            double baseX = (progress * 0.2 * totalSpan) % totalSpan;
            double paintingStart = index * totalWidthPerPainting;
            double x = paintingStart - baseX;
            if (x < -paintingSize) {
              x += totalSpan;
            }

            return Positioned(
              top: 80,
              left: x,
              child: SizedBox(
                width: paintingSize,
                height: paintingSize,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/${painting.theme}-${painting.type}-${painting.number}.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }),
        ],
      );
    },
  ),
),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const Home()),
                  );
                },
                child: const Text("Play Again"),
             
              if (accuracy <= 60) ...[
                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 18, horizontal: 22),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7E7C1),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: const Color(0xFF3C2F17),
                      width: 3,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.brown,
                        offset: Offset(3, 3),
                        blurRadius: 6,
                      ),
                      BoxShadow(
                        color: Colors.white60,
                        offset: Offset(-3, -3),
                        blurRadius: 6,
                      ),
                    ],
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFF7E7C1),
                        Color(0xFFF0DDAF),
                        Color(0xFFF7E7C1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Text(
                    "Your gallery stirred up a bit of controversy...\n"
                    "Looks like people don't want to see AI art.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}