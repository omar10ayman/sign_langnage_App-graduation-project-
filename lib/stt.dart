import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_speech/flutter_speech.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:button/refersh.dart';
// import 'package:button/Map.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SpeechToText extends StatefulWidget {
  static const routeName = '/drw';
  const SpeechToText({Key? key}) : super(key: key);

  @override
  _SpeechToTextState createState() => _SpeechToTextState();
}

const languages = [
  Language('Arabic', 'ar_EG'),
  Language('English', 'en_US'),
  Language('Francais', 'fr_FR'),
  Language('Español', 'es_ES'),
];

class Language {
  final String name;
  final String code;

  const Language(this.name, this.code);
}

class _SpeechToTextState extends State<SpeechToText> {
  late SpeechRecognition _speech;

  bool _speechRecognitionAvailable = false;
  bool _isListening = false;

  String transcription = '';
  String asset = 'assets/gifs/Welcome.gif';
  var color = Colors.grey[300];

  // String _currentLocale = 'en_US';
  Language selectedLang = languages.first;

  @override
  initState() {
    super.initState();

    activateSpeechRecognizer();
  }

  void choose() {
    transcription == 'صباح الخير' ||
            transcription == 'صباح النور' ||
            transcription == 'good morning'
        ? asset = 'assets/gifs/Good morning.gif'
        : transcription == 'كله تمام' || transcription == 'fine'
            ? asset = 'assets/gifs/Fine.gif'
            : transcription == 'what\'s your name' ||
                    transcription == 'what is your name' ||
                    transcription == 'اسمك ايه'
                ? asset = 'assets/gifs/Whats your name.gif'
                : transcription == 'cheese fries' ||
                        transcription == 'بطاطس بالجبنه'
                    ? asset = 'assets/gifs/Cheese fries.gif'
                    : transcription == 'تاكل' ||
                            transcription == 'do you want to eat'
                        ? asset = 'assets/gifs/Wanna eat.gif'
                        : transcription == 'goodbye' ||
                                transcription == 'bye' ||
                                transcription == 'مع السلامه'
                            ? asset = 'assets/gifs/Goodbye.gif'
                            : transcription == 'عليكم السلام'
                                ? asset = 'assets/gifs/عليكم السلام.gif'
                                : transcription == 'رايح ماتش كوره'
                                    ? asset = 'assets/gifs/رايح ماتش كورة.gif'
                                    : transcription == 'سلام'
                                        ? asset =
                                            'assets/gifs/See you later.gif'
                                        : transcription == 'فاضي النهارده'
                                            ? asset =
                                                'assets/gifs/فاضي النهاردة.gif'
                                            : transcription == 'ربنا معك'
                                                ? asset =
                                                    'assets/gifs/ربنا معاك.gif'
                                                : transcription == 'الحمدلله' ||
                                                        transcription ==
                                                            'thank God'
                                                    ? asset =
                                                        'assets/gifs/الحمدلله.gif'
                                                    : transcription == 'animal'
                                                        ? asset =
                                                            'assets/gifs/Animal.gif'
                                                        : transcription ==
                                                                'anything'
                                                            ? asset =
                                                                'assets/gifs/Anything.gif'
                                                            : transcription ==
                                                                    'banana'
                                                                ? asset =
                                                                    'assets/gifs/Banana.gif'
                                                                : transcription ==
                                                                        'bird'
                                                                    ? asset =
                                                                        'assets/gifs/Bird.gif'
                                                                    : transcription ==
                                                                            'biscuit'
                                                                        ? asset =
                                                                            'assets/gifs/Biscuit.gif'
                                                                        : transcription == 'blanket' ||
                                                                                transcription == 'بطانيه'
                                                                            ? asset = 'assets/gifs/Blanket.gif'
                                                                            : transcription == 'boy'
                                                                                ? asset = 'assets/gifs/Boy.gif'
                                                                                : transcription == 'bread'
                                                                                    ? asset = 'assets/gifs/Bread.gif'
                                                                                    : transcription == 'breakfast'
                                                                                        ? asset = 'assets/gifs/Breakfast.gif'
                                                                                        : transcription == 'brother'
                                                                                            ? asset = 'assets/gifs/Brother.gif'
                                                                                            : transcription == 'burger'
                                                                                                ? asset = 'assets/gifs/Burger.gif'
                                                                                                : transcription == 'camera'
                                                                                                    ? asset = 'assets/gifs/Camera.gif'
                                                                                                    : transcription == 'cat'
                                                                                                        ? asset = 'assets/gifs/Cat.gif'
                                                                                                        : transcription == 'cheese' || transcription == 'جبنه'
                                                                                                            ? asset = 'assets/gifs/Cheese.gif'
                                                                                                            : transcription == 'chicken'
                                                                                                                ? asset = 'assets/gifs/Chicken.gif'
                                                                                                                : transcription == 'child'
                                                                                                                    ? asset = 'assets/gifs/Child.gif'
                                                                                                                    : transcription == 'chocolate'
                                                                                                                        ? asset = 'assets/gifs/Chocolate.gif'
                                                                                                                        : transcription == 'close' || transcription == 'اقفل'
                                                                                                                            ? asset = 'assets/gifs/Close.gif'
                                                                                                                            : transcription == 'cup' || transcription == 'Cup'
                                                                                                                                ? asset = 'assets/gifs/Cup.gif'
                                                                                                                                : transcription == 'daughter'
                                                                                                                                    ? asset = 'assets/gifs/Daughter.gif'
                                                                                                                                    : transcription == 'dinner'
                                                                                                                                        ? asset = 'assets/gifs/Dinner.gif'
                                                                                                                                        : transcription == 'dog' || transcription == 'كلب'
                                                                                                                                            ? asset = 'assets/gifs/Dog.gif'
                                                                                                                                            : transcription == 'drink' || transcription == 'drinking'
                                                                                                                                                ? asset = 'assets/gifs/Drinking.gif'
                                                                                                                                                : transcription == 'duck' || transcription == 'بطه'
                                                                                                                                                    ? asset = 'assets/gifs/Duck.gif'
                                                                                                                                                    : transcription == 'eat' || transcription == 'eating' || transcription == 'اكل'
                                                                                                                                                        ? asset = 'assets/gifs/Eating.gif'
                                                                                                                                                        : transcription == 'egg' || transcription == 'eggs' || transcription == 'بيض'
                                                                                                                                                            ? asset = 'assets/gifs/Eggs.gif'
                                                                                                                                                            : transcription == 'family' || transcription == 'عيلة'
                                                                                                                                                                ? asset = 'assets/gifs/Family.gif'
                                                                                                                                                                : transcription == 'father' || transcription == 'اب' || transcription == 'بابا'
                                                                                                                                                                    ? asset = 'assets/gifs/Father.gif'
                                                                                                                                                                    : transcription == 'fish' || transcription == 'سمك' || transcription == 'سمكه'
                                                                                                                                                                        ? asset = 'assets/gifs/Fish.gif'
                                                                                                                                                                        : transcription == 'fork' || transcription == 'شوكه'
                                                                                                                                                                            ? asset = 'assets/gifs/Fork.gif'
                                                                                                                                                                            : transcription == 'fruit' || transcription == 'فاكهه'
                                                                                                                                                                                ? asset = 'assets/gifs/Fruit.gif'
                                                                                                                                                                                : transcription == 'gift' || transcription == 'هديه'
                                                                                                                                                                                    ? asset = 'assets/gifs/Gift.gif'
                                                                                                                                                                                    : transcription == 'girls' || transcription == 'بنت' || transcription == 'girl'
                                                                                                                                                                                        ? asset = 'assets/gifs/Girl.gif'
                                                                                                                                                                                        : transcription == 'grandma'
                                                                                                                                                                                            ? asset = 'assets/gifs/Grandma.gif'
                                                                                                                                                                                            : transcription == 'Grandpa'
                                                                                                                                                                                                ? asset = 'assets/gifs/Grandpa.gif'
                                                                                                                                                                                                : transcription == 'gum'
                                                                                                                                                                                                    ? asset = 'assets/gifs/Gum.gif'
                                                                                                                                                                                                    : transcription == 'he' || transcription == 'هو'
                                                                                                                                                                                                        ? asset = 'assets/gifs/He.gif'
                                                                                                                                                                                                        : transcription == 'how are you' || transcription == 'ازيك'
                                                                                                                                                                                                            ? asset = 'assets/gifs/How are you.gif'
                                                                                                                                                                                                            : transcription == 'hungry' || transcription == 'جعان'
                                                                                                                                                                                                                ? asset = 'assets/gifs/Hungry.gif'
                                                                                                                                                                                                                : transcription == 'I love you' || transcription == 'باحبك' || transcription == 'بحبك'
                                                                                                                                                                                                                    ? asset = 'assets/gifs/I love you.gif'
                                                                                                                                                                                                                    : transcription == 'jam'
                                                                                                                                                                                                                        ? asset = 'assets/gifs/Jam.gif'
                                                                                                                                                                                                                        : transcription == 'juice' || transcription == 'عصير'
                                                                                                                                                                                                                            ? asset = 'assets/gifs/Juice.gif'
                                                                                                                                                                                                                            : transcription == 'knife' || transcription == 'سكينه'
                                                                                                                                                                                                                                ? asset = 'assets/gifs/Knife.gif'
                                                                                                                                                                                                                                : transcription == 'lunch' || transcription == 'غدا'
                                                                                                                                                                                                                                    ? asset = 'assets/gifs/Lunch.gif'
                                                                                                                                                                                                                                    : transcription == 'man' || transcription == 'راجل'
                                                                                                                                                                                                                                        ? asset = 'assets/gifs/Man.gif'
                                                                                                                                                                                                                                        : transcription == 'meat' || transcription == 'لحمه'
                                                                                                                                                                                                                                            ? asset = 'assets/gifs/Meat.gif'
                                                                                                                                                                                                                                            : transcription == 'milk' || transcription == 'حليب' || transcription == 'لبن'
                                                                                                                                                                                                                                                ? asset = 'assets/gifs/Milk.gif'
                                                                                                                                                                                                                                                : transcription == 'money' || transcription == 'فلوس'
                                                                                                                                                                                                                                                    ? asset = 'assets/gifs/Money.gif'
                                                                                                                                                                                                                                                    : transcription == 'moon' || transcription == 'قمر'
                                                                                                                                                                                                                                                        ? asset = 'assets/gifs/Moon.gif'
                                                                                                                                                                                                                                                        : transcription == 'mother' || transcription == 'ام' || transcription == 'ماما'
                                                                                                                                                                                                                                                            ? asset = 'assets/gifs/Mother.gif'
                                                                                                                                                                                                                                                            : transcription == 'no' || transcription == 'لا'
                                                                                                                                                                                                                                                                ? asset = 'assets/gifs/No.gif'
                                                                                                                                                                                                                                                                : transcription == 'open' || transcription == 'افتح'
                                                                                                                                                                                                                                                                    ? asset = 'assets/gifs/Open.gif'
                                                                                                                                                                                                                                                                    : transcription == 'parents'
                                                                                                                                                                                                                                                                        ? asset = 'assets/gifs/Parents.gif'
                                                                                                                                                                                                                                                                        : transcription == 'pizza' || transcription == 'بيتزا'
                                                                                                                                                                                                                                                                            ? asset = 'assets/gifs/Pizza.gif'
                                                                                                                                                                                                                                                                            : transcription == 'plate'
                                                                                                                                                                                                                                                                                ? asset = 'assets/gifs/Plate.gif'
                                                                                                                                                                                                                                                                                : transcription == 'potato' || transcription == 'بطاطس'
                                                                                                                                                                                                                                                                                    ? asset = 'assets/gifs/Potato.gif'
                                                                                                                                                                                                                                                                                    : transcription == 'rabbit' || transcription == 'rabbits'
                                                                                                                                                                                                                                                                                        ? asset = 'assets/gifs/Rabbit.gif'
                                                                                                                                                                                                                                                                                        : transcription == 'restaurant' || transcription == 'مطعم'
                                                                                                                                                                                                                                                                                            ? asset = 'assets/gifs/Restaurant.gif'
                                                                                                                                                                                                                                                                                            : transcription == 'salt' || transcription == 'ملح'
                                                                                                                                                                                                                                                                                                ? asset = 'assets/gifs/Salt.gif'
                                                                                                                                                                                                                                                                                                : transcription == 'sandwich' || transcription == 'ساندوتش'
                                                                                                                                                                                                                                                                                                    ? asset = 'assets/gifs/Sandwich.gif'
                                                                                                                                                                                                                                                                                                    : transcription == 'school' || transcription == 'مدرسه'
                                                                                                                                                                                                                                                                                                        ? asset = 'assets/gifs/School.gif'
                                                                                                                                                                                                                                                                                                        : transcription == 'sick' || transcription == 'عيان'
                                                                                                                                                                                                                                                                                                            ? asset = 'assets/gifs/Sick.gif'
                                                                                                                                                                                                                                                                                                            : transcription == 'sister' || transcription == 'اخت'
                                                                                                                                                                                                                                                                                                                ? asset = 'assets/gifs/Sister.gif'
                                                                                                                                                                                                                                                                                                                : transcription == 'smell'
                                                                                                                                                                                                                                                                                                                    ? asset = 'assets/gifs/Smell.gif'
                                                                                                                                                                                                                                                                                                                    : transcription == 'son' || transcription == 'ابن'
                                                                                                                                                                                                                                                                                                                        ? asset = 'assets/gifs/Son.gif'
                                                                                                                                                                                                                                                                                                                        : transcription == 'spaghetti'
                                                                                                                                                                                                                                                                                                                            ? asset = 'assets/gifs/Spaghetti.gif'
                                                                                                                                                                                                                                                                                                                            : transcription == 'spoon' || transcription == 'معلقه'
                                                                                                                                                                                                                                                                                                                                ? asset = 'assets/gifs/Spoon.gif'
                                                                                                                                                                                                                                                                                                                                : transcription == 'tasty' || transcription == 'delicious' || transcription == 'لذيذ'
                                                                                                                                                                                                                                                                                                                                    ? asset = 'assets/gifs/Tasty.gif'
                                                                                                                                                                                                                                                                                                                                    : transcription == 'toilet' || transcription == 'حمام'
                                                                                                                                                                                                                                                                                                                                        ? asset = 'assets/gifs/Toilet.gif'
                                                                                                                                                                                                                                                                                                                                        : transcription == 'tomorrow' || transcription == 'بكره'
                                                                                                                                                                                                                                                                                                                                            ? asset = 'assets/gifs/Tomorrow.gif'
                                                                                                                                                                                                                                                                                                                                            : transcription == 'trip' || transcription == 'رحله'
                                                                                                                                                                                                                                                                                                                                                ? asset = 'assets/gifs/Trip.gif'
                                                                                                                                                                                                                                                                                                                                                : transcription == 'uncle'
                                                                                                                                                                                                                                                                                                                                                    ? asset = 'assets/gifs/Uncle.gif'
                                                                                                                                                                                                                                                                                                                                                    : transcription == 'us'
                                                                                                                                                                                                                                                                                                                                                        ? asset = 'assets/gifs/Us.gif'
                                                                                                                                                                                                                                                                                                                                                        : transcription == 'water' || transcription == 'مياه' || transcription == 'ماء'
                                                                                                                                                                                                                                                                                                                                                            ? asset = 'assets/gifs/Water.gif'
                                                                                                                                                                                                                                                                                                                                                            : transcription == 'woman'
                                                                                                                                                                                                                                                                                                                                                                ? asset = 'assets/gifs/Woman.gif'
                                                                                                                                                                                                                                                                                                                                                                : transcription == 'year' || transcription == 'سنه'
                                                                                                                                                                                                                                                                                                                                                                    ? asset = 'assets/gifs/Year.gif'
                                                                                                                                                                                                                                                                                                                                                                    : transcription == 'yes' || transcription == 'ايوه'
                                                                                                                                                                                                                                                                                                                                                                        ? asset = 'assets/gifs/Yes.gif'
                                                                                                                                                                                                                                                                                                                                                                        : transcription == 'you' || transcription == 'انت'
                                                                                                                                                                                                                                                                                                                                                                            ? asset = 'assets/gifs/You.gif'
                                                                                                                                                                                                                                                                                                                                                                            : asset = 'assets/gifs/Null.png';
    // asset = gifs[transcription];
  }

