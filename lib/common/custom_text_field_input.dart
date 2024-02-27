import "package:bank/common/constant.dart";
import "package:flutter/material.dart";

class CustomTextFieldInput extends StatelessWidget {
  const CustomTextFieldInput({
    required this.hintText,
    required this.onChnaged,
    this.errorText,
    this.suffixIcon,
    this.isObsecured = false,
    this.textInputType = TextInputType.name,
    this.textInputAction = TextInputAction.next,
    super.key,
  });
  final String hintText;
  final bool isObsecured;
  final Widget? suffixIcon;
  final String? errorText;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final void Function(String value) onChnaged;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: EdgeInsets.only(
          top: context.getMediumPaddingSize(),
        ),
        child: TextFormField(
          obscureText: isObsecured,
          onChanged: onChnaged,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: suffixIcon,
            filled: true,
            hintText: hintText,
            errorText: errorText,
            hintStyle: TextStyle(
              color: const Color(0xff212121).withOpacity(0.6),
              fontWeight: FontWeight.w400,
              fontSize: context.getBodyFontSize(),
              letterSpacing: 0.2,
            ),
            contentPadding: EdgeInsets.all(
              context.getMediumPaddingSize(),
            ),
            fillColor: const Color(0xffF5F5F5),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(
                8,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                8,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                8,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(
                8,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
