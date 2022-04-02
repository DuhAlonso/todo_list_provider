import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class HomeWeekFiler extends StatelessWidget {
  const HomeWeekFiler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          'DIA DA SEMANA',
          style: context.titleStyle,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 95,
          child: DatePicker(
            DateTime.now(),
            locale: 'pt_BR',
            height: 2,
            initialSelectedDate: DateTime.now(),
            selectionColor: context.primaryColor,
            selectedTextColor: Colors.white,
            daysCount: 7,
            monthTextStyle: TextStyle(fontSize: 8.5),
            dayTextStyle: TextStyle(fontSize: 13),
            dateTextStyle: TextStyle(fontSize: 15),
          ),
        )
      ],
    );
  }
}
