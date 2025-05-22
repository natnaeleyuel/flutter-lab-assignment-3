import 'package:flutter/material.dart';

class AppColors {
  static List<Color> albumColors = [
    Colors.blue[100]!,
    Colors.green[100]!,
    Colors.orange[100]!,
    Colors.purple[100]!,
    Colors.red[100]!,
  ];

  static List<Color> photoColors = [
    Colors.lightBlue[50]!,
    Colors.lightGreen[50]!,
    Colors.amber[50]!,
    Colors.deepPurple[50]!,
    Colors.pink[50]!,
  ];

  static Color getAlbumColor(int index) {
    return albumColors[index % albumColors.length];
  }

  static Color getPhotoColor(int index) {
    return photoColors[index % photoColors.length];
  }
}