// ignore_for_file: file_names

class Illustration {
  final List<dynamic> bgIllustrations;
  final List<dynamic> bgTitle;
  static List categories = [
    "Recovering from life hardship",
    "Recovering from a heartbreak",
    "Self-improvement and reaching goals",
    "Spirituality experience",
    "Inspirational stories",
    "Parenthood challenges",
    "Learning difficulties",
  ];
  static List<dynamic> images = [
    'assets/Artwork/Life hardships.JPG',
    'assets/Artwork/Heartbreak.png',
    'assets/Artwork/Life goals.jpg',
    'assets/Artwork/Spirituality.jpg',
    'assets/Artwork/Inspiring storie.png',
    'assets/Artwork/Parenthood.JPG',
    'assets/Artwork/Learning Difficulty.jpg',
  ];
  Illustration(this.bgIllustrations, this.bgTitle);
}
