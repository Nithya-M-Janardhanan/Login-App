import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../machine_test/hexcolor.dart';

class CustomTextFormField extends StatefulWidget {
  final String? labelText;
  final String hintText;
  final TextInputType? inputType;
  final String Function(String?)? validator;
  final Function? onTap;
  final Function? onEditingComplete;
  final bool isObscure;
  final Widget? prefix;
  final TextStyle? hintFontStyle;
  final Function? onSaved;
  final Function? onChanged;
  final TextInputAction? inputAction;
  final int? maxLines;
  final int? maxLength;
  final bool autoFocus;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final bool defaultFont;
  final Widget? prefixIcon;
  final EdgeInsetsGeometry? contentPadding;

  const CustomTextFormField({
    Key? key,
    this.hintText = '',
    this.labelText,
    this.prefix,
    this.inputType,
    this.validator,
    this.hintFontStyle,
    this.onTap,
    this.onEditingComplete,
    this.autoFocus = false,
    this.isObscure = false,
    this.onSaved,
    this.onChanged,
    this.inputAction,
    this.inputFormatters,
    this.controller,
    this.maxLength,
    this.maxLines,
    this.defaultFont = true,
    this.prefixIcon,
    this.contentPadding,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool enableLabel = false;
  bool enableObscure = true;

  @override
  Widget build(BuildContext context) {
    final outlinedBorder = OutlineInputBorder(
        borderSide: BorderSide(color: HexColor("#626465"), width: 0.5.r));
    final outlinedErrorBorder = OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 0.5.r));

    return SizedBox(
      width: 346.w,
      child: TextFormField(
          controller: widget.controller,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          onChanged:
          widget.onChanged != null ? (val) => widget.onChanged!(val) : null,
          onTap: () => setState(() {
            enableLabel = true;
          }),
          validator:
          widget.validator == null ? (val) {} : (val) => widget.validator!(val),
          autocorrect: false,
          enableSuggestions: false,
          obscureText: widget.isObscure ? enableObscure : false,
          inputFormatters: widget.inputFormatters,
          maxLength: widget.maxLength,
          autofocus: widget.autoFocus,
          cursorColor: HexColor("#626465"),
          decoration: InputDecoration(
              prefixIcon: widget.prefixIcon,
              border: outlinedBorder,
              enabledBorder: outlinedBorder,
              counterText: "",
              focusedBorder: outlinedBorder,
              focusedErrorBorder: outlinedErrorBorder,
              contentPadding: widget.contentPadding ?? EdgeInsets.all(20.h),
              errorBorder: outlinedErrorBorder,
              labelText: enableLabel ? widget.labelText : null,
              labelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: HexColor("#626465"),
              ),
              hintText: widget.hintText,
              hintStyle: widget.hintFontStyle ??
                  TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: HexColor("#626465"),
                  ),
              filled: true,
              fillColor: Colors.white,
              prefix: widget.prefix,
              suffixIcon: widget.isObscure
                  ? IconButton(
                icon: Icon(
                  Icons.remove_red_eye_outlined,
                  color: enableObscure ? Colors.black : Colors.black,
                ),
                onPressed: () => setState(() {
                  enableObscure = !enableObscure;
                }),
              )
                  : null)),
    );
  }
}
class CustomForm extends FormField<String> {
  final TextEditingController? controller;
  final Function onChanged;
  final bool isObscure;
  final bool enableObscure;
  final Widget? prefix;
  final bool enableLabel;
  final Color? fillColor;
  final String? labelText;
  final bool showObscureIcon;
  final bool isReadOnly;
  final TextInputType? inputType;
  final String hintText;
  final VoidCallback? onTap;
  final int? maxLength;
  final VoidCallback? onObscureTap;
  final Widget? onSuffix;
  final List<TextInputFormatter>? inputFormatters;
  final bool arabicPadding;

  CustomForm(
      {Key? key,
        required FormFieldSetter<String> onSaved,
        required FormFieldValidator<String> validator,
        this.controller,
        this.onTap,
        this.prefix,
        this.showObscureIcon = true,
        this.fillColor,
        this.enableObscure = true,
        this.enableLabel = false,
        this.onObscureTap,
        this.inputType,
        required this.isReadOnly,
        this.isObscure = false,
        this.labelText,
        this.onSuffix,
        this.inputFormatters,
        this.maxLength,
        required this.onChanged,
        this.hintText = '',
        this.arabicPadding = false,
        String initialValue = ''})
      : super(
      key: key,
      onSaved: onSaved,
      validator: validator,
      initialValue: initialValue,
      autovalidateMode: AutovalidateMode.disabled,
      builder: (FormFieldState<String> state) {
        print('////////${state.hasError}');
        final outlinedBorder = OutlineInputBorder(
            borderSide: BorderSide(
                color: enableLabel
                    ? Colors.red
                    : HexColor('#C5C5C5'), width: 0.5.r));
        return Column(
          children: [
            SizedBox(
              height: 48.h,
              child: TextFormField(
                  controller: controller,
                  style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w500),
                  onTap: onTap,
                  inputFormatters: inputFormatters,
                  keyboardType: inputType,
                  maxLength: maxLength,
                  readOnly: isReadOnly,
                  onChanged: (val) {
                    state.didChange(val);
                    onChanged(val);
                  },
                  obscureText: isObscure ? enableObscure : false,
                  decoration: InputDecoration(
                      border: outlinedBorder,
                      counterText: '',
                      focusedBorder: outlinedBorder,
                      enabledBorder: outlinedBorder,
                      contentPadding: EdgeInsets.only(
                          bottom: 5.h, left: 15.w, right: onSuffix != null ? arabicPadding ? 15.w : 0 : 15.w),
                      errorBorder: outlinedBorder,
                      labelText: labelText,
                      labelStyle: state.hasError ? TextStyle(color: Colors.red) : TextStyle(color: Colors.yellow),
                      fillColor: fillColor,
                      filled: fillColor != null ? true : false,
                      hintText: hintText,
                      // hintStyle: FontStyle.grey15Medium,
                      prefix: prefix,
                      suffixIcon: onSuffix != null
                          ? Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 15.h, horizontal: 10.w),
                        child: onSuffix,
                      )
                          : isObscure && showObscureIcon
                          ? IconButton(
                        icon: Icon(
                          Icons.remove_red_eye_outlined,
                          color: enableObscure
                              ? Colors.black
                              : Colors.teal,
                        ),
                        onPressed: onObscureTap,
                      )
                          : null,
                      floatingLabelBehavior: enableLabel
                          ? FloatingLabelBehavior.always
                          : FloatingLabelBehavior.never)),
            ),

          ],
        );
      });
}