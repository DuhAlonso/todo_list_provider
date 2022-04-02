import 'package:todo_list_provider/app/modules/home/home_page.dart';

import '../../core/modules/todo_list_module.dart';

class HomeModule extends TodoListModule {
  HomeModule()
      : super(
          // bindings: [],
          routers: {
            '/home': (context) => HomePage(),
          },
        );
}
