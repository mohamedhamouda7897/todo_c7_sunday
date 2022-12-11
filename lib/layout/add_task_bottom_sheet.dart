import 'package:flutter/material.dart';
import 'package:todo_c7_sun/models/tasks.dart';
import 'package:todo_c7_sun/shared/styles/colors.dart';

import '../shared/components/components.dart';
import '../shared/network/local/firebse_utils.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var titleController = TextEditingController();

  var descriptionController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Add new Task',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(color: colorBlack, fontSize: 30),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      validator: (text) {
                        if (text == '') {
                          return 'Please Enter Title';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          label: Text('title'),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: primaryColor)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: primaryColor))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: descriptionController,
                      validator: (text) {
                        if (text == '') {
                          return 'Please Enter Description';
                        }
                        return null;
                      },
                      maxLines: 3,
                      decoration: InputDecoration(
                          label: Text('Description'),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: primaryColor)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: primaryColor))),
                    )
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            Text(
              'Select Date',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: colorBlack),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                ShowPicker(context);
              },
              child: Text(
                '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    print('======================');
                    print(selectedDate);
                    print(DateUtils.dateOnly(selectedDate));
                    print('======================');
                    TaskData task = TaskData(
                        description: descriptionController.text,
                        title: titleController.text,
                        id: 'hamouda',
                        date: DateUtils.dateOnly(selectedDate)
                            .microsecondsSinceEpoch);
                    showLoading(context, 'Loading...');
                    showMessage(
                        context,
                        " Are you sure Add Task",
                        "Yes",
                        () {
                          addTaskToFirebaseFirestore(task);
                          hideLoading(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        negBtn: 'Cancel',
                        negAction: () {
                          hideLoading(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        });
                  }
                },
                child: Text('Add Task'))
          ],
        ),
      ),
    );
  }

  void ShowPicker(BuildContext context) async {
    DateTime? chosenDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(days: 365),
      ),
    );
    if (chosenDate == null) return;
    selectedDate = chosenDate;
    setState(() {});
  }
}
