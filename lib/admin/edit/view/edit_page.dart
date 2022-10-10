import 'package:cs_repository/cs_repository.dart';
import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:wesy/admin/edit/cubit/edit_admin_cubit.dart';
import 'package:wesy/region/cubit/region_cubit.dart';

class EditAdminPage extends StatelessWidget {
  const EditAdminPage({Key? key, required this.adminId}) : super(key: key);

  final String adminId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditAdminCubit(
        csRepository: context.read<CsRepository>(),
        regionCubit: context.read<RegionCubit>()..getAllRegions(),
      )
        ..getAdminDetails(adminId)
        ..onAdminIdChanged(adminId),
      child: EditAdminView(),
    );
  }
}

class EditAdminView extends StatelessWidget {
  EditAdminView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: BlocListener<EditAdminCubit, EditAdminState>(
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
                          l10n.edit_admin,
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
                  child: BlocBuilder<EditAdminCubit, EditAdminState>(
                    builder: (context, state) {
                      if (state.adminDetailsStatus ==
                          AdminDetailsStatus.success) {
                        return SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                InputBox(
                                  hintText: l10n.first_name,
                                  value: state.firstName,
                                  onChanged: context
                                      .read<EditAdminCubit>()
                                      .onFirstNameChanged,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'First Name cannot be empty';
                                    }
                                  },
                                ),
                                Gap(context.minBlockVertical * 3.0),
                                InputBox(
                                  hintText: l10n.last_name,
                                  value: state.lastName,
                                  onChanged: context
                                      .read<EditAdminCubit>()
                                      .onLastNameChanged,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Last Name cannot be empty';
                                    }
                                  },
                                ),
                                Gap(context.minBlockVertical * 3.0),
                                InputBox(
                                  hintText: l10n.email,
                                  value: state.email,
                                  onChanged: context
                                      .read<EditAdminCubit>()
                                      .onEmailChanged,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Email cannot be empty';
                                    }
                                  },
                                ),
                                Gap(context.minBlockVertical * 3.0),
                                BlocBuilder<EditAdminCubit, EditAdminState>(
                                  builder: (context, state) {
                                    if (state.regions.isNotEmpty) {
                                      return SelectBox<String>(
                                        value: state.region,
                                        onChanged: (value) => context
                                            .read<EditAdminCubit>()
                                            .onRegionChanged(value!),
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
                                Gap(context.minBlockVertical * 3.0),
                                InputBox(
                                  hintText: l10n.password,
                                  onChanged: context
                                      .read<EditAdminCubit>()
                                      .onPasswordChanged,
                                  // validator: (value) {
                                  //   if (value!.isEmpty) {
                                  //     return 'Password cannot be empty';
                                  //   }
                                  // },
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
                SolidButton(
                  text: l10n.submit,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<EditAdminCubit>().onSubmitted();
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
