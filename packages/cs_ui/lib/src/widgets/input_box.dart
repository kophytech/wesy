import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// {@template input_box}
/// InputBox similar to textfield
/// {@endtemplate}
class InputBox extends StatelessWidget {
  ///@macro TextBox Constructor
  const InputBox(
      {Key? key,
      this.controller,
      this.validator,
      this.hintText,
      this.labelText,
      this.errorText,
      this.icon,
      this.value = '',
      this.leadingIcon,
      this.leadingColor = CsColors.primaryText,
      this.fillColor = const Color(0xFFF6F6F6),
      this.maxLength,
      this.inputFormat,
      this.inputType,
      this.isPassword = false,
      this.raduis = 10.0,
      this.borderSide = const BorderSide(color: Color(0xFFF6F6F6)),
      this.iconSize = 24.0,
      this.isWritable = true,
      this.enablePrefix = true,
      this.onChanged,
      this.focus,
      this.onIconClick})
      : super(key: key);

  ///@macro TextEditingController fields
  final TextEditingController? controller;

  ///@macro Validator fields
  final FormFieldValidator<String>? validator;

  ///@macro HintText
  final String? hintText;

  ///@macro Label Text
  final String? labelText;

  ///@macro Error Text
  final String? errorText;

  ///@macro Icon
  final IconData? icon;

  ///@macro value
  final String? value;

  ///@macro Leading Icon
  final IconData? leadingIcon;

  ///@macro Max Length
  final int? maxLength;

  ///@macro InputForm
  final List<TextInputFormatter>? inputFormat;

  ///@macro Input Type
  final TextInputType? inputType;

  ///@macro IsPassword either true/false
  final bool isPassword;

  ///@macro InputBox Border Raduis
  final double raduis;

  ///@macro BorderSide
  final BorderSide borderSide;

  ///@macro Icon Size
  final double iconSize;

  ///@macro Iswritable true/false
  final bool isWritable;

  ///@macro onIconClick
  final VoidCallback? onIconClick;

  ///@macro LeadingIcon Color
  final Color leadingColor;

  ///@macro TextBox Background Color
  final Color fillColor;

  ///@macro Enable Prefix Icon true/false
  final bool enablePrefix;

  ///@macro OnChange function
  final ValueChanged<String>? onChanged;

  ///@macro TextBox Focus
  final FocusNode? focus;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isWritable,
      validator: validator,
      inputFormatters: inputFormat,
      onChanged: onChanged,
      initialValue: value,
      // controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: inputType,
      maxLength: maxLength,
      focusNode: focus,
      obscureText: isPassword,
      style: const TextStyle(
        color: CsColors.black,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintStyle: CsTextStyle.caption.copyWith(
          color: const Color(0xFFA8AAB8),
        ),
        hintText: hintText,
        labelStyle: CsTextStyle.caption.copyWith(
          color: CsColors.secondary,
        ),
        fillColor: fillColor,
        filled: true,
        errorText: errorText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            raduis,
          ),
          borderSide: borderSide,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            raduis,
          ),
          borderSide: borderSide,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            raduis,
          ),
          borderSide: borderSide,
        ),
        contentPadding: const EdgeInsets.only(
          left: 20,
          bottom: 20,
          top: 20,
        ),
        suffixIcon: GestureDetector(
          onTap: onIconClick,
          child: Icon(
            icon,
            color: CsColors.primaryIcon,
          ),
        ),
      ),
    );
  }
}
