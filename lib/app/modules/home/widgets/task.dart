import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_provider/app/models/tasks_model.dart';

class Task extends StatelessWidget {
  final TasksModel model;
  final dateFormat = DateFormat('dd/MM/y');
  Task({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.grey),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: IntrinsicHeight(
        child: ListTile(
          contentPadding: const EdgeInsets.all(8),
          leading: Checkbox(
            value: model.finished,
            onChanged: (v) {},
          ),
          title: Text(
            model.description,
            style: TextStyle(
                decoration: model.finished ? TextDecoration.lineThrough : null),
          ),
          subtitle: Text(
            dateFormat.format(model.dateTime),
            style: TextStyle(
                decoration: model.finished ? TextDecoration.lineThrough : null),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(width: 1)),
        ),
      ),
    );
  }
}
