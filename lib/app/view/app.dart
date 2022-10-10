import 'package:auth_repository/auth_repository.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:cs_repository/cs_repository.dart';
import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wesy/admin/cubit/admin_cubit.dart';
import 'package:wesy/app/app_router.dart';
import 'package:wesy/app/bloc/app_bloc.dart';
import 'package:wesy/pin/details/cubit/pin_details_cubit.dart';
import 'package:wesy/region/cubit/region_cubit.dart';
import 'package:wesy/route/cubit/route_cubit.dart';
import 'package:wesy/route_detail/cubit/route_detail_cubit.dart';
import 'package:wesy/worker/cubit/worker_cubit.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.authRepository,
    required this.csRepository,
  }) : super(key: key);

  final AuthRepository authRepository;
  final CsRepository csRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepository),
        RepositoryProvider.value(value: csRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppBloc>(
            create: (_) => AppBloc(
              authRepository: authRepository,
            )..add(const AppFCMToken()),
          ),
          BlocProvider<RegionCubit>(
            create: (_) => RegionCubit(
              csRepository,
            ),
          ),
          BlocProvider<RouteCubit>(
            create: (context) => RouteCubit(
              csRepository,
              RegionCubit(csRepository)..getAllRegions(),
            ),
          ),
          BlocProvider<PinDetailsCubit>(
            create: (context) => PinDetailsCubit(csRepository),
          ),
          BlocProvider<WorkerCubit>(
            create: (context) => WorkerCubit(csRepository),
          ),
          BlocProvider<AdminCubit>(
            create: (context) => AdminCubit(csRepository),
          ),
          BlocProvider<RouteDetailCubit>(
            create: (context) => RouteDetailCubit(csRepository),
          ),
        ],
        child: const _App(),
      ),
    );
  }
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppBloc>().state;
    return CalendarControllerProvider(
      controller: EventController<Schedule>(),
      child: MaterialApp.router(
        routeInformationParser: AppRouter.routes.routeInformationParser,
        routerDelegate: AppRouter.routes.routerDelegate,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale(app.currentLocale),
        debugShowCheckedModeBanner: false,
        theme: CsTheme.light.copyWith(
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            circularTrackColor: CsColors.primary,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
