import 'package:auth_repository/auth_repository.dart';
import 'package:cs_ui/cs_ui.dart';
import 'package:cs_ui/src/extension/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:wesy/app/app.dart';
import 'package:wesy/edit_profile/bloc/edit_profile_bloc.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileBloc(context.read<AuthRepository>())
        ..add(const EditProfileStarted()),
      child: const EditProfileView(),
    );
  }
}

class EditProfileView extends StatelessWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditProfileBloc>().state;
    return Scaffold(
      body: SafeArea(
        child: BlocListener<EditProfileBloc, EditProfileState>(
          listener: (context, state) {
            if (state.status == EditProfileStatus.loading) {
              context.showLoadingDialog();
            } else if (state.status == EditProfileStatus.failure) {
              context.back();
              Future.delayed(const Duration(milliseconds: 500), () {
                context.showErrorMessage(state.errorMessage);
              });
            } else if (state.status == EditProfileStatus.success) {
              context.back();
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              children: [
                const CustomAppBar(
                  title: 'Edit Profile',
                  hasAdd: false,
                ),
                Gap(context.minBlockVertical * 3.0),
                Expanded(
                  child: Column(
                    children: [
                      InputBox(
                        hintText: 'Email Address',
                        controller: TextEditingController.fromValue(
                          TextEditingValue(text: state.email),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email Address cannot be empty';
                          }
                        },
                        onChanged: (value) {},
                      ),
                      Gap(context.minBlockVertical * 3.0),
                      InputBox(
                        hintText: 'First Name',
                        controller: TextEditingController.fromValue(
                          TextEditingValue(text: state.firstName),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'First Name cannot be empty';
                          }
                        },
                        onChanged: (value) {},
                      ),
                      Gap(context.minBlockVertical * 3.0),
                      InputBox(
                        hintText: 'Last Name',
                        controller: TextEditingController.fromValue(
                          TextEditingValue(text: state.lastName),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Last Name cannot be empty';
                          }
                        },
                        onChanged: (value) {},
                      )
                    ],
                  ),
                ),
                SolidButton(
                  text: 'Submit',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
