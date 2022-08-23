import 'package:flutter/material.dart';
import 'package:rare_crew/utils/utils.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    required this.title,
    this.titleWidget,
    this.onPressed,
    this.buttonColor,
    this.textColor,
    this.size,
    this.radius,
    this.isLoading = false,
    this.disabled = false,
  }) : super(key: key);

  final String title;
  final Widget? titleWidget;
  final VoidCallback? onPressed;
  final Color? buttonColor;
  final Color? textColor;
  final Size? size;
  final double? radius;
  final bool isLoading;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: disabled ? null : onPressed,
      style: TextButton.styleFrom(
        foregroundColor: textColor,
        backgroundColor: disabled ? rareCrewColors.grey : buttonColor,
        minimumSize: size,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            radius ?? 0,
          ),
        ),
      ),
      child: (isLoading
              ? SizedBox(
                  height: 30,
                  width: 30,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 4,
                      color: rareCrewColors.background,
                    ),
                  ),
                )
              : titleWidget) ??
          Text(
            title,
            style: TextStyle(
              color:
                  disabled ? rareCrewColors.black.withOpacity(.7) : textColor,
            ),
          ),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.size,
    this.isLoading = false,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String title;
  final Size? size;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: rareCrewColors.purple,
        backgroundColor: rareCrewColors.background,
        side: BorderSide(
          color: rareCrewColors.purple,
          width: 2,
        ),
        minimumSize: size ?? const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: isLoading
          ? SizedBox(
              height: 25,
              width: 25,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  color: rareCrewColors.background,
                ),
              ),
            )
          : Text(
              title,
              style: TextStyle(
                color: rareCrewColors.purple,
              ),
            ),
    );
  }
}
