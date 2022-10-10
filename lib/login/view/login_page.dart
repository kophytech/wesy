import 'package:auth_repository/auth_repository.dart';
import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:wesy/app/app_router.dart';
import 'package:wesy/app/bloc/app_bloc.dart';
import 'package:wesy/login/bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginBloc(authRepository: context.read<AuthRepository>())
            ..add(LoginInitial(formKey: GlobalKey<FormState>())),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final state = context.watch<LoginBloc>().state;
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: CsColors.primary,
          statusBarBrightness: Brightness.light,
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 30,
            ),
            child: AnimationLimiter(
              child: BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state.status == LoginStatus.loading) {
                    context.showLoadingDialog();
                  } else if (state.status == LoginStatus.failure) {
                    context.back();
                    Future.delayed(const Duration(microseconds: 500), () {
                      context.showErrorMessage(state.errorMessage);
                    });
                  } else if (state.status == LoginStatus.success) {
                    context.back();
                    BlocProvider.of<AppBloc>(context)
                        .add(AppUserUpdated(user: state.user));
                    Future.delayed(const Duration(microseconds: 500), () {
                      context.go(WesyPages.home);
                    });
                  }
                },
                child: Form(
                  key: state.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 375),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        horizontalOffset: 50,
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                      children: [
                        Gap(context.minBlockVertical * 5.0),
                        SvgPicture.asset(
                          'assets/svgs/auth.svg',
                          height: 150,
                        ),
                        Gap(context.minBlockVertical * 5.0),
                        Text(
                          '${l10n.welcome_back}!',
                          style: CsTextStyle.bigText,
                        ),
                        Gap(context.minBlockVertical),
                        Text(
                          l10n.login_header,
                          style: CsTextStyle.caption,
                        ),
                        Gap(context.minBlockVertical * 5.0),
                        InputBox(
                          hintText: l10n.email,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return l10n.email_error;
                            }
                          },
                          onChanged: (value) => context.read<LoginBloc>().add(
                                LoginEmailChanged(email: value),
                              ),
                        ),
                        Gap(context.minBlockVertical * 3.0),
                        InputBox(
                          hintText: l10n.password,
                          isPassword: state.passwordObsecure,
                          icon: state.passwordObsecure
                              ? Icons.visibility_off
                              : Icons.visibility,
                          onIconClick: () {
                            final passwordVisibility = state.passwordObsecure;
                            context.read<LoginBloc>().add(
                                  ObsecureChanged(value: !passwordVisibility),
                                );
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return l10n.password_error;
                            }
                          },
                          onChanged: (value) => context.read<LoginBloc>().add(
                                LoginPasswordChanged(password: value),
                              ),
                        ),
                        Gap(context.minBlockVertical * 3.0),
                        if (1 == 2)
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () => context.go(WesyPages.forgot),
                              child: Text(
                                'Forgot Password?',
                                style: CsTextStyle.caption.copyWith(
                                  color: CsColors.primary,
                                ),
                              ),
                            ),
                          ),
                        Gap(context.minBlockVertical * 3.0),
                        SolidButton(
                          text: l10n.sign_in,
                          onPressed: () => context.read<LoginBloc>().add(
                                const LoginSubmitted(),
                              ),
                        ),
                        Gap(context.minBlockVertical * 5.0),
                        if (1 == 2) ...[
                          RichText(
                            text: TextSpan(
                              text: "Don't have an account? ",
                              style: CsTextStyle.smallText.copyWith(
                                color: CsColors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Register',
                                  style: CsTextStyle.smallText.copyWith(
                                    color: CsColors.primary,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => context.go('/register'),
                                ),
                              ],
                            ),
                          ),
                          Gap(context.minBlockVertical * 5.0),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
