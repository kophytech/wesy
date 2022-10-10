import 'package:cs_ui/cs_ui.dart';
import 'package:cs_ui/src/extension/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    Key? key,
    this.icon,
    this.title,
    this.onPressed,
    this.isLogout = false,
  }) : super(key: key);

  final IconData? icon;
  final String? title;
  final VoidCallback? onPressed;
  final bool isLogout;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: isLogout
            ? const EdgeInsets.only(
                left: 30,
                right: 25,
                top: 25,
                bottom: 25,
              )
            : const EdgeInsets.all(15),
        color: isLogout ? const Color(0xFFEBF4FF) : CsColors.white,
        child: Row(
          children: [
            Icon(
              icon,
              color: CsColors.primary,
            ),
            Gap(context.minBlockHorizontal * 5),
            Text(
              title!,
              style: CsTextStyle.caption.copyWith(
                fontSize: 16,
                color: isLogout ? CsColors.primary : CsColors.secondaryBorder2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
