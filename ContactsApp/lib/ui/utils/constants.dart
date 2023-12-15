import 'dart:math';
import 'dart:ui';


const String baseUrl = "http://192.168.1.104:8000/api/";

/// get random color
Color getRandomColor() {
  Random random = Random();
  return Color.fromRGBO(
    random.nextInt(255),
    random.nextInt(255),
    random.nextInt(255),
    1.0, // Set alpha to 1.0 for fully opaque color
  );
}


