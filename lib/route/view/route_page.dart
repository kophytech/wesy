import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:wesy/app/app.dart';
import 'package:wesy/app/bloc/app_bloc.dart';
import 'package:wesy/route/cubit/route_cubit.dart';
import 'package:wesy/route/route.dart';

class RoutePage extends StatelessWidget {
  const RoutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const RouteView();
    // BlocProvider(
    //   create: (context) => RouteCubit(
    //     context.read<CsRepository>(),
    //     context.read<RegionCubit>()..getAllRegions(),
    //   )..getAllRoutes(),
    //   child: RouteView(),
    // );
  }
}

class RouteView extends StatefulWidget {
  const RouteView({Key? key}) : super(key: key);

  @override
  State<RouteView> createState() => _RouteViewState();
}

class _RouteViewState extends State<RouteView> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userRole = context.read<AppBloc>().state.user.roles;
      context.read<RouteCubit>().getAllRoutes(userRole!.length);
      context.read<RouteCubit>().updateAddRouteStatus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppBloc>().state;
    final l10n = AppLocalizations.of(context)!;
    final userRole =
        context.select((AppBloc element) => element.state.user.roles);
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () =>
              context.read<RouteCubit>().getAllRoutes(userRole!.length),
          child: BlocListener<RouteCubit, RouteState>(
            listener: (context, state) {
              if (state.addRouteStatus == AddRouteStatus.success) {
                context.back();
                Future.delayed(const Duration(microseconds: 500), () {
                  context.showSuccessMessage(state.successMessage);
                });
                context.read<RouteCubit>().updateAddRouteStatus();
              } else if (state.addRouteStatus == AddRouteStatus.failure) {
                context.back();
                Future.delayed(const Duration(microseconds: 500), () {
                  context.showErrorMessage(state.errorMessage);
                });
                context.read<RouteCubit>().updateAddRouteStatus();
              }

              if (state.deleteStatus == DeleteStatus.loading) {
                context.back();
                Future.delayed(const Duration(microseconds: 500), () {
                  context.showLoadingDialog();
                });
              } else if (state.deleteStatus == DeleteStatus.success) {
                context.back();
                Future.delayed(const Duration(microseconds: 500), () {
                  context.showSuccessMessage(state.successMessage);
                });
                Future.delayed(const Duration(microseconds: 1000), () {
                  context.read<RouteCubit>().getAllRoutes(userRole!.length);
                });
              } else if (state.deleteStatus == DeleteStatus.failure) {
                context.back();
                Future.delayed(const Duration(microseconds: 500), () {
                  context.showErrorMessage(state.errorMessage);
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Column(
                children: [
                  CustomAppBar(
                    title: l10n.route,
                    hasAdd: app.user.roles!.length != 1,
                    onAddPressed: () => context.showAddRouteDialog(
                      formKey: _formKey,
                      isAdmin: app.user.roles!.length == 2,
                      onSubmitted: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<RouteCubit>().createRoute(
                                hasRegion: app.user.roles!.length != 2,
                              );
                        }
                      },
                    ),
                  ),
                  Gap(context.minBlockVertical * 3.0),
                  Expanded(
                    child: BlocBuilder<RouteCubit, RouteState>(
                      builder: (context, state) {
                        if (state.status == RouteStatus.loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state.status == RouteStatus.success) {
                          return CustomDataTable(
                            length: state.routes.length,
                            width: 550,
                            title: [
                              DataTableTitleTile(
                                text: 'S/N',
                                onPressed: () {},
                              ),
                              DataTableTitleTile(
                                text: l10n.name,
                                width: 150,
                                onPressed: () {},
                              ),
                              DataTableTitleTile(
                                text: l10n.cities,
                                width: 200,
                                onPressed: () {},
                              ),
                              DataTableTitleTile(
                                text: l10n.branch,
                                width: 150,
                                onPressed: () {},
                              ),
                              DataTableTitleTile(
                                text: '',
                                width: 50,
                                onPressed: () {},
                              ),
                            ],
                            row: (context, index) {
                              return Row(
                                children: [
                                  ColumnTile(
                                    text: state.routes[index].name!.capitalize,
                                    width: 150,
                                    isLink: true,
                                    onTap: () => context.push(
                                      '${WesyPages.routeDetails}/${state.routes[index].id}',
                                    ),
                                  ),
                                  ColumnTile(
                                    text: state.routes[index].pins!.isNotEmpty
                                        ? state.routes[index].pins!
                                            .map(
                                              (e) => e.city!.capitalizeFirst,
                                            )
                                            .join(', ')
                                        : l10n.no_location,
                                    width: 200,
                                  ),
                                  ColumnTile(
                                    text: state
                                            .routes[index].routeType!.isNotEmpty
                                        ? state.routes[index].routeType!
                                            .capitalizeFirst
                                        : 'N/A',
                                    width: 150,
                                  ),
                                  PopupMenuButton<String>(
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          child: const Text('View'),
                                          onTap: () => context.push(
                                            '${WesyPages.routeDetails}/${state.routes[index].id}',
                                          ),
                                        ),
                                        PopupMenuItem(
                                          child: const Text('Delete'),
                                          onTap: () {
                                            context.back();
                                            Future.delayed(
                                                const Duration(
                                                  microseconds: 500,
                                                ), () {
                                              context.showDeleteDialog(
                                                'Delete this route?',
                                                'This action is irreversible.',
                                                () => context
                                                    .read<RouteCubit>()
                                                    .deleteRoute(
                                                      routeId: state
                                                          .routes[index].id,
                                                    ),
                                              );
                                            });
                                          },
                                        )
                                      ];
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      alignment: Alignment.centerLeft,
                                      child: const Icon(Icons.more_vert),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        } else if (state.status == RouteStatus.failure) {
                          return CustomDataTable(
                            length: state.routes.length,
                            width: 550,
                            title: [
                              DataTableTitleTile(
                                text: 'S/N',
                                onPressed: () {},
                              ),
                              DataTableTitleTile(
                                text: l10n.name,
                                onPressed: () {},
                              ),
                              DataTableTitleTile(
                                text: l10n.cities,
                                onPressed: () {},
                              ),
                              DataTableTitleTile(
                                text: l10n.branch,
                                onPressed: () {},
                              ),
                            ],
                            row: (context, index) {
                              return Container();
                            },
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
