import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gap/flutter_gap.dart';

import '../../core.dart';

class UiTextFormField extends FormField<String> {
  final TextEditingController? controller;
  final String label; // Text to be displayed as label on top of the field
  final String? placeholder; // Text to be displayed inside the field
  final String hint; // Text to be displayed at the bottom of the field
  final String? initialText;
  final Color? labelColor;
  final Color? backgroundColor;
  final Color? fontColor;
  final Color? borderColor;
  final TextInputType
  formFieldType; // This parameter is used to define the type of the field
  final TextAlign textAlign;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validators;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onTap;
  final VoidCallback? toggleObscureText;
  final bool obscureText;
  final bool enable;
  final bool autofocus;
  final bool isRequired;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsets? prefixIconPadding;
  final EdgeInsets? suffixIconPadding;
  final AutovalidateMode validateMode;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final bool withBorder;
  final int maxLines;
  final int? maxLength;
  final bool? readOnly;
  final bool withShadow;
  final double? elevation;
  final Color? shadowColor;

  UiTextFormField({
    super.key,
    this.controller,
    this.label = '',
    this.placeholder,
    this.hint = '',
    this.initialText,
    this.labelColor,
    this.backgroundColor,
    this.fontColor,
    this.borderColor,
    this.formFieldType = TextInputType.text,
    this.textAlign = TextAlign.start,
    this.textCapitalization = TextCapitalization.words,
    this.validators,
    this.onFieldSubmitted,
    this.onChanged,
    this.onEditingComplete,
    this.onTap,
    this.toggleObscureText,
    this.obscureText = false,
    this.enable = true,
    this.autofocus = false,
    this.isRequired = false,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixIconPadding,
    this.suffixIconPadding,
    this.validateMode = AutovalidateMode.disabled,
    this.inputFormatters,
    this.focusNode,
    this.withBorder = true,
    this.maxLines = 1,
    this.maxLength,
    this.readOnly,
    this.withShadow = true,
    this.elevation = 4,
    this.shadowColor,
  }) : super(
         autovalidateMode: validateMode,
         validator: validators,
         enabled: enable,
         builder: (field) {
           bool hasError = field.hasError;

           Widget? buildIconWithPadding(Widget? icon, EdgeInsets? padding) {
             if (icon == null) return null;

             if (padding != null && padding != EdgeInsets.zero) {
               return icon.addPadding(padding);
             }

             return icon;
           }

           void onChangesdHandler(String value) {
             if (onChanged != null) {
               onChanged(value);
             }
             field.didChange(value);
             if (field.hasError) {
               hasError = true;
             }
           }

             return Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     if (label != '')
                       Text.rich(
                         TextSpan(
                           text: label,
                           style: UiTextStyle.body16(
                             color: labelColor ?? UiColors.textDarker,
                             fontWeight: FontWeight.w600,
                           ),
                           children: isRequired
                               ? [
                                   TextSpan(
                                     text: ' *',
                                     style: UiTextStyle.body16(
                                       color: UiColors.dangerMain,
                                       fontWeight: FontWeight.w600,
                                     ),
                                   ),
                                 ]
                               : [],
                         ),
                       ).addPadding(const EdgeInsets.only(bottom: 6)),
                   ],
                 ),
                 SizedBox(
                   height: setHeight(maxLines),
                   child: () {
                     final textField = TextFormField(
                       readOnly: readOnly ?? false,
                       controller: controller,
                       initialValue: initialText,
                       keyboardType: formFieldType,
                       textAlign: textAlign,
                       textCapitalization: textCapitalization,
                       autovalidateMode: validateMode,
                       onTap: onTap,
                       onFieldSubmitted: onFieldSubmitted,
                       onEditingComplete: onEditingComplete,
                       inputFormatters: inputFormatters,
                       focusNode: focusNode,
                       enabled: enable,
                       obscureText: obscureText,
                       maxLines: maxLines,
                       style: UiTextStyle.body16(
                         color: fontColor ?? UiColors.textDarker,
                         fontWeight: FontWeight.w400,
                       ),
                       decoration: InputDecoration(
                         suffixIcon: toggleObscureText != null
                             ? IconButton(
                                 onPressed: toggleObscureText,
                                 icon: obscureText
                                     ? const Icon(Icons.visibility_off)
                                     : const Icon(Icons.visibility),
                               )
                             : buildIconWithPadding(
                                 suffixIcon,
                                 suffixIconPadding,
                               ),
                         prefixIcon: buildIconWithPadding(
                           prefixIcon,
                           prefixIconPadding,
                         ),
                         filled: true,
                         fillColor: backgroundColor ?? UiColors.bgWhite,
                         hintText: placeholder,
                         hintStyle: UiTextStyle.body16(
                           color: hasError
                               ? UiColors.dangerMain
                               : UiColors.textMuted,
                           fontWeight: FontWeight.w400,
                         ),
                         contentPadding: const EdgeInsets.symmetric(
                           horizontal: 16,
                           vertical: 16,
                         ),
                         border: _borderStyle(
                           isError: hasError,
                           withBorder: withBorder,
                           borderColor: borderColor,
                         ),
                         enabledBorder: _borderStyle(
                           isError: hasError,
                           withBorder: withBorder,
                           borderColor: borderColor,
                         ),
                         focusedBorder: _borderStyle(
                           isError: hasError,
                           isFocused: true,
                           withBorder: withBorder,
                           borderColor: borderColor,
                         ),
                       ),
                       onChanged: (value) {
                         onChangesdHandler(value);
                         onChanged ?? (value);
                       },
                     );
                     final double effectiveElevation = elevation ?? 0;
                     if (!withShadow || effectiveElevation <= 0) return textField;
                     return Material(
                       elevation: effectiveElevation,
                       shadowColor: shadowColor ?? Colors.black.withOpacity(0.08),
                       borderRadius: BorderRadius.circular(14),
                       child: textField,
                     );
                   }(),
                 ),
                 if (hint.isNotEmpty || hasError)
                   Row(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Icon(
                         hasError ? Icons.info_rounded : Icons.info_outline,
                         color: hasError ? UiColors.dangerMain : UiColors.bgDark,
                         size: 16,
                       ),
                       const Gap(8),
                       Text(
                         hasError ? field.errorText ?? '' : hint,
                         style: UiTextStyle.body14(
                           color: hasError
                               ? UiColors.dangerMain
                               : UiColors.bgDark,
                           fontWeight: FontWeight.w400,
                         ),
                       ),
                     ],
                   ).addPadding(const EdgeInsets.only(top: 6)),
               ],
             );
         },
       );
  @override
  _UiTextFormFieldState createState() => _UiTextFormFieldState();
}

