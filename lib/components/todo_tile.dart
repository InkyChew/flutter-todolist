import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../models/task.dart';

class TodoTile extends StatelessWidget {

  final Task task;
  final Function(bool?)? onChange;
  final Function(BuildContext)? onDelete;

  const TodoTile({super.key, required this.task, required this.onChange, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: onDelete,
            foregroundColor: Colors.white,
            backgroundColor: Theme.of(context).colorScheme.error,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ]
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
          borderRadius: BorderRadius.circular(12)
        ),
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          children: [
            Checkbox(
              value: task.completed,
              onChanged: onChange,
              activeColor: Theme.of(context).colorScheme.inverseSurface
            ),
            Text(
              task.name,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                decoration: task.completed ? TextDecoration.lineThrough : TextDecoration.none
              )
            ),
          ]
        ),
      ),
    );
  }
}