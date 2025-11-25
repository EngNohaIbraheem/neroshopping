
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/routes_manager/routes.dart';
import '../../../../core/widget/custom_elevated_button.dart';
import '../../../../core/widget/main_text_field.dart';
import '../../../../core/widget/validators.dart';
import '../manger/auth_cubit.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: AppSize.s40.h,
                ),
                // Center(child: SvgPicture.asset(SvgAssets.routeLogo)),
                SizedBox(
                  height: AppSize.s40.h,
                ),
                Text(
                  'Welcome Back ',
                  style: getBoldStyle(color: ColorManager.white)
                      .copyWith(fontSize: FontSize.s24.sp),
                ),
                Text(
                  'Please sign in with your mail',
                  style: getLightStyle(color: ColorManager.white)
                      .copyWith(fontSize: FontSize.s16.sp),
                ),
                SizedBox(
                  height: AppSize.s50.h,
                ),
                BuildTextField(
                  backgroundColor: ColorManager.white,
                  hint: 'enter your email',
                  label: 'Email',
                  textInputType: TextInputType.emailAddress,
                  validation: AppValidators.validateEmail,
                  controller: emailController,
                ),
                SizedBox(
                  height: AppSize.s28.h,
                ),
                BuildTextField(
                  hint: 'enter your password',
                  backgroundColor: ColorManager.white,
                  label: 'Password',
                  validation: AppValidators.validatePassword,
                  isObscured: true,
                  textInputType: TextInputType.text,
                  controller: passwordController,
                ),
                SizedBox(
                  height: AppSize.s8.h,
                ),
                Row(
                  children: [
                    const Spacer(),
                    GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Forget password?',
                          style: getMediumStyle(color: ColorManager.white)
                              .copyWith(fontSize: FontSize.s18.sp),
                        )),
                  ],
                ),
                SizedBox(
                  height: AppSize.s60.h,
                ),
                Center(
                  child: SizedBox(
                    /// consumer because listen to 2 state
                    /// loginsucess/// navigate ///
                    /// .....unless
                    /// /// if state in loading give circularprogress///
                    /// unless elevetedbutton press////
                    // width: MediaQuery.of(context).size.width * .8,
                    child: BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is LoginSuccess) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, Routes.mainRoute, (route) => false);
                        } else if (state is LoginErrer) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Login failed"),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return state is LoginLoading
                            ? CircularProgressIndicator()
                            : CustomElevatedButton(
                                isStadiumBorder: false,
                                label: 'Login',
                                backgroundColor: ColorManager.white,
                                textStyle: getBoldStyle(
                                    color: ColorManager.primary,
                                    fontSize: AppSize.s18),

                                /// call function login
                                onTap: () {
                                  context.read<AuthCubit>().login(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                },
                              );

                        /// elevetedbutton press active///
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don’t have an account?',
                      style: getSemiBoldStyle(color: ColorManager.white)
                          .copyWith(fontSize: FontSize.s16.sp),
                    ),
                    SizedBox(
                      width: AppSize.s8.w,
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, Routes.signUpRoute),
                      child: Text(
                        'Create Account',
                        style: getSemiBoldStyle(color: ColorManager.white)
                            .copyWith(fontSize: FontSize.s16.sp),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
