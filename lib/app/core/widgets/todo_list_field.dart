import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:todo_list_provider/app/core/ui/todo_list_icons.dart';

class TodoListField extends StatelessWidget {
  final String label;
  final IconButton? suffixIconButton;
  final bool obscureText;
  final ValueNotifier<bool> obscuretextVN;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  TodoListField({
    Key? key,
    required this.label,
    this.suffixIconButton,
    this.obscureText = false,
    this.controller,
    this.validator,
  })  : assert(obscureText == true ? suffixIconButton == null : true,
            'obscureText não pode ser enviado em conjunto com siffixIconButton'),
        obscuretextVN = ValueNotifier(obscureText),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscuretextVN,
      builder: (_, obscuretextValue, child) {
        return TextFormField(
          validator: validator,
          controller: controller,
          obscureText: obscuretextValue,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(fontSize: 15, color: Colors.black),
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            suffixIcon: this.suffixIconButton ??
                (obscureText == true
                    ? IconButton(
                        onPressed: () {
                          obscuretextVN.value = !obscuretextValue;
                        },
                        icon: Icon(!obscuretextValue
                            ? TodoListIcon.eye_slash
                            : TodoListIcon.eye),
                      )
                    : null),
          ),
        );
      },
    );
  }
}
