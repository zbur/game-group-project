import 'painting.dart';
import 'descriptions.dart';
import 'package:flutter/material.dart';

class Gallery {
  List<Painting> gallery = [];

  List<String> themes = ['Despair', 'Fantasy', 'Love', 'Nature', 'Religion', 'War'];
  int _getThemeIndex(String theme) {
    switch (theme) {
      case 'Despair': return 0;
      case 'Fantasy': return 1;
      case 'Love': return 2;
      case 'Nature': return 3;
      case 'Religion': return 4;
      case 'War': return 5;
      default: return 0;
    }
  }

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

  void add(String theme, String type, int number) {
    int themeIndex = _getThemeIndex(theme);
    String description;
    
    if (type == "AI") {
      description = descriptionsAI[themeIndex][number - 1];
    } else {
      description = descriptionsReal[themeIndex][number - 1];
    }
    
    gallery.add(Painting(theme, type, number.toString(), description));
  }

  List<Painting> returnFiltered(String theme, String type) {
    var filteredGallery = gallery.where((item) => item.theme == theme && item.type == type).toList();
    return filteredGallery;
  }

  Painting returnPainting(String theme, String type, int number) {
    int themeIndex = _getThemeIndex(theme);
    String description;
    
    if (type == "AI") {
      description = descriptionsAI[themeIndex][number - 1];
    } else {
      description = descriptionsReal[themeIndex][number - 1];
    }
    
    return Painting(theme, type, number.toString(), description);
  }
}