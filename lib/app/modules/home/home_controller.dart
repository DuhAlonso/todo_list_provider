import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/services/tasks/tasks_service.dart';

class HomeController extends DefaultChangeNotifier {
  final TasksService _tasksService;

  HomeController({required TasksService tasksService})
      : _tasksService = tasksService;
  var filterSelected = TaskFilterEnum.today;
}
