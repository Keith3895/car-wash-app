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
      this.controller,
      this.ftIcon,
      this.skipLabel = false,
      this.enabled = true,
      this.onChanged,
      this.suffixIcon});

  final Key? fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final TextEditingController? controller;
  final String? ftIcon;
  final bool skipLabel;
  final bool enabled;
  final Widget? suffixIcon;
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
            widget.skipLabel ? '' : widget.labelText,
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 12, color: Color(0xe79586a8)),
          ),
        ),
        TextFormField(
          enabled: widget.enabled,
          key: widget.fieldKey,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.tertiary,
            letterSpacing: -0.41,
          ),
          validator: widget.validator,
          onSaved: widget.onSaved,
          onChanged: widget.onChanged,
          controller: widget.controller,
          decoration: _inputDecoration(),
        )
      ],
    );
  }

  InputDecoration _inputDecoration() {
    if (widget.enabled) {
      return InputDecoration(
          border: const OutlineInputBorder(),
          labelText: widget.labelText,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle:
              TextStyle(height: .8, color: Theme.of(context).colorScheme.primary, fontSize: 15),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
              borderRadius: BorderRadius.circular(8)),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: _AddIcon(widget.ftIcon),
          suffixIcon: widget.suffixIcon,
          contentPadding: const EdgeInsets.all(13));
    } else {
      return InputDecoration(
          border: const OutlineInputBorder(),
          labelText: widget.labelText,
          disabledBorder: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle:
              TextStyle(height: .8, color: Theme.of(context).colorScheme.primary, fontSize: 15),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8)),
          fillColor: Colors.transparent,
          filled: false,
          prefixIcon: _AddIcon(widget.ftIcon),
          contentPadding: const EdgeInsets.only(top: 0));
    }
  }

  Widget? _AddIcon(String? ftIcon) {
    if (ftIcon == null) {
      return null;
    } else {
      return Container(
        padding: const EdgeInsets.only(left: 15, top: 13, bottom: 11),
        child: Text(ftIcon,
            style: TextStyle(
                fontFamily: 'FontAwesome5ProRegular400',
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18)),
      );
    }
  }
}
