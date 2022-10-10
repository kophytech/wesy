import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        child: SingleChildScrollView(
          child: AnimationLimiter(
            child: Column(
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
                    'assets/svgs/register.svg',
                    height: 150,
                  ),
                  Gap(context.minBlockVertical * 5.0),
                  Text(
                    'Create new account',
                    style: CsTextStyle.bigText,
                  ),
                  Gap(context.minBlockVertical),
                  Text(
                    'Register to get started',
                    style: CsTextStyle.caption,
                  ),
                  Gap(context.minBlockVertical * 5.0),
                  const InputBox(
                    hintText: 'Full Name',
                  ),
                  Gap(context.minBlockVertical * 3.0),
                  const InputBox(
                    hintText: 'Email',
                  ),
                  Gap(context.minBlockVertical * 3.0),
                  const InputBox(
                    hintText: 'Password',
                  ),
                  Gap(context.minBlockVertical * 5.0),
                  SolidButton(
                    text: 'Register',
                    onPressed: () {},
                  ),
                  Gap(context.minBlockVertical * 5.0),
                  RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
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
                            ..onTap = () => context.go('/login'),
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
    );
  }
}
