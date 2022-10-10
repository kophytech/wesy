import 'dart:async';

import 'package:cs_repository/cs_repository.dart';
import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wesy/app/app.dart';
import 'package:wesy/app/bloc/app_bloc.dart';
import 'package:wesy/route_detail/cubit/route_detail_cubit.dart';
import 'package:wesy/route_detail/route_detail.dart';

class RouteDetailPage extends StatelessWidget {
  const RouteDetailPage({Key? key, required this.routeId}) : super(key: key);

  final String routeId;

  @override
  Widget build(BuildContext context) {
    return RouteDetailView(routeId: routeId);
  }
}

class RouteDetailView extends StatefulWidget {
  const RouteDetailView({Key? key, this.routeId}) : super(key: key);

  final String? routeId;

  @override
  State<RouteDetailView> createState() => _RouteDetailViewState();
}

class _RouteDetailViewState extends State<RouteDetailView> {
  Set<Polyline> polyLines = {};

  PolylinePoints polylinePoints = PolylinePoints();

  List<LatLng> polylineCoordinates = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<RouteDetailCubit>(context).initialize();
      context.read<RouteDetailCubit>().getRouteDetails(routeId: widget.routeId);
      context.read<AppBloc>().add(const AppGetCurrentLocation());
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<RouteDetailCubit>().state;
    final l10n = AppLocalizations.of(context)!;
    final appState = context.watch<AppBloc>().state;
    return Scaffold(
      body: SafeArea(
        child: MultiBlocListener(
          listeners: [
            BlocListener<RouteDetailCubit, RouteDetailState>(
              listenWhen: (previous, current) =>
                  previous.locationStatus != current.locationStatus,
              listener: (context, state) {
                if (state.locationStatus == LocationStatus.loading) {
                  context.back();
                  Future.delayed(const Duration(microseconds: 20), () {
                    context.showLoadingDialog();
                  });
                } else if (state.locationStatus == LocationStatus.success) {
                  context.back();
                  Future.delayed(const Duration(microseconds: 20), () {
                    context.showSuccessMessage(state.successMessage);
                  });
                  Future.delayed(const Duration(microseconds: 1600), () {
                    context
                        .read<RouteDetailCubit>()
                        .getRouteDetails(routeId: widget.routeId);
                  });
                } else if (state.locationStatus == LocationStatus.failure) {
                  context.back();
                  Future.delayed(const Duration(microseconds: 500), () {
                    context.showErrorMessage(state.errorMessage);
                  });
                }
              },
            ),
            BlocListener<RouteDetailCubit, RouteDetailState>(
              listenWhen: (previous, current) =>
                  previous.workerStatus != current.workerStatus,
              listener: (context, state) {
                if (state.workerStatus == WorkerStatus.loading) {
                  Future.delayed(const Duration(microseconds: 20), () {
                    context.showLoadingDialog();
                  });
                } else if (state.workerStatus == WorkerStatus.success) {
                  context.back();
                  Future.delayed(const Duration(microseconds: 20), () {
                    context.showSuccessMessage(state.successMessage);
                  });
                  Future.delayed(const Duration(microseconds: 1600), () {
                    context
                        .read<RouteDetailCubit>()
                        .getRouteDetails(routeId: widget.routeId);
                  });
                } else if (state.workerStatus == WorkerStatus.failure) {
                  context.back();
                  Future.delayed(const Duration(microseconds: 20), () {
                    context.showErrorMessage(state.errorMessage);
                  });
                }
              },
            ),
          ],
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              children: [
                CustomAppBar(
                  title: state.details.name != null ? state.details.name! : '',
                  hasAdd: false,
                ),
                Gap(context.minBlockVertical * 3.0),
                Expanded(
                  child: BlocBuilder<RouteDetailCubit, RouteDetailState>(
                    buildWhen: (previous, current) =>
                        previous.status != current.status,
                    builder: (context, state) {
                      if (state.status == RouteDetailStatus.loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state.status == RouteDetailStatus.success) {
                        final _controller = Completer<GoogleMapController>();

                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.route_info,
                                style: CsTextStyle.headline4,
                              ),
                              Gap(context.minBlockVertical * 2.0),
                              Card(
                                elevation: 2,
                                child: ListTile(
                                  title: Text(
                                    state.details.routeType!.capitalizeFirst,
                                    style: CsTextStyle.bodyText1.copyWith(
                                      fontWeight: CsFontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(l10n.route_type),
                                ),
                              ),
                              Gap(context.minBlockVertical * 2.0),
                              Card(
                                elevation: 2,
                                child: ListTile(
                                  title: Text(
                                    state.details.createdBy != null
                                        ? state.details.createdBy!.name!
                                        : '',
                                    style: CsTextStyle.bodyText1.copyWith(
                                      fontWeight: CsFontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(l10n.region),
                                ),
                              ),
                              Gap(context.minBlockVertical * 2.0),
                              RouteDetailsTitle(
                                title: l10n.worker,
                                onTap: () {
                                  context.read<RouteDetailCubit>().getWorkers(
                                        region: state.details.createdBy!.id,
                                      );
                                  context.showWorkersDialog(
                                    csRepository: context.read<CsRepository>(),
                                    region: state.details.createdBy!.id,
                                    availableWorkers: state.details.workers,
                                    routeId: state.details.id,
                                  );
                                },
                              ),
                              Gap(context.minBlockVertical * 2.0),
                              ListView.separated(
                                itemBuilder: (context, index) {
                                  return Card(
                                    elevation: 2,
                                    child: ListTile(
                                      title: Text(
                                        '${state.details.workers![index].firstName} ${state.details.workers![index].lastName}',
                                        style: CsTextStyle.bodyText1.copyWith(
                                          fontWeight: CsFontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        state.details.workers![index].email!,
                                      ),
                                      leading: const CircleAvatar(
                                        child: Icon(Icons.person),
                                      ),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () =>
                                            context.showDeleteDialog(
                                          l10n.remove_worker,
                                          l10n.worker_action,
                                          () {
                                            context.back();
                                            Future.delayed(
                                                const Duration(
                                                  microseconds: 30,
                                                ), () {
                                              context
                                                  .read<RouteDetailCubit>()
                                                  .deleteWorker(
                                                    routeId: widget.routeId,
                                                    workerId: state.details
                                                        .workers![index].id,
                                                  );
                                            });
                                          },
                                          cancel: l10n.cancel,
                                          delete: l10n.delete,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Gap(context.minBlockVertical * 2.0);
                                },
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.details.workers!.length,
                              ),
                              Gap(context.minBlockVertical * 2.0),
                              RouteDetailsTitle(
                                title: l10n.location_pin,
                                onTap: () {
                                  context.push(
                                    '${WesyPages.addPin}/${state.details.id}?type=${state.details.routeType}',
                                  );
                                },
                              ),
                              Gap(context.minBlockVertical * 2.0),
                              BlocBuilder<RouteDetailCubit, RouteDetailState>(
                                builder: (context, state) {
                                  return ReorderableListView.builder(
                                    itemBuilder: (context, index) {
                                      if (state.details.pins != null &&
                                          state.details.pins!.isNotEmpty) {
                                        context
                                            .read<RouteDetailCubit>()
                                            .onMarkerChanged(
                                              Marker(
                                                markerId: MarkerId(
                                                  state.details.pins![index]
                                                          .id ??
                                                      '',
                                                ),
                                                position: LatLng(
                                                  state.details.pins![index]
                                                      .coordinates!.first,
                                                  state.details.pins![index]
                                                      .coordinates!.last,
                                                ),
                                                onTap: () async {
                                                  final newCurrentLocation = await Geolocator.getCurrentPosition();
                                                  // final newCurrentLocationLatLng = LatLng(
                                                  //   newCurrentLocation.latitude,
                                                  //   newCurrentLocation.longitude,
                                                  // );
                                                  final currentLocation =
                                                      appState.currentLocation;
                                                  final url =
                                                      'https://www.google.com/maps/dir/?api=1&origin=${newCurrentLocation.latitude},${newCurrentLocation.longitude}&destination=${state.details.pins![index].coordinates!.first},${state.details.pins![index].coordinates!.last}&dir_action=navigate';
                                                  print(url);
                                                  final uri = Uri.parse(url);
                                                  if (await canLaunchUrl(
                                                    uri,
                                                  )) {
                                                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                                                  } else {
                                                    throw 'Could not launch $uri';
                                                  }
                                                },
                                                // anchor: const Offset(0.5, 0.5),
                                              ),
                                            );
                                      }
                                      return Card(
                                        key: ValueKey(index),
                                        elevation: 2,
                                        child: ListTile(
                                          onTap: () => context.push(
                                            '${WesyPages.pinDetails}/${state.details.pins![index].id}?type=${state.details.routeType}',
                                          ),
                                          title: Text(
                                            state.details.pins![index].name!
                                                .capitalizeFirst,
                                            style:
                                                CsTextStyle.bodyText1.copyWith(
                                              fontWeight: CsFontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Text(
                                            '${state.details.pins![index].address}, ${state.details.pins![index].city}',
                                          ),
                                          leading: SizedBox(
                                            height: 35,
                                            width: 35,
                                            child: SvgPicture.asset(
                                              'assets/svgs/marker.svg',
                                            ),
                                          ),
                                          trailing: IconButton(
                                            icon: const Icon(Icons.delete),
                                            onPressed: () =>
                                                context.showDeleteDialog(
                                              'Delete this location?',
                                              'This action is irreversible.',
                                              () => context
                                                  .read<RouteDetailCubit>()
                                                  .deleteLocation(
                                                    routeId: widget.routeId,
                                                    locationId: state.details
                                                        .pins![index].id,
                                                  ),
                                              cancel: l10n.cancel,
                                              delete: l10n.delete,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    onReorder: (index, newIndex) async {
                                      final response = await context
                                          .read<RouteDetailCubit>()
                                          .changePinPosition(
                                            index,
                                            newIndex,
                                            widget.routeId ?? '',
                                          );
                                      if (response != null) {
                                        if (!mounted) return;
                                        context.showSuccessMessage(response);
                                      } else {
                                        if (!mounted) return;
                                        context.showErrorMessage(
                                          'Unable to rearrange pin',
                                        );
                                      }
                                    },
                                    // separatorBuilder: (context, index) {
                                    //   return Gap(context.minBlockVertical * 2.0);
                                    // },
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: state.details.pins!.length,
                                  );
                                },
                              ),
                              Gap(context.minBlockVertical * 2.0),
                              BlocBuilder<RouteDetailCubit, RouteDetailState>(
                                builder: (context, state) {
                                  if (state.details.pins != null &&
                                      state.details.pins!.isNotEmpty) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: SizedBox(
                                        height: 500,
                                        width: context.screenWidth,
                                        child: Stack(
                                          children: [
                                            GoogleMap(
                                              onMapCreated:
                                                  _controller.complete,
                                              initialCameraPosition:
                                                  CameraPosition(
                                                target: LatLng(
                                                  state.details.pins!.first
                                                      .coordinates!.first,
                                                  state.details.pins!.first
                                                      .coordinates!.last,
                                                ),
                                                zoom: 16.4746,
                                              ),
                                              gestureRecognizers: {}..add(
                                                  Factory<TapGestureRecognizer>(
                                                    () =>
                                                        TapGestureRecognizer(),
                                                  ),
                                                ),
                                              markers: state.markers.isNotEmpty
                                                  ? state.markers
                                                  : {
                                                      Marker(
                                                        markerId: MarkerId(
                                                          state.details.pins!
                                                                  .first.id ??
                                                              '',
                                                        ),
                                                        position: LatLng(
                                                          state
                                                              .details
                                                              .pins!
                                                              .first
                                                              .coordinates!
                                                              .first,
                                                          state
                                                              .details
                                                              .pins!
                                                              .first
                                                              .coordinates!
                                                              .last,
                                                        ),
                                                      ),
                                                    },
                                              // polylines: polyLines,
                                              myLocationButtonEnabled: false,
                                              // compassEnabled: false,
                                            ),
                                            if (1 == 2)
                                              Positioned(
                                                bottom: 5,
                                                right: 5,
                                                child: Row(
                                                  children: [
                                                    InkResponse(
                                                      onTap: () async {
                                                        final controller =
                                                            await _controller
                                                                .future;

                                                        // controller.animateCamera(cameraUpdate)
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              CsColors.primary,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: const Icon(
                                                          Icons.add,
                                                          color: CsColors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    InkResponse(
                                                      onTap: () {},
                                                      child: Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              CsColors.primary,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: const Icon(
                                                          Icons.remove,
                                                          color: CsColors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
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
                              )
                            ],
                          ),
                        );
                      } else if (state.status == RouteDetailStatus.failure) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
