import 'package:cs_repository/cs_repository.dart';
import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:wesy/information/cubit/add_information_cubit.dart';
import 'package:wesy/note/note.dart';
import 'package:wesy/visit/visit.dart';

extension AddDialogX on BuildContext {
  Future<void> addNoteDialog({
    Key? key,
    GlobalKey<FormState>? formKey,
    required AddNoteCubit addNoteCubit,
    required String pinId,
  }) {
    final l10n = AppLocalizations.of(this)!;
    final noteController = TextEditingController();
    return showDialog<void>(
      context: this,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          key: key ?? const Key('0'),
          backgroundColor: CsColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          children: <Widget>[
            Center(
              child: Text(
                l10n.add_note,
                style: CsTextStyle.headline4.copyWith(
                  fontWeight: CsFontWeight.bold,
                ),
              ),
            ),
            const Divider(),
            BlocBuilder<AddNoteCubit, AddNoteState>(
              bloc: addNoteCubit,
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextArea(
                          controller: noteController,
                          hintText: l10n.enter_note,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Note cannot be empty';
                            }
                            return null;
                          },
                        ),
                        Gap(context.minBlockVertical * 3.0),
                        LoaderButton(
                          text: l10n.submit,
                          isLoading: state is AddNoteLoading,
                          onPressed: () {
                            if (formKey!.currentState!.validate()) {
                              addNoteCubit.addNote(
                                note: noteController.text,
                                pinId: pinId,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> addVisitDialog({
    Key? key,
    GlobalKey<FormState>? formKey,
    required CsRepository csRepository,
    required String pinId,
    required int role,
    required AddVisitCubit addVisitCubit,
  }) {
    final l10n = AppLocalizations.of(this)!;
    final noteController = TextEditingController();
    final dateController = TextEditingController();
    return showDialog<void>(
      context: this,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          key: key ?? const Key('0'),
          backgroundColor: CsColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          children: <Widget>[
            Center(
              child: Text(
                l10n.add_visit,
                style: CsTextStyle.headline4.copyWith(
                  fontWeight: CsFontWeight.bold,
                ),
              ),
            ),
            const Divider(),
            BlocBuilder<AddVisitCubit, AddVisitState>(
              bloc: addVisitCubit,
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        if (role == 3)
                          DateInputBox(
                            hintText: l10n.date_of_visit,
                            validator: (DateTime? e) => (e?.day ?? 0) == 1
                                ? 'Please not the first day'
                                : null,
                            onChanged: (value) {
                              dateController.text = value.toString();
                            },
                          ),
                        Gap(context.minBlockVertical * 3.0),
                        TextArea(
                          controller: noteController,
                          hintText: l10n.notes,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Notes cannot be empty';
                            }
                            return null;
                          },
                        ),
                        Gap(context.minBlockVertical * 3.0),
                        LoaderButton(
                          text: l10n.submit,
                          isLoading: state is AddVisitLoading,
                          onPressed: () {
                            if (formKey!.currentState!.validate()) {
                              addVisitCubit.addVisit(
                                pinId: pinId,
                                visitDate: dateController.text,
                                visitNote: noteController.text,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> addImportantInfo({
    Key? key,
    GlobalKey<FormState>? formKey,
    required String pinId,
    required String currentNote,
    required AddInformationCubit addInformationCubit,
  }) {
    final l10n = AppLocalizations.of(this)!;
    final noteController = TextEditingController(text: currentNote);
    return showDialog<void>(
      context: this,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          key: key ?? const Key('0'),
          backgroundColor: CsColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          children: <Widget>[
            Center(
              child: Text(
                l10n.add_note,
                style: CsTextStyle.headline4.copyWith(
                  fontWeight: CsFontWeight.bold,
                ),
              ),
            ),
            const Divider(),
            BlocBuilder<AddInformationCubit, AddInformationState>(
              bloc: addInformationCubit,
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextArea(
                          controller: noteController,
                          hintText: l10n.notes,
                          maxLines: 6,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Notes cannot be empty';
                            }
                            return null;
                          },
                        ),
                        Gap(context.minBlockVertical * 3.0),
                        LoaderButton(
                          text: l10n.submit,
                          isLoading:
                              state.status == AddInformationStatus.loading,
                          onPressed: noteController.text.isEmpty
                              ? null
                              : () {
                                  if (formKey!.currentState!.validate()) {
                                    addInformationCubit.addInformation(
                                      pinId: pinId,
                                      info: noteController.text,
                                    );
                                  }
                                },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showCamOrGalletDialog({
    VoidCallback? onGalleryClick,
    VoidCallback? onCameraClick,
  }) {
    final l10n = AppLocalizations.of(this)!;
    return showDialog<void>(
      context: this,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WillPopScope(
          // for testing, for now this will be true, should be changed to false later
          onWillPop: () async => true,
          child: SimpleDialog(
            elevation: 0,
            backgroundColor: CsColors.white,
            contentPadding:
                const EdgeInsets.only(top: 40, bottom: 40, left: 20, right: 20),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: InkResponse(
                      onTap: onGalleryClick,
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'gallery'.svg,
                            color: CsColors.primary,
                          ),
                          Gap(context.minBlockVertical * 2.0),
                          Text(
                            l10n.gallery,
                            textAlign: TextAlign.center,
                            style: CsTextStyle.smallText.copyWith(
                              color: CsColors.primary,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkResponse(
                      onTap: onCameraClick,
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'camera'.svg,
                            color: CsColors.primary,
                          ),
                          Gap(context.minBlockVertical * 2.0),
                          Text(
                            l10n.take_picture,
                            textAlign: TextAlign.center,
                            style: CsTextStyle.smallText.copyWith(
                              color: CsColors.primary,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
