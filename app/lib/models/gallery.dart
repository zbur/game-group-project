import 'painting.dart';
import 'descriptions.dart';
import 'package:flutter/material.dart';

class Gallery {
  List<Painting> gallery = [];

  List<String> themes = ['Despair', 'Fantasy', 'Love', 'Nature', 'Religion', 'War'];
  List<Color> themeColors = [
    Color.fromARGB(255, 80, 105, 141), 
    Color.fromARGB(255, 141, 141, 59), 
    Color.fromARGB(255, 225, 117, 225), 
    Color.fromARGB(255, 84, 141, 97), 
    Color.fromARGB(255, 255, 255, 255),
    Color.fromARGB(255, 141, 59, 59),
    Color.fromARGB(150, 80, 105, 141), 
    Color.fromARGB(150, 141, 141, 59), 
    Color.fromARGB(150, 225, 117, 225), 
    Color.fromARGB(150, 84, 141, 97), 
    Color.fromARGB(150, 255, 255, 255),
    Color.fromARGB(150, 141, 59, 59)
  ];
void markThemeCompleted(String theme) {
  if (!completedThemes.contains(theme)) {
    completedThemes.add(theme);
  }
}

bool allThemesCompleted() {
  return completedThemes.length == 6;
}
  void add(String theme, String type, int number) {
    if(type == "AI") {
      gallery.add(Painting(theme, type, number.toString(), descriptionsAI[themes.indexOf(theme)][number-1]));
    } else {
      gallery.add(Painting(theme, type, number.toString(), descriptionsReal[themes.indexOf(theme)][number-1]));
    }
  }

  List<Painting> returnFiltered(String theme, String type) {
    var filteredGallery = gallery.where((item) => item.theme == theme && item.type == type).toList();
    return filteredGallery;
  }

  Painting returnPainting(String theme, String type, int number) {
    return Painting(theme, type, number.toString(), descriptionsAI[themes.indexOf(theme)][number-1]);
  }
}