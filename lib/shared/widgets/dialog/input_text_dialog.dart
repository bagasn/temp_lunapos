import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/shared/widgets/widgets/text_field/text_field.dart';

class InputTextDialog extends StatefulWidget {
  final String? title;
  final String? labelText;
  final String? hintText;

  final void Function(String value)? onSubmit;

  const InputTextDialog({
    super.key,
    this.title,
    this.labelText,
    this.hintText,
    this.onSubmit,
  });

  @override
  State<InputTextDialog> createState() => _InputTextDialogState();
}

class _InputTextDialogState extends State<InputTextDialog> {
  final _textController = TextEditingController();

  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.antiAlias,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      constraints: BoxConstraints(maxWidth: 640),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Container(
              color: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 20),
              alignment: Alignment.center,
              child: Text(
                widget.title!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: AppTextStyles.titleLarge.copyWith(
                  color: AppColors.textWhite,
                ),
              ),
            ),
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (widget.labelText != null)
                    Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: Text(
                        widget.labelText!,
                        style: TextTheme.of(
                          context,
                        ).bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  AppTextField(
                    controller: _textController,
                    hintText: widget.hintText,
                    errorText: _errorText,
                  ),

                  SizedBox(height: 16),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    spacing: 16,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            minimumSize: Size(150, 52),
                            foregroundColor: AppColors.red700,
                          ),
                          onPressed: () {
                            if (context.canPop()) {
                              context.pop();
                            }
                          },
                          child: Text('Batal'),
                        ),
                      ),
                      Expanded(
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            minimumSize: Size(150, 52),
                          ),
                          onPressed: widget.onSubmit == null
                              ? null
                              : () {
                                  if (_textController.text.isNotEmpty) {
                                    widget.onSubmit!(
                                      _textController.text.trim(),
                                    );
                                    if (context.canPop()) {
                                      context.pop();
                                    }
                                  }
                                },
                          child: Text('Simpan'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
