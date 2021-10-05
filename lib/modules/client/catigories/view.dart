import 'package:flutter/material.dart';
import 'package:gadha/comman/config/constants.dart';
import 'package:gadha/comman/functions.dart';
import 'package:gadha/modules/client/quick_order/page.dart';
import 'package:gadha/modules/client/search/page.dart';
import 'package:gadha/modules/client/catigories/widgets/category_item.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:shimmer/shimmer.dart';

import 'cubit/home_categories_cubit.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCategoriesCubit, HomeCategoriesState>(
      builder: (context, state) {
        if (state is HomeCategoriesLoaded) {
          final items = state.catigores;
          return Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 95 / 86,
                crossAxisSpacing: 9,
                mainAxisSpacing: 10,
              ),
              itemCount: items.length + 1,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: size.height * 0.10),
              itemBuilder: (_, index) {
                if (index == 0) {
                  return CategoryItem(
                    imageUrl: Constants.miniLogo,
                    title: 'custom_request'.tr,
                    onTap: () => Q.to(const CustomService()),
                  );
                }
                final _newIndex = index - 1;
                final category = items[_newIndex];
                return CategoryItem(
                  imageUrl: category.imagePath,
                  title: category.name,
                  onTap: () => Q.to(SearchPage(
                    type: category.type,
                    initalKeyWord: isArabic ? category.nameAr : category.nameEn,
                  )),
                );
              },
            ),
          );
        } else if (state is HomeCategoriesCant) {
          return Center(
            child: TextButton(
              onPressed: () =>
                  BlocProvider.of<HomeCategoriesCubit>(context).refresh,
              child: Text('${state.msg}\n' + 'refresh'.tr),
            ),
          );
        }
        return _categoriesLoadingIndication();
      },
    );
  }

  Widget _categoriesLoadingIndication() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * .05),
      // padding: EdgeInsets.all(10),
      child: GridView.builder(
        padding: EdgeInsets.only(bottom: height * .10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 95 / 86,
          crossAxisSpacing: 9,
          mainAxisSpacing: 10,
        ),
        itemCount: 9,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (_, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: CategoryItem(
              title: 'category.name',
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
