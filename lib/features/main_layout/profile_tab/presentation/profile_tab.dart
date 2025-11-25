import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/config/shered_perferences.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/routes_manager/routes.dart';
import '../../../../core/widget/custom_elevated_button.dart';
import '../../../../core/widget/main_text_field.dart';
import '../../../../core/widget/validators.dart';
import '../../../auth/presentation/manger/auth_cubit.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  ProfileTabState createState() => ProfileTabState();
}

class ProfileTabState extends State<ProfileTab> {
  bool isFullNameReadOnly = true;
  bool isEmailReadOnly = true;
  bool isPasswordReadOnly = true;
  bool isMobileNumberReadOnly = true;
  bool isAddressReadOnly = true;

  /// han3mal initial stae hereeeee ///
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// mean getprofile when enter screen ////
    context.read<AuthCubit>().getProfie();

    /// getprofile//////
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p20),
      child: SafeArea(
        child: SingleChildScrollView(
          /// when i update data to apis ///// to be read
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (BuildContext context, AuthState state) {
              if (state is UpdateProfieSuccess) {
                context.read<AuthCubit>().getProfie();
              }
            },
            builder: (context, state) {
              var cubit = context.read<AuthCubit>();
              var model = cubit.modelProfile?.payload;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppSize.s20.h),
                  Text(
                    'Welcome, ${model?.name ?? ''}',
                    style: getSemiBoldStyle(
                        color: ColorManager.primary, fontSize: FontSize.s18),
                  ),
                  Text(
                    model?.email ?? '',
                    style: getRegularStyle(
                        color: ColorManager.primary.withOpacity(.5),
                        fontSize: FontSize.s14),
                  ),
                  SizedBox(height: AppSize.s18.h),
                  BuildTextField(
                    borderBackgroundColor: ColorManager.primary.withOpacity(.5),
                    readOnly: isFullNameReadOnly,
                    backgroundColor: ColorManager.white,
                    hint: 'Enter your full name',
                    label: 'Full Name',
                    controller: cubit.nameC,
                    labelTextStyle: getMediumStyle(
                        color: ColorManager.primary, fontSize: FontSize.s18),
                    suffixIcon: IconButton(
                      icon: SvgPicture.asset(SvgAssets.edit),
                      onPressed: () {
                        setState(() {
                          isFullNameReadOnly = false;
                        });
                      },
                    ),
                    textInputType: TextInputType.text,
                    validation: AppValidators.validateFullName,
                    hintTextStyle: getRegularStyle(color: ColorManager.primary)
                        .copyWith(fontSize: 18.sp),
                  ),
                  SizedBox(height: AppSize.s18.h),
                  BuildTextField(
                    borderBackgroundColor: ColorManager.primary.withOpacity(.5),
                    readOnly: isEmailReadOnly,
                    backgroundColor: ColorManager.white,
                    hint: 'Enter your email address',
                    label: 'E-mail address',
                    controller: cubit.emailC,
                    labelTextStyle: getMediumStyle(
                        color: ColorManager.primary, fontSize: FontSize.s18),
                    suffixIcon: IconButton(
                      icon: SvgPicture.asset(SvgAssets.edit),
                      onPressed: () {
                        setState(() {
                          isEmailReadOnly = false;
                        });
                      },
                    ),
                    textInputType: TextInputType.emailAddress,
                    validation: AppValidators.validateEmail,
                    hintTextStyle: getRegularStyle(color: ColorManager.primary)
                        .copyWith(fontSize: 18.sp),
                  ),
                  SizedBox(height: AppSize.s18.h),
                  SizedBox(height: AppSize.s18.h),
                  BuildTextField(
                    controller: cubit.phoneC,
                    borderBackgroundColor: ColorManager.primary.withOpacity(.5),
                    readOnly: isMobileNumberReadOnly,
                    backgroundColor: ColorManager.white,
                    hint: 'Enter your mobile no.',
                    label: 'Your mobile number',
                    labelTextStyle: getMediumStyle(
                        color: ColorManager.primary, fontSize: FontSize.s18),
                    suffixIcon: IconButton(
                      icon: SvgPicture.asset(SvgAssets.edit),
                      onPressed: () {
                        setState(() {
                          isMobileNumberReadOnly = false;
                        });
                      },
                    ),
                    textInputType: TextInputType.phone,
                    validation: AppValidators.validatePhoneNumber,
                    hintTextStyle: getRegularStyle(color: ColorManager.primary)
                        .copyWith(fontSize: 18.sp),
                  ),
                  SizedBox(height: AppSize.s18.h),
                  BuildTextField(
                    controller: cubit.genderC,
                    borderBackgroundColor: ColorManager.primary.withOpacity(.5),
                    readOnly: isAddressReadOnly,
                    backgroundColor: ColorManager.white,
                    hint: 'male',
                    label: 'Gender',
                    labelTextStyle: getMediumStyle(
                        color: ColorManager.primary, fontSize: FontSize.s18),
                    suffixIcon: IconButton(
                      icon: SvgPicture.asset(SvgAssets.edit),
                      onPressed: () {
                        setState(() {
                          isAddressReadOnly = false;
                        });
                      },
                    ),
                    textInputType: TextInputType.streetAddress,
                    validation: AppValidators.validateFullName,
                    hintTextStyle: getRegularStyle(color: ColorManager.primary)
                        .copyWith(fontSize: 18.sp),
                  ),
                  SizedBox(height: AppSize.s50.h),
                  state is UpdateProfieLoading
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                          ],
                        )
                      : CustomElevatedButton(
                          // borderRadius: AppSize.s8,
                          label: ' Updateprofile',
                          backgroundColor: ColorManager.white,
                          textStyle: getBoldStyle(
                              color: ColorManager.primary,
                              fontSize: AppSize.s20),
                          onTap: () {
                            cubit.updateProfie();
                          },
                        ),
                  CustomElevatedButton(
                    // borderRadius: AppSize.s8,
                    label: ' logout profile',
                    backgroundColor: ColorManager.white,
                    textStyle: getBoldStyle(
                        color: ColorManager.primary, fontSize: AppSize.s20),
                    onTap: () async {
                      await CashHelper.removeData(
                          key: MyCashKey.token);
                      Navigator.pushNamedAndRemoveUntil(
                          context, Routes.signInRoute, (routes) => false);
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
