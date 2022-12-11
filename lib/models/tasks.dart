class TaskData {
  String id;
  String title;
  String description;
  int date;
  bool isDone;

  TaskData(
      {this.id = "",
      required this.description,
      required this.title,
      required this.date,
      this.isDone = false});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "date": date,
      "isDone": isDone
    };
  }

  TaskData.fromJson(Map<String, dynamic> json)
      : this(
            id: json["id"],
            title: json["title"],
            description: json['description'],
            date: json['date'],
            isDone: json['isDone']);
}
