import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'models/exported_data.dart';
import 'dart:math';

const String ALL_WORKS_KEY = "AllWorks";
const String SAVED_WORKS_KEY = "SavedWorks";

void main() {
  runApp(
    GameStateProvider(
      notifier: ValueNotifier<GameState>(GameState()),
      child: const MainApp()
    )
  );
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

class GameSave extends StatelessWidget {
  const GameSave({super.key});

  Future save(BuildContext context) async {
    ValueNotifier<GameState> gsNotifier = GameStateProvider.of(context);
    GameState gameState = gsNotifier.value;

    // Take the user-affected contents of savedWorks and put them into a single string list
    List<String> savedWorks = [];
    for(var i = 0; i < gameState._savedWorks.gallery.length; i++) {
      savedWorks.add(gameState._savedWorks.gallery[i].theme);
      savedWorks.add(gameState._savedWorks.gallery[i].type);
      savedWorks.add(gameState._savedWorks.gallery[i].number);
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(ALL_WORKS_KEY, gameState._allWorks.themes);
    await prefs.setStringList(SAVED_WORKS_KEY, savedWorks);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () async {
            await save(context);
            const messageDialog = MessageDialog(
              title: 'Saved',
              message: 'Current progress has been saved!',
            );
            if (!context.mounted) {
              return;
            }
            await messageDialog.show(context);
          },
          iconSize: 20,
          icon: const Icon(Icons.save)
        )
      ],
    );
  }
}

class GameLoad extends StatelessWidget {
  const GameLoad({super.key});

  Future load(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> lSavedWorks = prefs.getStringList(SAVED_WORKS_KEY) ?? [];
    List<String> themes = prefs.getStringList(ALL_WORKS_KEY) ?? [];
    
    Gallery savedWorks = Gallery();
    Gallery allWorks = Gallery();

    if(lSavedWorks.isNotEmpty && themes.isNotEmpty) {
      allWorks.themes = themes;

      for(var i = 0; i < lSavedWorks.length/3; i++) {
        savedWorks.add(lSavedWorks[i*3], lSavedWorks[i*3+1], int.parse(lSavedWorks[i*3+2]));
      }
    }

    GameState gameState = GameState.from(allWorks, savedWorks);

    if(!context.mounted) {
      return;
    }

    ValueNotifier<GameState> gsNotifier = GameStateProvider.of(context);
    gsNotifier.value = gameState;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
            WidgetStateProperty.all<Color>(Colors.white),
            foregroundColor:
            WidgetStateProperty.all<Color>(Colors.black),
          ),
          onPressed: () async {
            await load(context);

            if (!context.mounted) {
              return;
            }

            const messageDialog = MessageDialog(
              title: 'Loaded',
              message: 'Previous game has been loaded from a save!',
            );
            await messageDialog.show(context);
            
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => Game()
              ),
            );

          },
          child: const Text('Resume')
        )
      ],
    );
  }
}

class MessageDialog {
  final String title;
  final String message;

  const MessageDialog({required this.title, required this.message});

  Future<void> show(BuildContext context) {
    final platform = Theme.of(context).platform;
    if (platform == TargetPlatform.iOS) {
      return _buildCupertinoDialog(context);
    }
    return _buildMaterialDialog(context);
  }

  Future<void> _buildMaterialDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
        ]);
    });
  }

  Future<void> _buildCupertinoDialog(BuildContext context) {
    return showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            CupertinoButton(
              child: const Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
        ]);
    });
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
          child: const Text('New Game')
        ),
        const SizedBox(width: 20),
        GameLoad()
    ]);
  }
}

class HomeFooter extends StatelessWidget {
  const HomeFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const Divider(),
      GestureDetector(
        onTap: () {
          MessageDialog(
            title: "Signs it might be AI",
            message: 
            '''1. Illegible text/markings\n
2. Near-identical faces\n
3. Cartoon-like qualities\n
4. Incomplete people, animals, or objects\n
5. Overly-perfect markings or brushstrokes'''
          ).show(context);
        },
        child: Text(
          "AI creations sometimes look like art. That doesn't mean they are.",
          style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)
        ),
      )
    ]);
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
        title: const Text('Themes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Text("Click on a door to curate art for a theme.\nBe careful - half of what you see is AI."),
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
            GameFooter()
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
        Text(theme, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))
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
        Text(theme, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))
      ]);
    }
  }
}

class GameFooter extends StatelessWidget {
  const GameFooter({super.key});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<GameState> gsNotifier = GameStateProvider.of(context);
    GameState gameState = gsNotifier.value;

    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const Divider(),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GameSave(),
          IconButton(
            onPressed: () => [
              gameState.reset(),
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const Home(),
                )
              )
            ],
          iconSize: 20,
          icon: const Icon(Icons.exit_to_app),
        )
        ]
      )
    ]);
    }
}

class GamePage extends StatefulWidget {
  final String theme;
  final int round;
  final Painting? prev1;
  final Painting? prev2;
  final Painting? rand1;
  final Painting? rand2;

