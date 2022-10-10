import 'package:cs_repository/cs_repository.dart';
import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:wesy/app/app.dart';
import 'package:wesy/app/bloc/app_bloc.dart';
import 'package:wesy/edit_worker/cubit/edit_worker_cubit.dart';
import 'package:wesy/region/cubit/region_cubit.dart';

class EditWorkerPage extends StatelessWidget {
  const EditWorkerPage({Key? key, required this.workerId}) : super(key: key);

  final String workerId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditWorkerCubit(
        csRepository: context.read<CsRepository>(),
        regionCubit: context.read<RegionCubit>()..getAllRegions(),
      )
        ..getWorkerDetails(workerId)
        ..onWorkerIdChanged(workerId),
      child: EditWorkerView(),
    );
  }
}

class EditWorkerView extends StatelessWidget {
  EditWorkerView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final app = context.read<AppBloc>().state;
    return Scaffold(
      body: SafeArea(
        child: BlocListener<EditWorkerCubit, EditWorkerState>(
          listener: (context, state) {
            if (state.status == EditStatus.loading) {
              context.showLoadingDialog();
            } else if (state.status == EditStatus.success) {
              context.back();
              Future.delayed(const Duration(microseconds: 500), () {
                context.showSuccessMessage(state.successMessage);
              });
            } else if (state.status == EditStatus.failure) {
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
                const CustomAppBar(
                  title: 'Edit Worker',
                  hasAdd: false,
                ),
                Gap(context.minBlockVertical * 3.0),
                Expanded(
                  child: BlocBuilder<EditWorkerCubit, EditWorkerState>(
                    builder: (context, state) {
                      if (state.workerDetailsStatus ==
                          WorkerDetailsStatus.success) {
                        return SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                InputBox(
                                  hintText: 'First Name',
                                  value: state.firstName,
                                  onChanged: context
                                      .read<EditWorkerCubit>()
                                      .onFirstNameChanged,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'First Name cannot be empty';
                                    }
                                  },
                                ),
                                Gap(context.minBlockVertical * 3.0),
                                InputBox(
                                  hintText: 'Last Name',
                                  value: state.lastName,
                                  onChanged: context
                                      .read<EditWorkerCubit>()
                                      .onLastNameChanged,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Last Name cannot be empty';
                                    }
                                  },
                                ),
                                Gap(context.minBlockVertical * 3.0),
                                InputBox(
                                  hintText: 'Email',
                                  value: state.email,
                                  onChanged: context
                                      .read<EditWorkerCubit>()
                                      .onEmailChanged,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Email cannot be empty';
                                    }
                                  },
                                ),
                                Gap(context.minBlockVertical * 3.0),
                                InputBox(
                                  hintText: 'Password',
                                  onChanged: context
                                      .read<EditWorkerCubit>()
                                      .onPasswordChanged,
                                  // validator: (value) {
                                  //   if (value!.isEmpty) {
                                  //     return 'Password cannot be empty';
                                  //   }
                                  // },
                                ),
                                if (app.user.roles!.length == 3) ...[
                                  Gap(context.minBlockVertical * 3.0),
                                  BlocBuilder<EditWorkerCubit, EditWorkerState>(
                                    builder: (context, state) {
                                      if (state.regions.isNotEmpty) {
                                        return SelectBox<String>(
                                          value: state.region,
                                          onChanged: (value) => context
                                              .read<EditWorkerCubit>()
                                              .onRegionChanged,
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
                                              child:
                                                  Text('No Region Available'),
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
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
                SolidButton(
                  text: 'Submit',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<EditWorkerCubit>().onSubmitted();
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
