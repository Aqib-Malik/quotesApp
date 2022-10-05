// ignore_for_file: file_names

class QuoteByCategories {
  static var categoriesAndQuotes = [
    [
      'Quote 1',
      'Quote 2',
      'Quote 3',
      'Quote 4',
      'Quote 5',
      'Quote 6',
      'Quote 7',
    ],
    [
      'Quote 1',
      'Quote 2',
      'Quote 3',
      'Quote 4',
      'Quote 5',
      'Quote 6',
      'Quote 7',
    ],
    [
      'Quote 1',
      'Quote 2',
      'Quote 3',
      'Quote 4',
      'Quote 5',
      'Quote 6',
      'Quote 7',
    ],
    [
      'Quote 1',
      'Quote 2',
      'Quote 3',
      'Quote 4',
      'Quote 5',
      'Quote 6',
      'Quote 7',
    ],
    [
      'Quote 1',
      'Quote 2',
      'Quote 3',
      'Quote 4',
      'Quote 5',
      'Quote 6',
      'Quote 7',
    ],
    [
      'Quote 1',
      'Quote 2',
      'Quote 3',
      'Quote 4',
      'Quote 5',
      'Quote 6',
      'Quote 7',
    ],
    [
      'Quote 1',
      'Quote 2',
      'Quote 3',
      'Quote 4',
      'Quote 5',
      'Quote 6',
      'Quote 7',
    ],
  ];
  static var isCategoriesAndQuotesFavourite = [
    [
      false,
      false,
      false,
      false,
      false,
      false,
      false,
    ],
    [
      false,
      false,
      false,
      false,
      false,
      false,
      false,
    ],
    [
      false,
      false,
      false,
      false,
      false,
      false,
      false,
    ],
    [
      false,
      false,
      false,
      false,
      false,
      false,
      false,
    ],
    [
      false,
      false,
      false,
      false,
      false,
      false,
      false,
    ],
    [
      false,
      false,
      false,
      false,
      false,
      false,
      false,
    ],
    [
      false,
      false,
      false,
      false,
      false,
      false,
      false,
    ],
  ];
  List<String> illustrationBG = [
    'assets/Artwork/Life hardships.jpg',
    'assets/Artwork/Heartbreak.png',
    'assets/Artwork/Life goals.jpg',
    'assets/Artwork/Spirituality.jpg',
    'assets/Artwork/Inspiring storie.png',
    'assets/Artwork/Parenthood.JPG',
    'assets/Artwork/Learning Difficulty.jpg',
  ];
  List<String> imageCaption = [
    "Recovering from life hardship",
    "Recovering from a heartbreak",
    "Self-improvement and reaching goals",
    "Spirituality experience",
    "Inspirational stories",
    "Parenthood challenges",
    "Learning difficulties",
  ];
  List quotes = [
    'Quote 1',
    'Quote 2',
    'Quote 3',
    'Quote 4',
    'Quote 5',
    'Quote 6',
    'Quote 7',
  ];
  QuoteByCategories() {
    // Illustration objIllustration = Illustration(illustrationBG, imageCaption);
    // var ascList = List.generate(illustrationBG.length, (i) => List.generate(quotes.length, (j) => i * 4 + j));
    // isCategoriesAndQuotesFavourite   = List.generate(illustrationBG.length, (i) => List.generate(quotes.length, (j) => false));
    // categoriesAndQuotes  = List.generate(illustrationBG.length, (i) => List.generate(quotes.length, (j) => i * 4 + j));
    // categoriesAndQuotes = List.generate(illustrationBG.length, (i) => quotes);
    // this.categoriesAndQuotes = List.generate(objIllustration.bgIllustrations.length, (i) => List.generate(quotes.length, (j) => "Quote "+j.toString()));
    //
    // //
    // for (int i = 0 ; i < objIllustration.bgIllustrations.length;i++){
    //   //getQuotesFromDB or Json
    //   for (int j = 0 ; j < quotes.length;j++){
    //     categoriesAndQuotes[i][j] = quotes[j];
    //     // print("sadasdasd: "+quotes[j]);
    //   }
    // }
    // print(categoriesAndQuotes);
  }
  static makeItFavQuote(i, j, x) {
    isCategoriesAndQuotesFavourite[i][j] = x;
  }
}

class Category {
  String? name;
  int? id;

  Category({this.name, this.id});
}
