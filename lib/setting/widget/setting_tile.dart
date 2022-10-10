import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';

class SettingTile extends StatelessWidget {
  const SettingTile({
    Key? key,
    required this.title,
    this.color = CsColors.white,
    this.icon,
    this.isCustom = false,
    this.onPressed,
  }) : super(key: key);

  final String? title;
  final Color? color;
  final IconData? icon;
  final bool? isCustom;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: ListTile(
          leading: Icon(
            icon,
            color: isCustom! ? CsColors.danger : CsColors.primary,
            size: 27,
          ),
          tileColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            title!,
            style: CsTextStyle.headline6.copyWith(
              color: isCustom! ? CsColors.danger : CsColors.primaryText,
              fontSize: 20,
              fontWeight: CsFontWeight.semiBold,
            ),
          ),
        ),
      ),
    );
  }
}
