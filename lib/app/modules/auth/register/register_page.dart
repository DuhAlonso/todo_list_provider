import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/notifier/default_listener_notifier.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/core/validators/validators.dart';
import 'package:todo_list_provider/app/core/widgets/todo_list_field.dart';
import 'package:todo_list_provider/app/core/widgets/todo_list_logo.dart';
import 'package:todo_list_provider/app/modules/auth/register/register_controller.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailEC = TextEditingController();

  final _passwordEC = TextEditingController();

  final _confirmPasswordEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    _confirmPasswordEC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    var defaultListener = DefaultListenerNotifier(
        changeNotifier: context.read<RegisterController>());
    defaultListener.listener(
        context: context,
        successCallBack: (notifier, listenerInstance) {
          listenerInstance.dispose();
          Navigator.of(context).pop();
          Messages.of(context).showInfo('Cadastrado com Sucesso!');
        });
    // context.read<RegisterController>().addListener(() {
    //   final controller = context.read<RegisterController>();
    //   var success = controller.success;
    //   var error = controller.error;
    //   if (success) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text('Cadastrado com Sucesso!!'),
    //         backgroundColor: Colors.green,
    //       ),
    //     );
    //     Navigator.of(context).pop();
    //   } else if (error != null && error.isNotEmpty) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text(error),
    //         backgroundColor: Colors.red,
    //       ),
    //     );
    //   }
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: false,
        titleSpacing: 5,
        title: Column(
          children: [
            Text(
              'Cadastro',
              style: TextStyle(fontSize: 17, color: context.primaryColor),
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: ClipOval(
            child: Container(
              color: context.primaryColor.withAlpha(20),
              padding: EdgeInsets.all(8),
              child: Icon(
                Icons.arrow_back_ios_outlined,
                color: context.primaryColor,
                size: 20,
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.width * 0.5,
            //FittedBox redimensiona proporcional o child conforme a tela
            child: FittedBox(
              child: TodoListLogo(),
              fit: BoxFit.fitHeight,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TodoListField(
                    label: 'E-mail',
                    controller: _emailEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('E-mail obrigatório'),
                      Validatorless.email('E-amil inválido')
                    ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TodoListField(
                    controller: _passwordEC,
                    label: 'Senha',
                    obscureText: true,
                    validator: Validatorless.multiple([
                      Validatorless.required('Senha obrigatória'),
                      Validatorless.min(6, 'Mínimo de 6 caracteres')
                    ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TodoListField(
                    controller: _confirmPasswordEC,
                    label: 'Confirmar Senha',
                    obscureText: true,
                    validator: Validatorless.multiple([
                      Validatorless.required('Confirmar senha é Obrigatório'),
                      Validators.compare(_passwordEC, 'Senhas não Coincidem')
                    ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        final formValid =
                            _formKey.currentState?.validate() ?? false;
                        if (formValid) {
                          final email = _emailEC.text;
                          final password = _passwordEC.text;
                          context
                              .read<RegisterController>()
                              .registerUser(email, password);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Salvar'),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
