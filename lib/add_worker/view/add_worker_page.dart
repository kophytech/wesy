import 'package:cs_repository/cs_repository.dart';
import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:wesy/add_worker/bloc/add_worker_bloc.dart';
import 'package:wesy/app/app.dart';
import 'package:wesy/app/bloc/app_bloc.dart';
import 'package:wesy/region/cubit/region_cubit.dart';
import 'package:wesy/worker/cubit/worker_cubit.dart';

class AddWorkerPage extends StatelessWidget {
  const AddWorkerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddWorkerBloc(
        context.read<CsRepository>(),
        BlocProvider.of<RegionCubit>(context)..getAllRegions(),
      ),
      child: AddWorkerView(),
    );
  }
}

class AddWorkerView extends StatelessWidget {
  AddWorkerView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final app = context.read<AppBloc>().state;
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AddWorkerBloc, AddWorkerState>(
          listener: (context, state) {
            if (state.status == AddWorkerStatus.loading) {
              context.showLoadingDialog();
            } else if (state.status == AddWorkerStatus.success) {
              context.back();
              Future.delayed(const Duration(microseconds: 500), () {
                context.showSuccessMessage(state.successMessage);
                context.read<WorkerCubit>().updateWorker(state.worker);
                Future.delayed(const Duration(microseconds: 1510), () {
                  context.back();
                });
              });
            } else if (state.status == AddWorkerStatus.failure) {
              context.back();
              Future.delayed(const Duration(microseconds: 500), () {
                context.showErrorMessage(state.errorMessage);
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                CustomAppBar(
                  title: l10n.add_worker,
                  hasAdd: false,
                ),
                Gap(context.minBlockVertical * 3.0),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          InputBox(
                            hintText: l10n.first_name,
                            onChanged: (value) => context
                                .read<AddWorkerBloc>()
                                .add(AddWorkerFirstNameChanged(value)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'First Name cannot be empty';
                              }
                            },
                          ),
                          Gap(context.minBlockVertical * 3.0),
                          InputBox(
                            hintText: l10n.last_name,
                            onChanged: (value) => context
                                .read<AddWorkerBloc>()
                                .add(AddWorkerLastNameChanged(value)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Last Name cannot be empty';
                              }
                            },
                          ),
                          Gap(context.minBlockVertical * 3.0),
                          InputBox(
                            hintText: l10n.email,
                            onChanged: (value) => context
                                .read<AddWorkerBloc>()
                                .add(AddWorkerEmailChanged(value)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email cannot be empty';
                              }
                            },
                          ),
                          Gap(context.minBlockVertical * 3.0),
                          InputBox(
                            hintText: l10n.password,
                            onChanged: (value) => context
                                .read<AddWorkerBloc>()
                                .add(AddWorkerPasswordChanged(value)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password cannot be empty';
                              }
                            },
                          ),
                          if (app.user.roles!.length == 3) ...[
                            Gap(context.minBlockVertical * 3.0),
                            BlocBuilder<AddWorkerBloc, AddWorkerState>(
                              builder: (context, state) {
                                if (state.regions.isNotEmpty) {
                                  return SelectBox<String>(
                                    value: state.region,
                                    onChanged: (value) => context
                                        .read<AddWorkerBloc>()
                                        .add(AddWorkerRegionChanged(value!)),
                                    items: state.regions.map((e) {
                                      return DropdownMenuItem(
                                        value: e.id ?? '',
                                        child: Text(e.name ?? 'N/A'),
                                      );
                                    }).toList(),
                                    validator: (dynamic value) {
                                      if (value.toString().isEmpty) {
                                        return 'Region cannot be empty';
                                      }
                                    },
                                  );
                                } else {
                                  return SelectBox(
                                    value: '',
                                    onChanged: (value) {},
                                    items: const [
                                      DropdownMenuItem(
                                        value: '',
                                        child: Text('No Region Available'),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
                SolidButton(
                  text: l10n.submit,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AddWorkerBloc>().add(
                            const AddWorkerSubmitted(),
                          );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
