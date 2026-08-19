import 'package:flutter/material.dart';

import 'buttons.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox({super.key, required this.controller,
  required this.onSave, required this.onCancel
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[200],
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //add a new task
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new task",
              ),
            ),

            //buttons
            Row(
              children: [
                //save button
                Buttons(text: "Save", onPressed: onSave),




                SizedBox(width: 50,),




                //cancel button
                Buttons(text: "Cancel", onPressed: onCancel),



              ],
            )
          ],
        ),
      ),
    );
  }
}
