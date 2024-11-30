import 'package:flutter/material.dart';

class CreateDialog extends StatelessWidget {
  
  final TextEditingController editingName = TextEditingController();
  final Function(String) onSave;
  final VoidCallback onCancel;

  CreateDialog({
    super.key,
    required this.onSave,
    required this.onCancel
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: editingName,
              decoration: const InputDecoration(
                hintText: "New Task..."
              ),
            ),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.onPrimary),
                    backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.primary)
                  ),
                  onPressed: () => onSave(editingName.text),
                  child: const Text("Save")
                ),
                ElevatedButton(
                  onPressed: onCancel,
                  child: const Text("Cancel")
                ),
              ]
            )
          ],
        ),
      ),
    );
  }
}