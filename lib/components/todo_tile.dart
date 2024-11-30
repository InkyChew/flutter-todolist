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
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: onDelete,
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Colors.white,
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
          child: Row(
            children: [
              Checkbox(
                value: task.completed,
                onChanged: onChange,
                activeColor: Theme.of(context).colorScheme.inverseSurface
              ),
              Text(
                task.name,
                style: TextStyle(decoration: task.completed ? TextDecoration.lineThrough : TextDecoration.none)
              ),
            ]
          ),
        ),
      ),
    );
  }
}