import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/src/provider.dart';
import 'package:wesy/app/app_router.dart';
import 'package:wesy/app/bloc/app_bloc.dart';
import 'package:wesy/setting/setting.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppBloc>().state;
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          Gap(context.minBlockVertical * 5.0),
          Align(
            child: Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: CsColors.primary,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: CsColors.primary),
              ),
              child: const Icon(
                LineIcons.user,
                color: CsColors.white,
                size: 50,
              ),
            ),
          ),
          Gap(context.minBlockVertical * 3.0),
          Text(
            '${app.user.firstName} ${app.user.lastName}',
            style: CsTextStyle.bigText,
          ),
          Text(
            '${app.user.email}',
            style: CsTextStyle.overline,
          ),
          Gap(context.minBlockVertical * 3.0),
          const Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SettingTile(
                    title: l10n.edit_profile,
                    icon: LineIcons.userAlt,
                    onPressed: () => context.push(WesyPages.editProfile),
                  ),
                  const Divider(),
                  SettingTile(
                    title: l10n.change_password,
                    icon: LineIcons.lowVision,
                    onPressed: () => context.push(WesyPages.changePassword),
                  ),
                  const Divider(),
                  SettingTile(
                    title: l10n.planing,
                    icon: LineIcons.book,
                    onPressed: () => context.push(WesyPages.planing),
                  ),
                  const Divider(),
                  SettingTile(
                    title: l10n.route,
                    icon: LineIcons.route,
                    onPressed: () => context.push(WesyPages.route),
                  ),
                  if (app.user.roles!.length == 3 ||
                      app.user.roles!.length == 2) ...[
                    const Divider(),
                    SettingTile(
                      title: l10n.construction,
                      icon: LineIcons.hollyBerry,
                      onPressed: () => context.push(WesyPages.construction),
                    ),
                    const Divider(),
                    SettingTile(
                      title: l10n.store,
                      icon: LineIcons.store,
                      onPressed: () => context.push(WesyPages.store),
                    ),
                    const Divider(),
                    SettingTile(
                      title: l10n.industry,
                      icon: LineIcons.industry,
                      onPressed: () => context.push(WesyPages.industry),
                    ),
                    const Divider(),
                    SettingTile(
                      title: l10n.worker,
                      icon: LineIcons.userAlt,
                      onPressed: () => context.push(WesyPages.worker),
                    ),
                  ],
                  if (app.user.roles!.length == 3) ...[
                    const Divider(),
                    SettingTile(
                      title: l10n.worker,
                      icon: LineIcons.userCheck,
                      onPressed: () => context.push(WesyPages.admin),
                    ),
                  ],
                  const Divider(),
                  SettingTile(
                    title: l10n.logout,
                    // color: CsColors.danger,
                    icon: LineIcons.alternateSignOut,
                    isCustom: true,
                    onPressed: () => context
                      ..read<AppBloc>().logout()
                      ..push(WesyPages.login),
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
