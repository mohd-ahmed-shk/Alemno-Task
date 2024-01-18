import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/model/lab_test/packages/packages_model.dart';
import '../../../generated/assets.dart';
import '../../../values/colors.dart';
import '../../../values/style.dart';

class PopularPackagesItem extends StatelessWidget {
  final PackagesModel packageData;
  const PopularPackagesItem({super.key, required this.packageData});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(left: 28, right: 28, top: 8).r,
      child: Container(
        padding: EdgeInsets.only(left: 24, right: 24, top: 15).r,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: AppColor.titleColor.withOpacity(0.2))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  Assets.imageBottle,
                  width: 60.r,
                  height: 60.r,
                ),
                Container(
                  height: 20.r,
                  padding: EdgeInsets.symmetric(horizontal: 10).r,
                  decoration: BoxDecoration(
                      color: AppColor.lightGreen,
                      borderRadius: BorderRadius.circular(2).r),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        Assets.imageCheck,
                      ),
                      10.horizontalSpace,
                      Text(
                        'Safe',
                        style: textRegular.copyWith(
                            color: AppColor.white, fontSize: 10.sp),
                      )
                    ],
                  ),
                )
              ],
            ),
            18.verticalSpace,
            Text(
              packageData.diagnosticTitle,
              style:
              textMedium.copyWith(color: AppColor.black, fontSize: 18.sp),
            ),
            Text.rich(
              style: textRegular.copyWith(
                  fontSize: 10.5.sp, color: AppColor.primaryColorLight),
              TextSpan(
                children: [
                  TextSpan(text: '${packageData.testNumber}\n'),
                  TextSpan(
                    text: ' . ${packageData.testType1}\n',
                  ),
                  TextSpan(
                    text: ' . ${packageData.testType2}\n',
                  ),
                  TextSpan(text: ' . ${packageData.amount}\n'),
                  TextSpan(
                    text: 'View more',
                    style: textRegular.copyWith(
                        decoration: TextDecoration.underline,
                        fontSize: 10.5.sp,
                        color: AppColor.primaryColorLight),
                  ),
                ],
              ),
            ),
            20.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹ ${packageData.totalAmount}/-',
                  style: textRegular.copyWith(
                      fontSize: 18.sp, color: AppColor.totalColor),
                ),
                SizedBox(
                  width: 110.w,
                  height: 26.h,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(

                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)).r,
                          side: BorderSide(color: AppColor.primaryColor)),
                      elevation: 0,
                    ),
                    child: Text(
                      'Add to cart',
                      style: textBold.copyWith(
                          color: AppColor.primaryColor, fontSize: 12.sp),
                    ),
                  ),
                )
              ],
            ),
            18.verticalSpace
          ],
        ),
      ),
    );
  }
}
