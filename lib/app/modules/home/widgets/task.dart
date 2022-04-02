import 'package:flutter/material.dart';

class Task extends StatelessWidget {
  const Task({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.grey),
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: 5),
      child: IntrinsicHeight(
        child: ListTile(
          contentPadding: EdgeInsets.all(8),
          leading: Checkbox(
            value: true,
            onChanged: (v) {},
          ),
          title: Text(
            'Descrição',
            style:
                TextStyle(decoration: true ? TextDecoration.lineThrough : null),
          ),
          subtitle: Text(
            '20/02/2022',
            style:
                TextStyle(decoration: true ? TextDecoration.lineThrough : null),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(width: 1)),
        ),
      ),
    );
  }
}
