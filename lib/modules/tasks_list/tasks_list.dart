import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_c7_sun/models/tasks.dart';
import 'package:todo_c7_sun/modules/tasks_list/task_item.dart';
import 'package:todo_c7_sun/shared/network/local/firebse_utils.dart';
import 'package:todo_c7_sun/shared/styles/colors.dart';

class TasksListTab extends StatefulWidget {
  @override
  State<TasksListTab> createState() => _TasksListTabState();
}

class _TasksListTabState extends State<TasksListTab> {
  DateTime CurrentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CalendarTimeline(
            initialDate: CurrentDate,
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) {
              CurrentDate = date;
              setState(() {});
            },
            leftMargin: 20,
            monthColor: colorBlack,
            dayColor: primaryColor,
            activeDayColor: Colors.white,
            activeBackgroundDayColor: primaryColor,
            dotsColor: Colors.white,
            selectableDayPredicate: (date) => true,
            locale: 'en_ISO',
          ),
          StreamBuilder<QuerySnapshot<TaskData>>(
              stream: getTasksFromFirestore(CurrentDate),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Something went wrong'));
                }

                var tasks =
                    snapshot.data?.docs.map((doc) => doc.data()).toList() ?? [];
                if (tasks.isEmpty) {
                  return Center(child: Text('No Data'));
                }
// 2022 , 11 , 11 , 09,12,25
                return Expanded(
                  child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return TaskItem(tasks[index]);
                      }),
                );
              })
        ],
      ),
    );
  }
}
