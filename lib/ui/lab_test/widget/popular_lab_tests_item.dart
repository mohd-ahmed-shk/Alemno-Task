import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/model/lab_test/popular/popular_model.dart';
import '../../../generated/assets.dart';
import '../../../values/colors.dart';
import '../../../values/style.dart';
import '../../../widget/app_elevated_button.dart';
import '../store/lab_test_store.dart';

class PopularLabTestsItem extends StatelessWidget {
  final PopularModel popularData;
  final LabTestStore labTestStore;
  const PopularLabTestsItem({super.key, required this.popularData, required this.labTestStore});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 31.sp,
          decoration: BoxDecoration(
              color: AppColor.primaryColor.withOpacity(0.8),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(5).r,
                topLeft: Radius.circular(5).r,
              )),
          child: Center(
            child: Text(
              popularData.diagnosticTitle,
              style: textBold.copyWith(color: AppColor.white, fontSize: 10.sp),
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5).r,
                bottomRight: Radius.circular(5).r,
              ),
              border: Border.all(color: AppColor.black.withOpacity(0.15)),
            ),
            child: Padding(
              padding: EdgeInsets.all(10).r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        popularData.testNumber,
                        style: textRegular.copyWith(
                            color: AppColor.titleColor, fontSize: 11.sp),
                      ),
                      Container(
                        width: 22.r,
                        height: 20.r,
                        decoration: BoxDecoration(
                            color: AppColor.lightGreen,
                            borderRadius: BorderRadius.circular(2).r),
                        child: Image.asset(
                          Assets.imageCheck,
                        ),
                      )
                    ],
                  ),
                  14.verticalSpace,
                  Text(
                    popularData.getReport,
                    style: textRegular.copyWith(
                        color: AppColor.titleColor, fontSize: 7.sp),
                  ),
                  1.5.verticalSpace,
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: '₹ '),
                          TextSpan(
                            text: popularData.amount.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                              text: ' ${popularData.discount}',
                              style: textMedium.copyWith(
                                  fontSize: 6.5.sp,
                                  color: AppColor.titleColor,
                                  decoration: TextDecoration.lineThrough)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    height: 26.h,
                    child: Observer(
                      builder: (context) {
                        return AppElevatedButton(
                            onPressed: () {
                              Timer(
                                Duration(seconds: 1),
                                    () {
                                  if (labTestStore.cartList
                                      .contains(popularData)) {
                                    labTestStore.cartList.remove(popularData);
                                  } else {
                                    labTestStore.cartList.add(popularData);
                                  }
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5)).r),
                                elevation: 0,
                                backgroundColor:
                                labTestStore.cartList.contains(popularData)
                                    ? AppColor.grey
                                    : AppColor.primaryColor),
                            title: Text(
                              labTestStore.cartList.contains(popularData)
                                  ? 'Added to cart'
                                  : 'Add to cart',
                              style: textBold.copyWith(
                                  color: AppColor.white, fontSize: 8.sp),
                            ));
                      },
                    ),
                  ),
                  3.5.verticalSpace,
                  SizedBox(
                    width: double.maxFinite,
                    height: 26.h,
                    child: TextButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(5)).r,
                            side: BorderSide(color: AppColor.primaryColor)),
                        elevation: 0,
                      ),
                      child: Text(
                        'View Details',
                        style: textBold.copyWith(
                            color: AppColor.primaryColor, fontSize: 8.sp),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