  void activateSpeechRecognizer() {
    print('_MyAppState.activateSpeechRecognizer... ');
    _speech = SpeechRecognition();
    _speech.setAvailabilityHandler(onSpeechAvailability);
    _speech.setRecognitionStartedHandler(onRecognitionStarted);
    _speech.setRecognitionResultHandler(onRecognitionResult);
    _speech.setRecognitionCompleteHandler(onRecognitionComplete);
    _speech.setErrorHandler(errorHandler);
    _speech.activate('ar_EG').then((res) {
      setState(() => _speechRecognitionAvailable = res);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var soundBars = const LoadingIndicator(
        indicatorType: Indicator.lineScalePulseOut,
        // ignore: prefer_const_literals_to_create_immutables
        colors: [
          Colors.grey,
          Colors.grey,
          Colors.grey,
          Colors.grey,
          Colors.grey
        ],
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        pathBackgroundColor: Color.fromRGBO(0, 0, 0, 0));
    return Scaffold(
      body: Stack(children: [
        // SizedBox(
        //   width: double.infinity,
        //   height: double.infinity,
        //   child: Image.asset("images/cover.png", fit: BoxFit.cover),
        // ),
        Positioned(
          child: Container(
            height: size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter, end: Alignment.bottomCenter,
                  // ignore: prefer_const_literals_to_create_immutables
                  colors: [Color(0xff2e3037), Color(0xff14161a)]),
            ),
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.only(top: 55, bottom: 10),
                    child: Text('Voice to sign language',
                        style: TextStyle(
                            fontFamily: 'gill',
                            color: Colors.white,
                            fontSize: 25)),
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // ....................image ................
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        child: Image.asset(
                          asset,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                          color: Colors.grey[50],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _isListening
                                ? Text('   Listening ... ',
                                    style: TextStyle(
                                        fontFamily: 'gill',
                                        color: Color(0xffCE493D),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600))
                                : Container(),
                            Center(
                              child: Text(transcription,
                                  style: TextStyle(
                                    fontFamily: 'gill',
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      _isListening
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                // ignore: sized_box_for_whitespace
                                child: Container(
                                  height: 70,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      soundBars,
                                      soundBars,
                                      soundBars,
                                      soundBars,
                                      soundBars,
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            margin: EdgeInsets.only(top: 60),
            width: size.width,
            height: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                color: Color(0xff2e3037)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            // ignore: unnecessary_new
                            new MaterialPageRoute(
                                builder: (BuildContext context) {
                          return Refersh();
                        }));
                        Navigator.of(context).pushReplacement(
                            // ignore: unnecessary_new
                            new MaterialPageRoute(
                                builder: (BuildContext context) {
                          return SpeechToText();
                        }));
                      },
                      icon: Image.asset('images/redo.png')),
                  SizedBox(width: 100),
                  PopupMenuButton<Language>(
                    icon: Image.asset('images/language.png'),
                    onSelected: _selectLangHandler,
                    itemBuilder: (BuildContext context) =>
                        _buildLanguagesWidgets,
                  ),
                ]),
          ),
        ),
        Positioned(
          bottom: 45,
          left: (size.width - 60) / 2,
          child: GestureDetector(
            onLongPress: _speechRecognitionAvailable && !_isListening
                ? () {
                    setState(() {
                      start();
                    });
                  }
                : null,
            onLongPressEnd: (LongPressEndDetails details) {
              Timer(Duration(milliseconds: 1300), () {
                cancel();
                choose();
                setState(() {});
                selectedLang.code == 'ar_EG'
                    ? color = Colors.grey[300]
                    : color = Colors.white;
                if (asset == 'assets/gifs/Null.png') {
                  color = Colors.grey[300];
                }
              });
            },
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                color: Color.fromARGB(255, 169, 36, 27),
                // gradient: LinearGradient(
                //     begin: Alignment.bottomCenter,
                //     end: Alignment.topCenter,
                //     colors: const [
                //       Color.fromARGB(255, 191, 73, 34),
                //       Color(0xff16298c)
                //     ])
              ),
              child: AvatarGlow(
                  animate: _isListening,
                  glowColor: Color.fromARGB(255, 131, 12, 32),
                  endRadius: 60,
                  duration: Duration(milliseconds: 2000),
                  repeatPauseDuration: Duration(milliseconds: 100),
                  repeat: _isListening,
                  child: Image.asset(
                    'images/mic.png',
                    height: 40,
                  )),
            ),
          ),
        ),
      ]),
    );
  }

  List<CheckedPopupMenuItem<Language>> get _buildLanguagesWidgets => languages
      .map((l) => CheckedPopupMenuItem<Language>(
            value: l,
            checked: selectedLang == l,
            child: Text(l.name),
          ))
      .toList();

  void _selectLangHandler(Language lang) {
    setState(() => selectedLang = lang);
  }

  void start() => _speech.activate(selectedLang.code).then((_) {
        return _speech.listen().then((result) {
          print('_MyAppState.start => result $result');
          setState(() => _isListening = result);
        });
      });

  void cancel() =>
      _speech.cancel().then((_) => setState(() => _isListening = false));

  void onSpeechAvailability(bool result) =>
      setState(() => _speechRecognitionAvailable = result);

  void onCurrentLocale(String locale) {
    print('_MyAppState.onCurrentLocale... $locale');
    setState(
        () => selectedLang = languages.firstWhere((l) => l.code == locale));
  }

  void onRecognitionStarted() {
    setState(() => _isListening = true);
  }

  void onRecognitionResult(String text) {
    print('_MyAppState.onRecognitionResult... $text');
    setState(() {
      transcription = text;
    });
  }

  void onRecognitionComplete(String text) {
    print('_MyAppState.onRecognitionComplete... $text');
    setState(() {
      _isListening = false;
    });
  }

  void errorHandler() => activateSpeechRecognizer();

  @override
  void dispose() {
    super.dispose();
    // _controller.dispose();
  }
}
