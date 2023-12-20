import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  /// Creates a [PasswordFormField] that contains a [TextField].
  ///
  /// When a [controller] is specified, [initialValue] must be null (the
  /// default). If [controller] is null, then a [TextEditingController]
  /// will be constructed automatically and its `text` will be initialized
  /// to [initialValue] or the empty string.
  ///
  /// For documentation about the various parameters, see the [TextField] class
  /// and [new TextField], the constructor.
  const PasswordField(
      {this.fieldKey,
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
  _PasswordFieldState createState() => new _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              widget.labelText,
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 12, color: Color(0xe79586a8)),
            ),
          ),
          TextFormField(
            controller: widget.controller,
            key: widget.fieldKey,
            obscureText: _obscureText,
            enabled: true,
            autovalidateMode: AutovalidateMode.always,
            // maxLength: widget.maxLength == null ? 8 : widget.maxLength,
            onSaved: widget.onSaved,
            validator: widget.validator,
            onFieldSubmitted: widget.onFieldSubmitted,
            decoration: InputDecoration(
              // border: const UnderlineInputBorder(),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelStyle: const TextStyle(height: .8, color: Color(0xe72D0C57), fontSize: 15),
              border: const OutlineInputBorder(),
              enabledBorder:
                  const OutlineInputBorder(borderSide: BorderSide(color: Color(0xe7D9D0E3))),
              fillColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.all(13),
              hintText: widget.hintText,
              labelText: widget.labelText,
              // helperText: widget.helperText,
              suffixIcon: new GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: new Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
              ),
            ),
          )
        ]);
  }
}
