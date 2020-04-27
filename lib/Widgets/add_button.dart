import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class AddButton extends StatelessWidget {
  AddButton({@required this.onPressed, @required this.text});

  final GestureTapCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor:  Colors.deepOrange,
      splashColor: Colors.orange,
      onPressed: onPressed,
      shape: StadiumBorder(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 20.0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.add),
            SizedBox(width: 3.0,),
            Text(text, style: TextStyle(color: Colors.white),),
          ]
        )
      ),
    );
  }
}