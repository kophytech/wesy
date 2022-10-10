import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:wesy/app/app_router.dart';

class ForgotPage extends StatelessWidget {
  const ForgotPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      'Reset Password',
                      style: CsTextStyle.bigText,
                    ),
                    Gap(context.minBlockVertical),
                    Text(
                      'Enter your email to continue',
                      style: CsTextStyle.caption,
                    ),
                    Gap(context.minBlockVertical * 5.0),
                    const InputBox(
                      hintText: 'Email',
                    ),
                    Gap(context.minBlockVertical * 3.0),
                    SolidButton(
                      text: 'Submit',
                      onPressed: () => context.go('/home'),
                    ),
                    Gap(context.minBlockVertical * 5.0),
                    RichText(
                      text: TextSpan(
                        text: 'Remember password? ',
                        style: CsTextStyle.smallText.copyWith(
                          color: CsColors.black,
                        ),
                        children: [
                          TextSpan(
                            text: 'Login',
                            style: CsTextStyle.smallText.copyWith(
                              color: CsColors.primary,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => context.go(WesyPages.login),
                          ),
                        ],
                      ),
                    ),
                    Gap(context.minBlockVertical * 5.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
