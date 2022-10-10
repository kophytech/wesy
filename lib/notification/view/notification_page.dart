import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:wesy/home/bloc/home_bloc.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final home = context.read<HomeBloc>().state;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkResponse(
                onTap: () => home.scaffoldKey!.currentState!.openDrawer(),
                child: SvgPicture.asset(
                  'assets/svgs/drawer.svg',
                  color: CsColors.primary,
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Notifications',
                    style: CsTextStyle.bigText.copyWith(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Gap(context.minBlockVertical * 5.0),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/svgs/no_history.svg'),
                  Gap(context.minBlockVertical * 2.0),
                  Text(
                    'No Notification',
                    style: CsTextStyle.headline5,
                  )
                ],
              ),
            ),
          ),
          // const NotificationTile(),
          // Gap(context.minBlockVertical),
          // const NotificationTile(),
          // Gap(context.minBlockVertical),
          // const NotificationTile(),
        ],
      ),
    );
  }
}
