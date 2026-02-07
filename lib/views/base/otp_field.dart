import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/style.dart';

class OtpInput extends StatefulWidget {
  final int length;
  final Function(String) onCompleted;
  final bool hasError;
  final String? errorText;

  const OtpInput({
    super.key,
    this.length = 6,
    required this.onCompleted,
    this.hasError = false,
    this.errorText,
  });

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(widget.length, (_) => TextEditingController());
    focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var c in controllers) c.dispose();
    for (var f in focusNodes) f.dispose();
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.length > 1) {
      _handlePaste(value);
      return;
    }

    if (value.isNotEmpty) {
      if (index < widget.length - 1) {
        focusNodes[index + 1].requestFocus();
      } else {
        focusNodes[index].unfocus();
        _submitOtp();
      }
    }
  }

  void _handlePaste(String pastedText) {
    final otp = pastedText.replaceAll(RegExp(r'\D'), '');
    if (otp.length == widget.length) {
      for (int i = 0; i < widget.length; i++) {
        controllers[i].text = otp[i];
      }
      focusNodes.last.unfocus();
      _submitOtp();
    }
  }

  void _onKeyPress(RawKeyEvent event, int index) {
    if (event.logicalKey == LogicalKeyboardKey.backspace &&
        controllers[index].text.isEmpty &&
        index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  void _submitOtp() {
    final otp = controllers.map((e) => e.text).join();
    if (otp.length == widget.length) {
      widget.onCompleted(otp);
    }
  }

  Widget _buildBox(int index) {
    return SizedBox(
      height: 56,
      width: 48,

      // ignore: deprecated_member_use
      child: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (event) => _onKeyPress(event, index),
        child: TextField(
          controller: controllers[index],
          focusNode: focusNodes[index],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: AppTextStyles.text18(
            color: AppColors.grey[900],
            weight: AppTextStyles.semibold,
          ),
          maxLength: 1,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (value) => _onChanged(value, index),
          decoration: InputDecoration(
            counterText: "",
            filled: true,
            fillColor: AppColors.white,
            contentPadding: EdgeInsets.zero,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: widget.hasError ? Colors.red : AppColors.grey[200]!,
                width: 1.5,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: widget.hasError ? Colors.red : AppColors.primary,
                width: 1.8,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            widget.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: _buildBox(index),
            ),
          ),
        ),

        if (widget.hasError && widget.errorText != null) ...[
          Text(
            widget.errorText!,
            textAlign: TextAlign.center,
            style: AppTextStyles.text12(
              color: Colors.red,
              weight: FontWeight.w400,
            ),
          ),
        ],
      ],
    );
  }
}
