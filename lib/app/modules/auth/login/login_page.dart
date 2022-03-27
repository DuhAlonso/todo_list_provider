import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/widgets/todo_list_logo.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              //IntrinsicHeight faz com que o collumn fique com tamanho
              //necesarios apenas para exibir os filhos
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    const TodoListLogo(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
