import 'package:auth_repository/auth_repository.dart';
import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:wesy/app/app.dart';
import 'package:wesy/change_password/bloc/change_password_bloc.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordBloc(context.read<AuthRepository>()),
      child: ChangePasswordView(),
    );
  }
}

class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: BlocListener<ChangePasswordBloc, ChangePasswordState>(
          listener: (context, state) {
            if (state.status == ChangePasswordStatus.loading) {
              context.showLoadingDialog();
            } else if (state.status == ChangePasswordStatus.failure) {
              context.back();
              Future.delayed(const Duration(milliseconds: 500), () {
                context.showErrorMessage(state.errorMessage);
              });
            } else if (state.status == ChangePasswordStatus.success) {
              context.back();
              Future.delayed(const Duration(milliseconds: 500), () {
                context.showSuccessMessage(state.successMessage);
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
                  title: l10n.change_password,
                  hasAdd: false,
                ),
                Gap(context.minBlockVertical * 5.0),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        InputBox(
                          hintText: l10n.current_password,
                          isPassword: true,
                          onChanged: (value) =>
                              context.read<ChangePasswordBloc>().add(
                                    ChangePasswordCurrentChanged(value),
                                  ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Current Password cannot be empty';
                            }
                          },
                        ),
                        Gap(context.minBlockVertical * 3.0),
                        InputBox(
                          hintText: l10n.new_password,
                          isPassword: true,
                          onChanged: (value) =>
                              context.read<ChangePasswordBloc>().add(
                                    ChangePasswordNewChanged(value),
                                  ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'New Password cannot be empty';
                            }
                            if (value.length < 8) {
                              return 'New Password cannot be less than 8 characters';
                            }
                          },
                        ),
                        Gap(context.minBlockVertical * 3.0),
                        BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                          builder: (context, state) {
                            return InputBox(
                              hintText: l10n.new_password_again,
                              isPassword: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'New Password Again cannot be empty';
                                }
                                if (state.newPassword != value) {
                                  return 'New Password does not match';
                                }
                              },
                              onChanged: (value) {},
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SolidButton(
                  text: l10n.submit,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context
                          .read<ChangePasswordBloc>()
                          .add(const ChangePasswordSubmitted());
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