class _UiTextFormFieldState extends FormFieldState<String> {
  TextEditingController? get _effectiveController => widget.controller;

  @override
  UiTextFormField get widget => super.widget as UiTextFormField;

  @override
  void initState() {
    widget.controller?.addListener(_handleControllerChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.controller?.text.isNotEmpty ?? false) {
        super.didChange(widget.controller?.text);
      }
    });
    super.initState();
  }

  @override
  void didUpdateWidget(UiTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  @override
  void didChange(String? value) {
    if (_effectiveController?.text != value) {
      _effectiveController?.text = value ?? '';
    }
    super.didChange(value);
  }

  void _handleControllerChanged() {
    if (_effectiveController!.text != value) {
      didChange(_effectiveController!.text);
    }
  }
}

double setHeight(int maxLines) {
  if (maxLines > 1) {
    return 100;
  }
  return 56;
}

InputBorder _borderStyle({
  bool isError = false,
  bool isFocused = false,
  bool withBorder = true,
  Color? borderColor,
}) {
  if (!withBorder) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide.none,
    );
  }

  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(14),
    borderSide: BorderSide(
      color: borderColor ?? (isError ? UiColors.dangerMain : UiColors.strokeStrong),
      width: isFocused ? 1.5 : 1.0,
    ),
  );
}
