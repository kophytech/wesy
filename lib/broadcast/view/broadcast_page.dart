import 'package:cs_repository/cs_repository.dart';
import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wesy/app/app.dart';
import 'package:wesy/app/bloc/app_bloc.dart';
import 'package:wesy/broadcast/cubit/broadcast_cubit.dart';
import 'package:wesy/users/users.dart';

class BroadcastPage extends StatelessWidget {
  const BroadcastPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppBloc>().state;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UsersCubit(context.read<CsRepository>())
            ..getUsers(appState.user.roles!.length),
        ),
        BlocProvider(
          create: (context) => BroadcastCubit(context.read<CsRepository>()),
        ),
      ],
      child: const BroadcastView(),
    );
  }
}

class BroadcastView extends StatelessWidget {
  const BroadcastView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppBloc>().state;
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: BlocListener<BroadcastCubit, BroadcastState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == BroadcastStatus.loading) {
            context.showLoadingDialog();
          } else if (state.status == BroadcastStatus.success) {
            context.back();
            Future.delayed(
              const Duration(milliseconds: 40),
              () {
                context.showSuccessMessage(state.successMessage);
                Future.delayed(
                  const Duration(milliseconds: 1550),
                  () {
                    context.back();
                  },
                );
              },
            );
          } else if (state.status == BroadcastStatus.error) {
            context.back();
            Future.delayed(
              const Duration(milliseconds: 40),
              () => context.showErrorMessage(state.errorMessage),
            );
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              children: [
                CustomAppBar(
                  title: l10n.broadcast_schedule,
                  onAddPressed: () => context.back(),
                  hasAdd: false,
                ),
                Gap(context.minBlockVertical * 5.0),
                Expanded(
                  child: Column(
                    children: [
                      InputBox(
                        hintText: l10n.title,
                        onChanged:
                            context.read<BroadcastCubit>().onTitleChanged,
                      ),
                      Gap(context.minBlockVertical * 3),
                      DateInputBox(
                        hintText: l10n.start_date,
                        validator: (DateTime? e) => (e?.day ?? 0) == 1
                            ? 'Please not the first day'
                            : null,
                        onChanged: (value) => context
                            .read<BroadcastCubit>()
                            .onStartDateChanged(value.toIso8601String()),
                      ),
                      Gap(context.minBlockVertical * 3),
                      DateInputBox(
                        hintText: l10n.finish_date,
                        validator: (DateTime? e) => (e?.day ?? 0) == 1
                            ? 'Please not the first day'
                            : null,
                        onChanged: (value) => context
                            .read<BroadcastCubit>()
                            .onEndDateChanged(value.toIso8601String()),
                      ),
                      Gap(context.minBlockVertical * 3),
                      TextArea(
                        hintText: l10n.notes,
                        onChanged: context.read<BroadcastCubit>().onNoteChanged,
                      ),
                      Gap(context.minBlockVertical * 3),
                      BlocBuilder<UsersCubit, UsersState>(
                        builder: (context, state) {
                          if (state is UsersError) {
                            return SelectBox<String>(
                              value: '',
                              items: [
                                SelectBoxItem<String>(
                                  value: '',
                                  child: Text(l10n.no_recipients),
                                ),
                              ],
                            );
                          } else if (state is UsersSuccess) {
                            return UsersDropDown(
                              labelText: l10n.choose_recipients,
                              usersCubit: BlocProvider.of<UsersCubit>(context),
                              users: state.users,
                              onchanged: context
                                  .read<BroadcastCubit>()
                                  .onRecipientsChanged,
                            );
                          } else {
                            return SelectBox<String>(
                              value: '',
                              items: [
                                SelectBoxItem<String>(
                                  value: '',
                                  child: Text('${l10n.loading}...'),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                      Gap(context.minBlockVertical * 3),
                      BlocBuilder<BroadcastCubit, BroadcastState>(
                        builder: (context, state) {
                          return SolidButton(
                            text: l10n.submit,
                            onPressed: state.buttonEnabled &&
                                    state.status != BroadcastStatus.loading
                                ? () =>
                                    context.read<BroadcastCubit>().onSubmitted()
                                : null,
                          );
                        },
                      ),
                    ],
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
