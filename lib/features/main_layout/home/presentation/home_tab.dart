import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neroshopping/features/main_layout/home/presentation/widgets/custom_category_widget.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../auth/presentation/manger/auth_cubit.dart';
import 'widgets/custom_ads_widget.dart';
import 'widgets/custom_section_bar.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _currentIndex = 0;
  late Timer _timer;

  final List<String> adsImages = [
    ImageAssets.carouselSlider1,
    ImageAssets.carouselSlider2,
    ImageAssets.carouselSlider3,
  ];

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getShops();
    _startImageSwitching();
  }

  void _startImageSwitching() {
    _timer = Timer.periodic(const Duration(milliseconds: 2500), (Timer timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % adsImages.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomAdsWidget(
            adsImages: adsImages,
            currentIndex: _currentIndex,
            timer: _timer,
          ),
          Column(
            children: [
              CustomSectionBar(sectionNname: 'Categories', function: () {}),
              SizedBox(
                height: 270.h,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return const CustomCategoryWidget();
                  },
                  itemCount: 20,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AddOrRemoveFavoriteSuccess) {
                    context.read<AuthCubit>().getShops();
                  }
                },
                builder: (context, state) {
                  var cubit = context.read<AuthCubit>();
                  var listShop = cubit.shopModel?.payload;
                  return listShop == null
                      ? CircularProgressIndicator()
                      : ListView.builder(
                          shrinkWrap: true,
                    itemCount: listShop.length, // ✅ حل المشكلة هنا
                    physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var item = listShop[index];
                            var isFavorite = item.isFavorited == 1? true : false ;
                            return ShopItem(
                              image: item.pictureUrl,
                              name: item.name,
                              phone: item.description,
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite
                                    ? Colors.redAccent
                                    : Colors.black,
                              ),
                              onFavoriteTap: () {
                                cubit.addOrRemoveFavorite(item.id);
                                item.isFavorited = item.isFavorited == 1 ? 0 : 1;
                                setState(() {}); // فقط لو بتستخدمي StatefulWidget
                              },
                            );
                          },
                        );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ShopItem extends StatelessWidget {
  const ShopItem({
    super.key,
    this.image,
    this.name,
    this.phone,
    this.icon,
    this.onFavoriteTap,
  });

  final String? image;
  final String? name;
  final String? phone;
  final Icon? icon;
  final VoidCallback? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Image.network(
            image ?? '',
            width: 100,
            height: 150,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 100,
                height: 150,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.person,
                  size: 60,
                ),
              );
            },
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name ?? '',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                Text(phone ?? '',
                    style:
                        const TextStyle(fontSize: 14, color: Colors.black54)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: onFavoriteTap,
                    icon: icon ?? const SizedBox(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
