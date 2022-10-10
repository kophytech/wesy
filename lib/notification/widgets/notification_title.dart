import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/noresult.png'),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          Gap(context.minBlockHorizontal * 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Vincent Kadir',
                style: CsTextStyle.smallText.copyWith(
                  color: CsColors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(context.minBlockVertical),
              Text(
                'New route added',
                style: CsTextStyle.smallText.copyWith(
                  color: CsColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
