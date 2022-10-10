import 'package:cs_repository/cs_repository.dart';
import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:wesy/app/app.dart';
import 'package:wesy/app/bloc/app_bloc.dart';
import 'package:wesy/planing/cubit/planing_cubit.dart';

class PlaningPage extends StatelessWidget {
  const PlaningPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PlaningCubit(csRepository: context.read<CsRepository>()),
      child: const PlaningView(),
    );
  }
}

class PlaningView extends StatefulWidget {
  const PlaningView({Key? key}) : super(key: key);

  static const int sortName = 0;
  static const int sortStatus = 1;

  @override
  State<PlaningView> createState() => _PlaningViewState();
}

class _PlaningViewState extends State<PlaningView> {
  int isClicked = 0;
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppBloc>().state;
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            children: [
              CustomAppBar(
                title: l10n.planing,
                hasAdd: false,
              ),
              Gap(context.minBlockVertical * 3.0),
              BlocBuilder<PlaningCubit, PlaningState>(
                builder: (context, state) {
                  return Card(
                    elevation: 2,
                    child: ListTile(
                      onTap: () {
                        isClicked = 0;
                        context.read<PlaningCubit>().updateStatusToInitial();
                        context.push(WesyPages.myPlan);
                      },
                      title: Text(
                        l10n.my_planing,
                        style: CsTextStyle.bodyText1.copyWith(
                          fontWeight: CsFontWeight.bold,
                        ),
                      ),
                      subtitle: Text(l10n.view_plan),
                      trailing: const Icon(
                        Icons.navigate_next,
                        size: 30,
                      ),
                    ),
                  );
                },
              ),
              Gap(context.minBlockVertical * 3.0),
              if (appState.user.roles!.length != 1)
                BlocBuilder<PlaningCubit, PlaningState>(
                  builder: (context, state) {
                    return Card(
                      elevation: 2,
                      child: ListTile(
                        onTap: () {
                          if (isClicked == 0) {
                            context
                                .read<PlaningCubit>()
                                .getUsers(appState.user.roles!.length);
                            isClicked++;
                          } else {
                            context
                                .read<PlaningCubit>()
                                .updateStatusToInitial();
                            isClicked = 0;
                          }
                        },
                        title: Text(
                          l10n.user_plan,
                          style: CsTextStyle.bodyText1.copyWith(
                            fontWeight: CsFontWeight.bold,
                          ),
                        ),
                        subtitle: Text(l10n.user_plan_content),
                        trailing: state.status != PlaningStatus.initial
                            ? const Icon(
                                Icons.navigate_before,
                                size: 30,
                              )
                            : const Icon(
                                Icons.navigate_next,
                                size: 30,
                              ),
                      ),
                    );
                  },
                ),
              Gap(context.minBlockVertical * 3.0),
              BlocBuilder<PlaningCubit, PlaningState>(
                builder: (context, state) {
                  if (state.status == PlaningStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.status == PlaningStatus.initial) {
                    return Container();
                  } else if (state.status == PlaningStatus.success) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (appState.user.roles!.length == 3)
                              Text(
                                'Workers',
                                style: CsTextStyle.bodyText1.copyWith(
                                  fontWeight: CsFontWeight.bold,
                                ),
                              ),
                            Column(
                              children: List.generate(
                                state.workers.length,
                                (index) => ListTile(
                                  onTap: () {
                                    context.push(
                                      '${WesyPages.userPlaning}/${state.workers[index].id}',
                                    );
                                  },
                                  title: Text(
                                    '${state.workers[index].firstName} ${state.workers[index].lastName}',
                                  ),
                                  subtitle: Text(
                                    '${state.workers[index].email}',
                                  ),
                                ),
                              ),
                            ),
                            if (appState.user.roles!.length == 3)
                              Text(
                                'Admin',
                                style: CsTextStyle.bodyText1.copyWith(
                                  fontWeight: CsFontWeight.bold,
                                ),
                              ),
                            Column(
                              children: List.generate(
                                state.admins.length,
                                (index) => ListTile(
                                  onTap: () {
                                    context.push(
                                      '${WesyPages.userPlaning}/${state.admins[index].id}',
                                    );
                                  },
                                  title: Text(
                                    '${state.admins[index].firstName} ${state.admins[index].lastName}',
                                  ),
                                  subtitle: Text(
                                    '${state.admins[index].email}',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              Card(
                elevation: 2,
                child: ListTile(
                  onTap: () {
                    context.push(WesyPages.addBroadcast);
                  },
                  title: Text(
                    l10n.broadcast_schedule,
                    style: CsTextStyle.bodyText1.copyWith(
                      fontWeight: CsFontWeight.bold,
                    ),
                  ),
                  subtitle: const Text('Set schedules for users'),
                  trailing: const Icon(
                    Icons.navigate_next,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
