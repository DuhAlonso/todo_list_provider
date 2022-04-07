import 'package:todo_list_provider/app/models/tasks_model.dart';

abstract class TasksRepository {
  Future<void> save(DateTime date, String description);
  Future<void> delete(int id);
  Future<List<TasksModel>> findByPeriod(DateTime start, DateTime end);
  Future<void> checkOrUncheckTask(TasksModel task);
  Future<void> clearTableTodo();
}
