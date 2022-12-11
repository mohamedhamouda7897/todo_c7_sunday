import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/tasks.dart';

CollectionReference<TaskData> getTasksCollection() {
  return FirebaseFirestore.instance.collection('tasks').withConverter<TaskData>(
      fromFirestore: (snapshot, options) => TaskData.fromJson(snapshot.data()!),
      toFirestore: (task, option) => task.toJson());
}

Future<void> addTaskToFirebaseFirestore(TaskData taskData) {
  var collection = getTasksCollection();
  var docRef = collection.doc();
  taskData.id = docRef.id;
  return docRef.set(taskData);
}

Stream<QuerySnapshot<TaskData>> getTasksFromFirestore(DateTime dateTime) {
  return getTasksCollection()
      .where('date',
          isEqualTo: DateUtils.dateOnly(dateTime).microsecondsSinceEpoch)
      .snapshots();
}

Future<void> deleteTaskFromFirestore(String id) {
  return getTasksCollection().doc(id).delete();
}
