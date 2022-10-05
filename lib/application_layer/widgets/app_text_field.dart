import 'package:dzpos/core/extensions/extensions.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.hint,
    this.keyboardType,
    this.obscureText = false,
    this.prefix,
    this.suffix,
    this.textInputAction,
  });

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final Widget? prefix;
  final Widget? suffix;
  final String? hint;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (widget.prefix != null) ...[
          widget.prefix!,
          const SizedBox(width: 10),
        ],
        Expanded(
          child: TextField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            obscureText: widget.obscureText && _isObscure,
            decoration: InputDecoration(
              suffixIcon: widget.obscureText
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                      icon: widget.obscureText
                          ? Icon(
                              _isObscure
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.remove_red_eye,
                            )
                          : widget.suffix ?? const SizedBox(),
                    )
                  : widget.suffix,
              hintText: widget.hint,
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: context.theme.errorColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: context.theme.primaryColor),
              ),
              hintStyle:
                  context.textTheme.bodyLarge?.copyWith(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}
