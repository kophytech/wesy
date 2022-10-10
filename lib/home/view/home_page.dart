import 'package:cs_repository/cs_repository.dart';
import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:line_icons/line_icons.dart';
import 'package:wesy/app/bloc/app_bloc.dart';
import 'package:wesy/home/bloc/home_bloc.dart';
import 'package:wesy/home/home.dart';
import 'package:wesy/home/view/home_body.dart';
import 'package:wesy/notification/notification.dart';
import 'package:wesy/region/region.dart';
import 'package:wesy/setting/setting.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (_) => HomeBloc(csRepository: context.read<CsRepository>())
            ..add(
              HomeStarted(
                appState: context.read<AppBloc>().state,
              ),
            ),
        ),
      ],
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<AppBloc>().add(const AppGetCurrentLocation());
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeBloc>().state;
    final app = context.watch<AppBloc>().state;
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      key: state.scaffoldKey,
      drawer: const AppDrawer(),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: state.currentIndex,
        onTap: (value) => context
            .read<HomeBloc>()
            .add(CurrentIndexChanged(currentIndex: value)),
        items: [
          AppBottomNavigationBarItem(
            useCustomIcon: false,
            icon: LineIcons.home,
            label: l10n.home,
          ),
          if (app.user.roles!.length == 3)
            AppBottomNavigationBarItem(
              useCustomIcon: false,
              icon: LineIcons.buildingAlt,
              label: l10n.route,
            ),
          AppBottomNavigationBarItem(
            useCustomIcon: false,
            icon: LineIcons.bell,
            label: l10n.notification,
          ),
          AppBottomNavigationBarItem(
            useCustomIcon: false,
            icon: LineIcons.cog,
            label: l10n.setting,
          ),
        ],
      ),
      body: SafeArea(
        child: IndexedStack(
          index: state.currentIndex,
          children: [
            const HomeBody(),
            if (app.user.roles!.length == 3) const RegionPage(),
            const NotificationPage(),
            const SettingPage(),
          ],
        ),
      ),
    );
  }
}
