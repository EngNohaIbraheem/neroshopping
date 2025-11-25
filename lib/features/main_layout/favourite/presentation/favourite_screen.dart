import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/constants_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../auth/presentation/manger/auth_cubit.dart';
import '../../home/presentation/home_tab.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<AuthCubit>()
        .getFavoriteList;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSize.s14.w, vertical: AppSize.s10.h),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return ListView.builder(
              itemCount: AppConstants.favoriteProducts.length,
              itemBuilder: (context, index) {
                var list = context
                    .read<AuthCubit>()
                    .shopFavoriteList?.payload;
                return ShopItem();
                //   Padding(
                //   padding: EdgeInsets.symmetric(vertical: AppSize.s12.h),
                //   child:
                //       FavoriteItem(product: AppConstants.favoriteProducts[index]),
                // );
              },
            );
          },
        ));
  }
}
