import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/core/locator/locator.dart';
import 'package:flutter_demo_structure/data/model/lab_test/popular/popular_list.dart';
import 'package:flutter_demo_structure/router/app_router.dart';
import 'package:flutter_demo_structure/ui/lab_test/store/lab_test_store.dart';
import 'package:flutter_demo_structure/ui/lab_test/widget/popular_lab_tests_item.dart';
import 'package:flutter_demo_structure/ui/lab_test/widget/popular_packages_item.dart';
import 'package:flutter_demo_structure/values/colors.dart';
import 'package:flutter_demo_structure/values/export.dart';
import 'package:flutter_demo_structure/widget/base_app_bar.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/model/lab_test/packages/packages_list.dart';
import '../../data/model/lab_test/packages/packages_model.dart';
import '../../data/model/lab_test/popular/popular_model.dart';

@RoutePage()
class LabTestPage extends StatefulWidget {
  const LabTestPage({super.key});

  @override
  State<LabTestPage> createState() => _LabTestPageState();
}

class _LabTestPageState extends State<LabTestPage> {
  late LabTestStore labTestStore;

  // String buttonText = 'Click me!';
  // Color buttonColor = Colors.blue;
  //
  // void changeButtonState() {
  //   // Change the button text and color
  //   setState(() {
  //     buttonText = 'Changed!';
  //     buttonColor = Colors.green;
  //   });
  //
  //   // Revert to the original state after 2 seconds
  //   Future.delayed(Duration(seconds: 2), () {
  //     setState(() {
  //       buttonText = 'Click me!';
  //       buttonColor = Colors.blue;
  //     });
  //   });
  // }

  @override
  void initState() {
    super.initState();
    labTestStore = locator<LabTestStore>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        automaticallyImplyLeading: false,
        showTitle: true,
        titleWidget: Text(
          'Logo',
          style:
              textRegular.copyWith(color: AppColor.titleColor, fontSize: 20.sp),
        ),
        action: [
          Observer(
            builder: (context) {
              return SizedBox(
                  height: 15.r,
                  width: 15.r,
                  child: labTestStore.cartList.isEmpty
                      ? SizedBox.shrink()
                      : Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.primaryColor),
                          child: Center(
                              child: Text(
                            labTestStore.cartList.length.toString(),
                            style: textRegular.copyWith(color: AppColor.white,fontSize: 10.sp),
                          )),
                        ));
            },
          ),
          InkWell(
            onTap: () {
              AutoRouter.of(context).push(MyCartRoute());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20).r,
              child: Icon(Icons.shopping_cart, color: AppColor.primaryColor),
            ),
          )
        ],
        backgroundColor: AppColor.white,
      ),
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15).r,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popular lab tests',
                      style: textRegular.copyWith(
                          fontSize: 20.sp, color: AppColor.primaryColor),
                    ),
                    Row(
                      children: [
                        Text(
                          'View more',
                          style: textRegular.copyWith(
                              fontSize: 11.sp,
                              color: AppColor.primaryColor,
                              decoration: TextDecoration.underline),
                        ),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 11.r,
                          color: AppColor.primaryColor,
                        )
                      ],
                    ),
                  ],
                ),
                20.verticalSpace,
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      childAspectRatio: 0.8),
                  padding: EdgeInsets.all(8.0).r,
                  itemCount: popularTestList.length,
                  itemBuilder: (context, index) {
                    PopularModel popularData = popularTestList[index];
                    return PopularLabTestsItem(popularData: popularData,labTestStore: labTestStore,);
                  },
                ),
                20.verticalSpace,
                Text(
                  'Popular Packages',
                  style: textRegular.copyWith(
                      fontSize: 20.sp, color: AppColor.primaryColor),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: packagesTestList.length,
                  itemBuilder: (context, index) {
                    PackagesModel packageData = packagesTestList[index];
                    return PopularPackagesItem(packageData: packageData);
                  },
                ),
                15.verticalSpace
              ],
            ),
          ),
        ),
      ),
    );
  }

}
