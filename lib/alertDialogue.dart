import 'package:flutter/material.dart';
import 'main.dart';
import 'moviePage.dart';

class CustomAlertDialogue extends StatefulWidget {
  final title;
  final content;
  CustomAlertDialogue({this.title, this.content});

  @override
  _CustomAlertDialogueState createState() => _CustomAlertDialogueState();
}

class _CustomAlertDialogueState extends State<CustomAlertDialogue> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      elevation: 10,
      title: Text(
        widget.title,
        style: TextStyle(fontSize: 25),
        textAlign: TextAlign.center,
      ),
      content: Text(
        widget.content,
        style: TextStyle(
          fontSize: 14,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.antiAlias,
          child: Container(
            height: 50,
            width: 100,
            child: InkWell(
              hoverColor: Colors.yellow,
              child: Center(child: Text('Home')),
              onTap: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return Home();
              })),
            ),
          ),
        ),
        Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.antiAlias,
          child: Container(
            height: 50,
            width: 180,
            child: InkWell(
              hoverColor: Colors.yellow,
              child: Center(child: Text('Play again')),
              onTap: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return MoviePage();
              })),
            ),
          ),
        ),
      ],
    );
  }
}
