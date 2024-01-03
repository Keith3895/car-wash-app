import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  const InputField(
      {super.key,
      this.fieldKey,
      this.hintText = '',
      this.labelText = '',
      this.helperText = '',
      this.onSaved,
      this.validator,
      this.onFieldSubmitted,
      this.maxLength,
      this.controller});

  final Key? fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final int? maxLength;
  final TextEditingController? controller;
  @override
  _InputField createState() => _InputField();
}

class _InputField extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            widget.labelText,
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 12, color: Color(0xe79586a8)),
          ),
        ),
        TextFormField(
          key: widget.fieldKey,
          decoration: InputDecoration(
              labelText: widget.labelText,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelStyle: const TextStyle(height: .8, color: Color(0xe72D0C57), fontSize: 15),
              border: const OutlineInputBorder(),
              enabledBorder:
                  const OutlineInputBorder(borderSide: BorderSide(color: Color(0xe7D9D0E3))),
              fillColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.all(13)),
          validator: widget.validator,
          onSaved: widget.onSaved,
        ),
      ],
    );
  }
}