  const GamePage(
    this.theme, {
    this.round = 1,
    this.prev1,
    this.prev2,
    this.rand1,
    this.rand2,
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
    Color themeColor = gameState._allWorks.themeColors[gameState._savedWorks.themes.indexOf(widget.theme)];
    Color textColor = Colors.white;
    Color buttonColor = Colors.black;

    // Determine text and background color based off brightness
    if(ThemeData.estimateBrightnessForColor(themeColor) == Brightness.light) {
      textColor = Colors.black;
      buttonColor = Color(0xFFF7E7C1);
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
      backgroundColor: themeColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: themeColor,
        title: Text('Theme: ${widget.theme}',
            style:
                TextStyle(color: textColor, fontWeight: FontWeight.bold)),
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

              // Parchment style dialogue box
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

            // Buttons for choosing paintings
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    foregroundColor: textColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                  onPressed: () => choosePainting(display1),
                  child: const Text("Painting 1"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    foregroundColor: textColor,
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

class _EndPageState extends State<EndPage> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get current game state
    ValueNotifier<GameState> gsNotifier = GameStateProvider.of(context);
    GameState gameState = gsNotifier.value;

    List<Painting> savedGallery = gameState._savedWorks.gallery;

    if (savedGallery.isEmpty) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 249, 249, 195),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 86, 53, 11),
          title: const Text(
            'TrueGallery',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: const Center(child: Text('No paintings in the gallery.')),
      );
    }

    // Work out accuracy percentage
    double accuracy =
        100 *
        savedGallery.where((item) => item.type != "AI").toList().length /
        savedGallery.length;

    String displayText;
    Color scoreColor;

    // Win / Loss text
    if (accuracy >= 60) {
      displayText =
          "Success! Your gallery was hugely successful, and people are visiting in droves.";
      scoreColor = Colors.green;
    } else {
      displayText =
          "Your gallery stirred up a bit of controversy...\nLooks like people don't want to see AI art.";
      scoreColor = Colors.red;
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 249, 195),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 86, 53, 11),
        title: const Text(
          'TrueGallery',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Score: ",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                "${accuracy.toInt()}%",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: scoreColor,
                ),
              ),
              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 240,
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (_, __) {
                    final double progress = controller.value; // 0..1
                    final double screenWidth = MediaQuery.of(
                      context,
                    ).size.width;

                    const double paintingSize = 170;
                    const double gap = 30;
                    final double totalWidthPerPainting = paintingSize + gap;

                    // total content width occupied by the paintings
                    final double rowWidth =
                        savedGallery.length * totalWidthPerPainting;

                    // wrapWidth: everything must travel this distance so each painting
                    // moves from fully off-right to fully off-left
                    final double wrapWidth = rowWidth + screenWidth;

                    // Linear offset from 0 -> wrapWidth as progress goes 0 -> 1
                    final double offset = progress * wrapWidth;

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

                          // start positions, off right edge 
                          final double paintingStart =
                              screenWidth + index * totalWidthPerPainting;

                          double x = paintingStart - offset;

                          // If painting fully left of screen, wrap forward by wrapWidth
                          while (x < -paintingSize) {
                            x += wrapWidth;
                          }

                          // Keep x within a sane range
                          if (x > wrapWidth) {
                            x = x % wrapWidth;
                          }

                          return Positioned(
                            top: 60,
                            left: x,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        ZoomPaintingPage(painting: painting),
                                  ),
                                );
                              },
                              child: SizedBox(
                                width: paintingSize,
                                height: paintingSize,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.asset(
                                        'assets/${painting.theme}-${painting.type}-${painting.number}.png',
                                        fit: BoxFit.cover,
                                        width: paintingSize,
                                        height: paintingSize,
                                      ),
                                    ),

                                    // AI vs human badge
                                    Positioned(
                                      bottom: 6,
                                      right: 6,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4,
                                          horizontal: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: painting.type == "AI"
                                              ? Colors.redAccent
                                              : Colors.green.shade600,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black54,
                                              offset: Offset(1, 1),
                                              blurRadius: 3,
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          painting.type == "AI"
                                              ? "AI"
                                              : "Human",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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

              const SizedBox(height: 20),

              // result panel
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 22,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7E7C1),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFF3C2F17), width: 3),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.brown,
                      offset: Offset(3, 3),
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
                child: Text(
                  displayText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    height: 1.35,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  gameState.reset();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const Home()),
                  );
                },
                child: const Text("Play Again"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ZoomPaintingPage extends StatelessWidget {
  final Painting painting;

  const ZoomPaintingPage({super.key, required this.painting});

  @override
  Widget build(BuildContext context) {
    final Color labelColor = painting.type == "AI"
        ? Colors.redAccent
        : Colors.green.shade600;

    final String typeLabel = painting.type == "AI"
        ? "AI-Generated"
        : "Human-Made";

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: InteractiveViewer(
                minScale: 0.5,
                maxScale: 4.0,
                child: Center(
                  child: Image.asset(
                    'assets/${painting.theme}-${painting.type}-${painting.number}.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
        
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              color: Colors.grey.shade900,
              child: Column(
                children: [
                  Text(
                    painting.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      height: 1.4,
                    ),
                  ),
        
                  const SizedBox(height: 16),
        
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 14,
                    ),
                    decoration: BoxDecoration(
                      color: labelColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      typeLabel,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
