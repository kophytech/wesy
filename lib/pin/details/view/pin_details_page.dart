import 'package:cs_repository/cs_repository.dart';
import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:wesy/app/app.dart';
import 'package:wesy/app/bloc/app_bloc.dart';
import 'package:wesy/images/cubit/add_image_cubit.dart';
import 'package:wesy/images/cubit/delete_image_cubit.dart';
import 'package:wesy/images/cubit/images_cubit.dart';
import 'package:wesy/information/cubit/add_information_cubit.dart';
import 'package:wesy/information/information.dart';
import 'package:wesy/note/note.dart';
import 'package:wesy/pin/details/cubit/pin_details_cubit.dart';
import 'package:wesy/pin/pin.dart';
import 'package:wesy/route_detail/route_detail.dart';
import 'package:wesy/visit/visit.dart';

class PinDetailsPage extends StatelessWidget {
  const PinDetailsPage({Key? key, required this.pinId, required this.type})
      : super(key: key);

  final String pinId;
  final String type;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              NoteCubit(context.read<CsRepository>())..getNotes(pinId),
        ),
        BlocProvider(
          create: (context) =>
              VisitCubit(context.read<CsRepository>())..getVisits(pinId),
        ),
        BlocProvider(
          create: (context) => InformationCubit(context.read<CsRepository>())
            ..getInformation(pinId),
        ),
        BlocProvider(
          create: (context) =>
              ImagesCubit(context.read<CsRepository>())..getImages(pinId),
        ),
        BlocProvider(
          create: (context) => DeleteVisitCubit(context.read<CsRepository>()),
        ),
        BlocProvider(
          create: (context) => DeleteNoteCubit(context.read<CsRepository>()),
        ),
        BlocProvider(
          create: (context) => AddVisitCubit(context.read<CsRepository>()),
        ),
        BlocProvider(
          create: (context) => AddNoteCubit(context.read<CsRepository>()),
        ),
        BlocProvider(
          create: (context) => AddImageCubit(context.read<CsRepository>()),
        ),
        BlocProvider(
          create: (context) => DeleteImageCubit(context.read<CsRepository>()),
        ),
        BlocProvider(
          create: (context) =>
              AddInformationCubit(context.read<CsRepository>()),
        ),
      ],
      child: PageDetailsView(
        pinId: pinId,
        type: type,
      ),
    );
  }
}

class PageDetailsView extends StatefulWidget {
  const PageDetailsView({Key? key, required this.pinId, required this.type})
      : super(key: key);
  final String pinId;
  final String type;

  @override
  State<PageDetailsView> createState() => _PageDetailsViewState();
}

