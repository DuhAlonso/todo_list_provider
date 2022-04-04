class TasksModel {
  final int id;
  final String description;
  final DateTime dateTime;
  final bool finished;
  TasksModel({
    required this.id,
    required this.description,
    required this.dateTime,
    required this.finished,
  });

  factory TasksModel.loadFromBD(Map<String, dynamic> task) {
    return TasksModel(
      id: task['id'],
      description: task['description'],
      dateTime: DateTime.parse(task['id']),
      finished: task['finalizado'] == 1,
    );
  }
}
