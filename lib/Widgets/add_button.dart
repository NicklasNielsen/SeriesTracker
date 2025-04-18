import 'package:flutter/material.dart';


class AddButton extends StatelessWidget {
  const AddButton({required this.onPressed, required this.text, super.key});

  final GestureTapCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) => RawMaterialButton(
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