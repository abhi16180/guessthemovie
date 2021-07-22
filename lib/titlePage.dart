import 'package:flutter/material.dart';
import 'package:guessthemovie/alertDialogue.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'moviePage.dart';

class TitlePage extends StatefulWidget {
  final title;
  TitlePage({this.title});
  @override
  _TitlePageState createState() => _TitlePageState();
}

String movie = '';

class _TitlePageState extends State<TitlePage> {
  @override
  void initState() {
    super.initState();
    movie = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    double width = (MediaQuery.of(context).size).width;
    bool checkLetter(String letter) {
      bool flag = false;
      for (int i = 0; i < movieTitle.length; i++) {
        if (movieTitle[i] == letter) {
          hiddenTitle[i] = letter;
          flag = true;
        }
      }
      if (flag) {
        setState(() {
          movie = hiddenTitle.join().toString();
        });
      }
      return flag;
    }

    bool checkMovie(String mv) {
      if (movieTitle == mv) {
        setState(() {
          movie = mv;
        });
        return true;
      }
      return false;
    }

    void manageGuessedLetter(String guessedTitle) {
      print(guessedTitle);
      if (!checkLetter(guessedTitle)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Movie title does not contain ${controller.text}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            duration: Duration(milliseconds: 1000),
          ),
        );
      } else {
        if (hiddenTitle.join().toString() == movieTitle) {
          showDialog(
            context: context,
            builder: (context) {
              return CustomAlertDialogue(
                title: "Yey",
                content: "You guessed it right!!",
              );
            },
          );
        }
      }
    }

    void manageGuessedMovie() {
      if (checkMovie(controller.text)) {
        showDialog(
          context: context,
          builder: (context) {
            return CustomAlertDialogue(
              title: "Yey",
              content: "You guessed it right!!",
            );
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Please try again"),
          ),
        );
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 100,
            ),
            Center(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      AnimatedTextKit(
                        key: UniqueKey(),
                        animatedTexts: [
                          TypewriterAnimatedText(
                            movie,
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: width < 780 ? 25 : 60),
                            speed: Duration(milliseconds: 30),
                          ),
                        ],
                        totalRepeatCount: 1,
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 8, bottom: 8),
                          child: Text(moviePlot),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Theme(
                  data: new ThemeData(
                    primaryColor: Colors.yellow,
                  ),
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: controller,
                    cursorColor: Colors.yellow,
                    decoration: InputDecoration(
                      hintText: 'Type here',
                      labelText: 'Type letter or movie title',
                      labelStyle: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      ),
                      hintStyle: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.yellow),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    textInputAction: TextInputAction.go,
                    onSubmitted: (value) => value.length == 1
                        ? manageGuessedLetter(value)
                        : manageGuessedMovie(),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: width < 780
                    ? const EdgeInsets.only(top: 20, left: 50, right: 50)
                    : const EdgeInsets.only(
                        top: 80, left: 50, right: 50, bottom: 80),
                child: Wrap(
                  direction: width <= 780 ? Axis.vertical : Axis.horizontal,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          height: 50,
                          width: 180,
                          child: InkWell(
                              child: Center(
                                child: Text('Guess the letter'),
                              ),
                              onTap: () {
                                manageGuessedLetter(controller.text);
                              }),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          height: 50,
                          width: 180,
                          child: InkWell(
                            child: Center(
                              child: Text('Guess the movie'),
                            ),
                            onTap: () => manageGuessedMovie(),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          height: 50,
                          width: 180,
                          child: InkWell(
                            child: Center(child: Text('Another movie')),
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return MoviePage();
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return CustomAlertDialogue(
                  title: 'The movie was',
                  content: movieTitle,
                );
              });
        },
        backgroundColor: Colors.yellow,
        child: Icon(
          Icons.info_outline_rounded,
        ),
      ),
    );
  }
}
