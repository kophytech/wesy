import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:wesy/home/bloc/home_bloc.dart';

class ChartPage extends StatelessWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final home = context.read<HomeBloc>().state;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Row(
            children: [
              InkResponse(
                onTap: () => home.scaffoldKey!.currentState!.openDrawer(),
                child: SvgPicture.asset('assets/svgs/drawer.svg'),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Charts',
                    style: CsTextStyle.bigText.copyWith(
                      fontSize: 32,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Gap(context.minBlockVertical * 5.0),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: const [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
