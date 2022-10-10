import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/src/provider.dart';
import 'package:wesy/app/app_router.dart';
import 'package:wesy/app/bloc/app_bloc.dart';
import 'package:wesy/home/widgets/drawer_tile.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppBloc>().state;
    final l10n = AppLocalizations.of(context)!;
    return SizedBox(
      width: 300,
      child: Drawer(
        child: Container(
          color: CsColors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Gap(context.minBlockHorizontal * 5),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 30,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: CsColors.primary,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: CsColors.primary),
                            ),
                            child: const Icon(
                              LineIcons.user,
                              color: CsColors.white,
                            ),
                          ),
                          Gap(context.minBlockHorizontal * 5),
                          Text(
                            '${app.user.firstName} ${app.user.lastName}',
                            style: CsTextStyle.headline6.copyWith(
                              fontSize: 16,
                              color: CsColors.secondaryBorder2,
                            ),
                          ),
                        ],
                      ),
                      Gap(context.minBlockVertical * 3),
                      const Divider(
                        color: Color(0xFFE5F4FF),
                      ),
                      Gap(context.minBlockVertical * 3),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              DrawerTile(
                                title: l10n.planing,
                                icon: LineIcons.book,
                                onPressed: () =>
                                    context.push(WesyPages.planing),
                              ),
                              DrawerTile(
                                title: l10n.route,
                                icon: LineIcons.route,
                                onPressed: () => context.push(WesyPages.route),
                              ),
                              if (app.user.roles!.length == 3 ||
                                  app.user.roles!.length == 2) ...[
                                DrawerTile(
                                  title: l10n.construction,
                                  icon: LineIcons.hollyBerry,
                                  onPressed: () =>
                                      context.push(WesyPages.construction),
                                ),
                                DrawerTile(
                                  title: l10n.store,
                                  icon: LineIcons.store,
                                  onPressed: () =>
                                      context.push(WesyPages.store),
                                ),
                                DrawerTile(
                                  title: l10n.industry,
                                  icon: LineIcons.industry,
                                  onPressed: () =>
                                      context.push(WesyPages.industry),
                                ),
                                DrawerTile(
                                  title: l10n.worker,
                                  icon: LineIcons.userAlt,
                                  onPressed: () =>
                                      context.push(WesyPages.worker),
                                ),
                              ],
                              if (app.user.roles!.length == 3)
                                DrawerTile(
                                  title: l10n.admin,
                                  icon: LineIcons.userCheck,
                                  onPressed: () =>
                                      context.push(WesyPages.admin),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // const Spacer(),
              DrawerTile(
                title: l10n.logout,
                isLogout: true,
                icon: LineIcons.alternateSignOut,
                onPressed: () {
                  context.back();
                  Future.delayed(const Duration(milliseconds: 20), () {
                    context
                      ..read<AppBloc>().logout()
                      ..push(WesyPages.login);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
