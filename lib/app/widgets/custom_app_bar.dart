import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    this.onAddPressed,
    this.hasAdd = true,
    this.fontSize = 25,
  }) : super(key: key);

  final String title;
  final VoidCallback? onAddPressed;
  final bool hasAdd;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        InkResponse(
          onTap: () => context.back(),
          child: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              title,
              style: CsTextStyle.bigText.copyWith(
                fontSize: fontSize,
              ),
            ),
          ),
        ),
        if (hasAdd)
          TextButton(
            onPressed: onAddPressed,
            style: TextButton.styleFrom(
              primary: CsColors.primary,
            ),
            child: Text(
              l10n.add,
              style: CsTextStyle.bodyText1.copyWith(
                color: CsColors.primary,
                fontWeight: CsFontWeight.semiBold,
              ),
            ),
          ),
      ],
    );
  }
}