class _PageDetailsViewState extends State<PageDetailsView> {
  final _visitFormKey = GlobalKey<FormState>();
  final _noteFormKey = GlobalKey<FormState>();
  final _informationFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<PinDetailsCubit>().getPinDetails(pinId: widget.pinId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppBloc>().state;
    final l10n = AppLocalizations.of(context)!;
    final detailsState = context.watch<PinDetailsCubit>().state;
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
                title: l10n.pin_details,
                hasAdd: false,
              ),
              Gap(context.minBlockVertical * 3.0),
              Expanded(
                child: BlocBuilder<PinDetailsCubit, PinDetailsState>(
                  builder: (context, state) {
                    if (state.status == PinDetailsStatus.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.status == PinDetailsStatus.success) {
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.details,
                              style: CsTextStyle.headline4,
                            ),
                            Gap(context.minBlockVertical * 2.0),
                            Card(
                              elevation: 2,
                              child: ListTile(
                                title: Text(
                                  state.details!.name ?? 'N/A',
                                  style: CsTextStyle.bodyText1.copyWith(
                                    fontWeight: CsFontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(l10n.name),
                              ),
                            ),
                            Gap(context.minBlockVertical * 2.0),
                            Card(
                              elevation: 2,
                              child: ListTile(
                                title: Text(
                                  state.details!.address ?? 'N/A',
                                  style: CsTextStyle.bodyText1.copyWith(
                                    fontWeight: CsFontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(l10n.address),
                              ),
                            ),
                            Gap(context.minBlockVertical * 2.0),
                            Card(
                              elevation: 2,
                              child: ListTile(
                                title: Text(
                                  state.details!.city ?? 'N/A',
                                  style: CsTextStyle.bodyText1.copyWith(
                                    fontWeight: CsFontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(l10n.city),
                              ),
                            ),
                            Gap(context.minBlockVertical * 2.0),
                            Card(
                              elevation: 2,
                              child: ListTile(
                                title: Text(
                                  state.details!.postalCode ?? 'N/A',
                                  style: CsTextStyle.bodyText1.copyWith(
                                    fontWeight: CsFontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(l10n.postal_code),
                              ),
                            ),
                            Gap(context.minBlockVertical * 2.0),
                            Card(
                              elevation: 2,
                              child: ListTile(
                                title: Text(
                                  state.details!.region!.name!,
                                  style: CsTextStyle.bodyText1.copyWith(
                                    fontWeight: CsFontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(l10n.region),
                              ),
                            ),
                            Gap(context.minBlockVertical * 2.0),
                            Card(
                              elevation: 2,
                              child: ListTile(
                                title: Text(
                                  state.details!.company ?? 'N/A',
                                  style: CsTextStyle.bodyText1.copyWith(
                                    fontWeight: CsFontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(l10n.company),
                              ),
                            ),
                            Gap(context.minBlockVertical * 2.0),
                            Card(
                              elevation: 2,
                              child: ListTile(
                                title: Text(
                                  state.details!.potential != null
                                      ? state
                                          .details!.potential!.capitalizeFirst
                                      : 'N/A',
                                  style: CsTextStyle.bodyText1.copyWith(
                                    fontWeight: CsFontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(l10n.potential),
                              ),
                            ),
                            Gap(context.minBlockVertical * 2.0),
                            if (widget.type.toLowerCase() ==
                                'construction') ...[
                              Card(
                                elevation: 2,
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                          left: 10,
                                          right: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              CsColors.primary.withOpacity(0.7),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Text(
                                          state.details!.constructionPhase ??
                                              'N/A',
                                          style: CsTextStyle.bodyText1.copyWith(
                                            fontWeight: CsFontWeight.bold,
                                            color: CsColors.white,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle: Text(l10n.construction_phase),
                                ),
                              ),
                              Gap(context.minBlockVertical * 2.0),
                              Card(
                                elevation: 2,
                                child: ListTile(
                                  title: Row(
                                    children: List.generate(
                                      state.details!.branches!.length,
                                      (index) => Container(
                                        padding: const EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                          left: 10,
                                          right: 10,
                                        ),
                                        margin: const EdgeInsets.only(
                                          right: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              CsColors.primary.withOpacity(0.7),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Text(
                                          state.details!.branches![index],
                                          style: CsTextStyle.bodyText1.copyWith(
                                            fontWeight: CsFontWeight.bold,
                                            color: CsColors.white,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  subtitle: Text(l10n.branch),
                                ),
                              ),
                              Gap(context.minBlockVertical * 2.0),
                              Card(
                                elevation: 2,
                                child: ListTile(
                                  title: Text(
                                    state.details!.startDate != null
                                        ? state.details!.startDate!.formatDate
                                        : 'N/A',
                                    style: CsTextStyle.bodyText1.copyWith(
                                      fontWeight: CsFontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(l10n.start_date),
                                ),
                              ),
                              Gap(context.minBlockVertical * 2.0),
                              Card(
                                elevation: 2,
                                child: ListTile(
                                  title: Text(
                                    state.details!.finishDate != null
                                        ? state.details!.finishDate!.formatDate
                                        : 'N/A',
                                    style: CsTextStyle.bodyText1.copyWith(
                                      fontWeight: CsFontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(l10n.finish_date),
                                ),
                              ),
                              Gap(context.minBlockVertical * 2.0),
                            ],
                            Card(
                              elevation: 2,
                              child: ListTile(
                                title: Text(
                                  DateFormat.yMMMEd().format(
                                    DateTime.parse(
                                      state.details!.lastUpdated ??
                                          'No Update yet',
                                    ),
                                  ),
                                  style: CsTextStyle.bodyText1.copyWith(
                                    fontWeight: CsFontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(l10n.last_updated),
                              ),
                            ),
                            Gap(context.minBlockVertical * 2.0),
                            Card(
                              elevation: 2,
                              child: ListTile(
                                title: Text(
                                  state.details!.lastVisited != null
                                      ? DateFormat.yMMMEd().format(
                                          DateTime.parse(
                                            state.details!.lastVisited!,
                                          ),
                                        )
                                      : l10n.no_visit,
                                  style: CsTextStyle.bodyText1.copyWith(
                                    fontWeight: CsFontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(l10n.last_visited),
                              ),
                            ),
                            Gap(context.minBlockVertical * 2.0),
                            RouteDetailsTitle(
                              title: l10n.important_information,
                              hasAddButton: false,
                              onTap: () {},
                            ),
                            Gap(context.minBlockVertical * 2.0),
                            BlocListener<AddInformationCubit,
                                AddInformationState>(
                              listener: (context, state) {
                                if (state.status ==
                                    AddInformationStatus.failure) {
                                  context
                                    ..back()
                                    ..showErrorMessage(state.errorMessage);
                                } else if (state.status ==
                                    AddInformationStatus.success) {
                                  context
                                    ..back()
                                    ..showSuccessMessage(state.successMessage);

                                  Future.delayed(
                                      const Duration(milliseconds: 1550), () {
                                    context
                                        .read<InformationCubit>()
                                        .getInformation(widget.pinId);
                                  });
                                }
                              },
                              child: BlocBuilder<InformationCubit,
                                  InformationState>(
                                builder: (context, state) {
                                  if (state is InformationSuccess) {
                                    return Card(
                                      elevation: 2,
                                      child: ListTile(
                                        title: Text(
                                          state.note.text?.capitalizeFirst ??
                                              '',
                                          style: CsTextStyle.bodyText1.copyWith(
                                            fontWeight: CsFontWeight.bold,
                                          ),
                                        ),
                                        trailing: IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () =>
                                              context.addImportantInfo(
                                            addInformationCubit: BlocProvider
                                                .of<AddInformationCubit>(
                                              context,
                                            ),
                                            formKey: _informationFormKey,
                                            currentNote: state.note.text ?? '',
                                            pinId: widget.pinId,
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              ),
                            ),
                            Gap(context.minBlockVertical * 2.0),
                            BlocConsumer<AddNoteCubit, AddNoteState>(
                              listener: (context, state) {
                                if (state is AddNoteSuccess) {
                                  context
                                    ..back()
                                    ..showSuccessMessage(state.success);

                                  Future.delayed(
                                      const Duration(milliseconds: 1550), () {
                                    context
                                        .read<NoteCubit>()
                                        .getNotes(widget.pinId);
                                  });
                                } else if (state is AddNoteError) {
                                  context
                                    ..back()
                                    ..showErrorMessage(state.error);
                                }
                              },
                              builder: (context, state) {
                                return RouteDetailsTitle(
                                  title: l10n.notes,
                                  onTap: () => context.addNoteDialog(
                                    formKey: _noteFormKey,
                                    pinId: widget.pinId,
                                    addNoteCubit:
                                        BlocProvider.of<AddNoteCubit>(context),
                                  ),
                                );
                              },
                            ),
                            Gap(context.minBlockVertical * 2.0),
                            BlocBuilder<NoteCubit, NoteState>(
                              builder: (context, state) {
                                if (state is NoteSuccess) {
                                  return ListView.separated(
                                    itemBuilder: (context, index) {
                                      return Card(
                                        elevation: 2,
                                        child: ListTile(
                                          title: Text(
                                            state.notes[index].text!
                                                .capitalizeFirst,
                                            style:
                                                CsTextStyle.bodyText1.copyWith(
                                              fontWeight: CsFontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Text(
                                            '${state.notes[index].by?.firstName}, ${state.notes[index].by!.lastName}',
                                          ),
                                          trailing: BlocConsumer<
                                              DeleteNoteCubit, DeleteNoteState>(
                                            listenWhen: (previous, current) =>
                                                previous != current,
                                            listener: (context, state) {
                                              if (state is DeleteNoteLoading) {
                                                context.back();
                                                Future.delayed(
                                                  const Duration(
                                                    milliseconds: 200,
                                                  ),
                                                  () => context
                                                      .showLoadingDialog(),
                                                );
                                              } else if (state
                                                  is DeleteNoteSuccess) {
                                                context
                                                  ..back()
                                                  ..showSuccessMessage(
                                                    state.success,
                                                  );
                                                Future.delayed(
                                                    const Duration(
                                                      milliseconds: 1000,
                                                    ), () {
                                                  context
                                                      .read<NoteCubit>()
                                                      .getNotes(widget.pinId);
                                                });
                                              } else if (state
                                                  is DeleteNoteError) {
                                                context
                                                  ..back()
                                                  ..showErrorMessage(
                                                    state.error,
                                                  );
                                              }
                                            },
                                            builder: (context, deletestate) {
                                              return IconButton(
                                                icon: const Icon(Icons.delete),
                                                onPressed: () => context
                                                    .showDeleteDialog(
                                                        'Delete note?',
                                                        'Deleting a note cannot be undone.',
                                                        () {
                                                  context
                                                      .read<DeleteNoteCubit>()
                                                      .deleteNote(
                                                        pinId: widget.pinId,
                                                        noteId: state
                                                            .notes[index].id!,
                                                      );
                                                }),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return Gap(
                                        context.minBlockVertical * 2.0,
                                      );
                                    },
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: state.notes.length,
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                            Gap(context.minBlockVertical * 2.0),
                            BlocConsumer<AddVisitCubit, AddVisitState>(
                              listener: (context, state) {
                                if (state is AddVisitSuccess) {
                                  context
                                    ..back()
                                    ..showSuccessMessage(state.success);
                                  Future.delayed(
                                    const Duration(milliseconds: 1550),
                                    () => context
                                        .read<VisitCubit>()
                                        .getVisits(widget.pinId),
                                  );
                                } else if (state is AddVisitFailure) {
                                  context
                                    ..back()
                                    ..showErrorMessage(state.error);
                                }
                              },
                              builder: (context, addVisitState) {
                                return RouteDetailsTitle(
                                  title: l10n.visits,
                                  onTap: () => context.addVisitDialog(
                                    formKey: _visitFormKey,
                                    addVisitCubit:
                                        BlocProvider.of<AddVisitCubit>(context),
                                    csRepository: context.read<CsRepository>(),
                                    pinId: widget.pinId,
                                    role: appState.user.roles!.length,
                                  ),
                                );
                              },
                            ),
                            Gap(context.minBlockVertical * 2.0),
                            BlocBuilder<VisitCubit, VisitState>(
                              builder: (context, state) {
                                if (state is VisitSuccess) {
                                  return ListView.separated(
                                    itemBuilder: (context, index) {
                                      return Card(
                                        elevation: 2,
                                        child: ListTile(
                                          title: Text(
                                            state.visits[index].note!,
                                            style:
                                                CsTextStyle.bodyText1.copyWith(
                                              color: CsColors.black,
                                              fontWeight: CsFontWeight.bold,
                                            ),
                                          ),
                                          subtitle: state.visits.isNotEmpty
                                              ? Text(
                                                  'Visit on ${state.visits[index].date.toString().formatDate} ${state.visits[index].date.toString().formatTime} by ${state.visits[index].by!.firstName}, ${state.visits[index].by!.lastName}',
                                                  style: CsTextStyle.caption
                                                      .copyWith(),
                                                )
                                              : Container(),
                                          trailing: BlocConsumer<
                                              DeleteVisitCubit,
                                              DeleteVisitState>(
                                            listenWhen: (previous, current) =>
                                                previous != current,
                                            listener: (context, state) {
                                              if (state is DeleteVisitLoading) {
                                                context.back();
                                                Future.delayed(
                                                  const Duration(
                                                    milliseconds: 200,
                                                  ),
                                                  () => context
                                                      .showLoadingDialog(),
                                                );
                                              } else if (state
                                                  is DeleteVisitSuccess) {
                                                context
                                                  ..back()
                                                  ..showSuccessMessage(
                                                    state.success,
                                                  );
                                                Future.delayed(
                                                  const Duration(
                                                    milliseconds: 1000,
                                                  ),
                                                  () => context
                                                      .read<VisitCubit>()
                                                      .getVisits(
                                                        widget.pinId,
                                                      ),
                                                );
                                              } else if (state
                                                  is DeleteVisitFailure) {
                                                context
                                                  ..back()
                                                  ..showErrorMessage(
                                                    state.error,
                                                  );
                                              }
                                            },
                                            builder: (context, deleteState) {
                                              return IconButton(
                                                icon: const Icon(Icons.delete),
                                                onPressed: () =>
                                                    context.showDeleteDialog(
                                                  'Delete this visit?',
                                                  'You are about to delete a visit!',
                                                  () => context
                                                    ..read<DeleteVisitCubit>()
                                                        .deleteVisit(
                                                      pinId: widget.pinId,
                                                      visitId: state
                                                          .visits[index].id!,
                                                    ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return Gap(
                                        context.minBlockVertical * 2.0,
                                      );
                                    },
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: state.visits.length,
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                            Gap(context.minBlockVertical * 2.0),
                            BlocConsumer<AddImageCubit, AddImageState>(
                              listenWhen: (previous, current) =>
                                  previous != current,
                              listener: (context, state) {
                                if (state is AddImageLoading) {
                                  context.back();
                                  Future.delayed(
                                    const Duration(milliseconds: 40),
                                    () => context.showLoadingDialog(),
                                  );
                                } else if (state is AddImageSuccess) {
                                  context
                                    ..back()
                                    ..showSuccessMessage(state.success);
                                  Future.delayed(
                                    const Duration(milliseconds: 1000),
                                    () => context
                                        .read<ImagesCubit>()
                                        .getImages(widget.pinId),
                                  );
                                } else if (state is AddImageError) {
                                  context
                                    ..back()
                                    ..showErrorMessage(state.error);
                                }
                              },
                              builder: (context, state) {
                                return RouteDetailsTitle(
                                  title: l10n.photos,
                                  onTap: () => context.showCamOrGalletDialog(
                                    onCameraClick: () async {
                                      final images = await context
                                          .read<PinDetailsCubit>()
                                          .uploadCameraImage(widget.pinId);
                                      if (images != null) {
                                        if (!mounted) return;
                                        await context
                                            .read<AddImageCubit>()
                                            .addImages(
                                              pinId: widget.pinId,
                                              images: images,
                                            );
                                      }
                                    },
                                    onGalleryClick: () async {
                                      final images = await context
                                          .read<PinDetailsCubit>()
                                          .uploadMultiImage();

                                      if (images != null) {
                                        if (!mounted) return;
                                        await context
                                            .read<AddImageCubit>()
                                            .addImages(
                                              pinId: widget.pinId,
                                              images: images,
                                            );
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                            BlocBuilder<ImagesCubit, ImagesState>(
                              builder: (context, state) {
                                if (state is ImagesSuccess) {
                                  return SizedBox(
                                    height: 200,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onLongPress: () {
                                            context
                                                .read<PinDetailsCubit>()
                                                .imageIconChanged(
                                                  !detailsState.showImageIcons,
                                                  state.images[index].id!,
                                                );
                                          },
                                          onTap: () {
                                            context
                                                .read<PinDetailsCubit>()
                                                .imageIconChanged(
                                                  false,
                                                  state.images[index].id!,
                                                );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                20,
                                              ),
                                            ),
                                            child: BlocListener<
                                                DeleteImageCubit,
                                                DeleteImageState>(
                                              listenWhen: (previous, current) =>
                                                  previous != current,
                                              listener: (context, state) {
                                                if (state
                                                    is DeleteImageLoading) {
                                                  context.back();
                                                  Future.delayed(
                                                    const Duration(
                                                      milliseconds: 200,
                                                    ),
                                                    () => context
                                                        .showLoadingDialog(),
                                                  );
                                                } else if (state
                                                    is DeleteImageSuccess) {
                                                  context
                                                    ..back()
                                                    ..showSuccessMessage(
                                                      state.success,
                                                    );

                                                  Future.delayed(
                                                      const Duration(
                                                        milliseconds: 1000,
                                                      ), () {
                                                    context
                                                        .read<ImagesCubit>()
                                                        .getImages(
                                                          widget.pinId,
                                                        );
                                                  });
                                                } else if (state
                                                    is DeleteImageError) {
                                                  context
                                                    ..back()
                                                    ..showErrorMessage(
                                                      state.error,
                                                    );
                                                }
                                              },
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    20,
                                                  ),
                                                ),
                                                clipBehavior: Clip.hardEdge,
                                                child: Container(
                                                  height: 150,
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                        state
                                                            .images[index].url!,
                                                      ),
                                                      fit: BoxFit.cover,
                                                      colorFilter: detailsState
                                                                  .showImageIcons &&
                                                              detailsState
                                                                      .selectedImageId ==
                                                                  state
                                                                      .images[
                                                                          index]
                                                                      .id!
                                                          ? ColorFilter.mode(
                                                              Colors.black
                                                                  .withOpacity(
                                                                0.5,
                                                              ),
                                                              BlendMode.darken,
                                                            )
                                                          : ColorFilter.mode(
                                                              Colors.black
                                                                  .withOpacity(
                                                                0.2,
                                                              ),
                                                              BlendMode.color,
                                                            ),
                                                    ),
                                                  ),
                                                  child: detailsState
                                                              .showImageIcons &&
                                                          detailsState
                                                                  .selectedImageId ==
                                                              state
                                                                  .images[index]
                                                                  .id!
                                                      ? Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            InkResponse(
                                                              onTap: () {},
                                                              child: Container(
                                                                height: 50,
                                                                width: 50,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  color: CsColors
                                                                      .primary,
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                child:
                                                                    const Icon(
                                                                  Icons
                                                                      .remove_red_eye,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                            InkResponse(
                                                              onTap: () => context
                                                                  .showDeleteDialog(
                                                                      'Delete this photo?',
                                                                      'You are about to delete a photo!',
                                                                      () {
                                                                context
                                                                    .read<
                                                                        DeleteImageCubit>()
                                                                    .deleteImage(
                                                                      imageId: state
                                                                          .images[
                                                                              index]
                                                                          .id!,
                                                                      pinId: widget
                                                                          .pinId,
                                                                    );
                                                              }),
                                                              child: Container(
                                                                height: 50,
                                                                width: 50,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  color: CsColors
                                                                      .primary,
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                child:
                                                                    const Icon(
                                                                  Icons.delete,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : Container(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      shrinkWrap: true,
                                      itemCount: state.images.length,
                                    ),
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                            Gap(context.minBlockVertical * 2.0),
                          ],
                        ),
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
    );
  }
}
