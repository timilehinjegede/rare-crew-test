import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rare_crew/utils/utils.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.labelText,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.isPassword = false,
    this.lines = 1,
    this.onChanged,
    this.suffixIcon,
    this.onTap,
    this.readOnly = false,
    this.inputFormatters,
    this.initialValue,
  }) : super(key: key);

  final String hintText;
  final String labelText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool isPassword;
  final int? lines;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isPasswordVisible = false;

  void updatePasswordVisibility() {
    setState(
      () => _isPasswordVisible = !_isPasswordVisible,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: rareCrewColors.darkGrey.withOpacity(.3),
        ),
      ),
      child: TextFormField(
        initialValue: widget.initialValue,
        controller: widget.controller,
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        obscureText: widget.isPassword ? !_isPasswordVisible : false,
        obscuringCharacter: '●',
        minLines: widget.lines,
        maxLines: widget.lines,
        inputFormatters: [
          ...?widget.inputFormatters,
        ],
        style: TextStyle(
          color: rareCrewColors.black,
          fontWeight: FontWeight.w500,
        ),
        readOnly: widget.readOnly,
        onTap: widget.onTap,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          suffixIcon: widget.isPassword
              ? IconButton(
                  splashRadius: 25,
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: rareCrewColors.darkGrey,
                  ),
                  onPressed: updatePasswordVisibility,
                )
              : widget.suffixIcon,
        ),
      ),
    );
  }
}
