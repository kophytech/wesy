import 'package:cs_repository/cs_repository.dart';
import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:wesy/admin/create/bloc/create_bloc.dart';
import 'package:wesy/admin/cubit/admin_cubit.dart';
import 'package:wesy/region/cubit/region_cubit.dart';

class CreateAdminPage extends StatelessWidget {
  const CreateAdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateBloc(
        context.read<CsRepository>(),
        context.read<RegionCubit>()..getAllRegions(),
      ),
      child: CreateAdminView(),
    );
  }
}

class CreateAdminView extends StatelessWidget {
  CreateAdminView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: BlocListener<CreateBloc, CreateState>(
          listener: (context, state) {
            if (state.status == CreateStatus.loading) {
              context.showLoadingDialog();
            } else if (state.status == CreateStatus.success) {
              context.back();
              context.read<AdminCubit>().updateAdmin(state.admin);
              Future.delayed(const Duration(microseconds: 40), () {
                context.showSuccessMessage(state.successMessage);
                Future.delayed(const Duration(microseconds: 1510), () {
                  context.back();
                });
              });
            } else if (state.status == CreateStatus.failure) {
              context.back();
              Future.delayed(const Duration(microseconds: 40), () {
                context.showErrorMessage(state.errorMessage);
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    InkResponse(
                      onTap: () => context.back(),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          l10n.add_admin,
                          style: CsTextStyle.bigText.copyWith(
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
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
                                .read<CreateBloc>()
                                .add(CreateFirstNameChanged(value)),
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
                                .read<CreateBloc>()
                                .add(CreateLastNameChanged(value)),
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
                                .read<CreateBloc>()
                                .add(CreateEmailChanged(value)),
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
                                .read<CreateBloc>()
                                .add(CreatePasswordChanged(value)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password cannot be empty';
                              }
                            },
                          ),
                          Gap(context.minBlockVertical * 3.0),
                          BlocBuilder<CreateBloc, CreateState>(
                            builder: (context, state) {
                              if (state.regions.isNotEmpty) {
                                return SelectBox<String>(
                                  value: state.region,
                                  onChanged: (value) => context
                                      .read<CreateBloc>()
                                      .add(CreateRegionChanged(value!)),
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
                      ),
                    ),
                  ),
                ),
                SolidButton(
                  text: l10n.submit,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<CreateBloc>().add(const CreateSubmitted());
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
