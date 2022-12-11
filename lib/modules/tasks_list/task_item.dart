import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_c7_sun/models/tasks.dart';
import 'package:todo_c7_sun/shared/network/local/firebse_utils.dart';
import 'package:todo_c7_sun/shared/styles/colors.dart';

class TaskItem extends StatelessWidget {
  TaskData task;

  TaskItem(this.task);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(motion: BehindMotion(), children: [
        SlidableAction(
          onPressed: (context) {
            deleteTaskFromFirestore(task.id);
          },
          backgroundColor: Colors.red,
          icon: Icons.delete,
          label: 'Delete',
        ),
        SlidableAction(
          onPressed: (context) {},
          backgroundColor: Colors.blue,
          icon: Icons.edit,
          label: 'Edit',
        )
      ]),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 4,
              color: primaryColor,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(task.description)
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Icon(
                  Icons.done,
                  size: 30,
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }
}
