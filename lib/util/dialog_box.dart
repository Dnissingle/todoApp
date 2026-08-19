import 'package:flutter/material.dart';

import 'buttons.dart';

class DialogBox extends StatelessWidget {
  // Added explicit type to controller for code safety and autocomplete helper support
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[200],
      content: SizedBox( // Changed Container to SizedBox to optimize rendering memory
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // User input text field (handles both adding and editing)
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter task name...", // Generic hint works for both create and edit modes
              ),
            ),

            // Action buttons layout
            Row(
              // FIX: This evenly spaces or pushes buttons toward the end so they sit neatly
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Save button
                Buttons(text: "Save", onPressed: onSave),

                // Use an intentional smaller space or allow MainAxisAlignment to guide spacing
                const SizedBox(width: 12),

                // Cancel button
                Buttons(text: "Cancel", onPressed: onCancel),
              ],
            )
          ],
        ),
      ),
    );
  }
}
