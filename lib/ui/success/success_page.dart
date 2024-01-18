import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/generated/assets.dart';
import 'package:flutter_demo_structure/widget/app_elevated_button.dart';
import 'package:flutter_demo_structure/widget/base_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/locator/locator.dart';
import '../../values/colors.dart';
import '../../values/style.dart';
import '../lab_test/store/lab_test_store.dart';

@RoutePage()
class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  late LabTestStore labTestStore;
  late String inputTime;

  late String convertedTime;


  String convertTimeFormat(String inputTime) {
    List<String> parts = inputTime.split(' ');
    String time = parts[0];
    String amPm = parts[1];
    time = time.startsWith('0') ? time.substring(1) : time;
    time = time.endsWith(':00') ? time.substring(0, time.length - 3) : time;
    String convertedTime = '$time $amPm';

    return convertedTime;
  }

  @override
  void initState() {
    super.initState();
    labTestStore = locator<LabTestStore>();
    inputTime = labTestStore.time ?? "";
    convertedTime = convertTimeFormat(inputTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        backAction: () {},
        backgroundColor: AppColor.white,
        titleWidget: Text(
          'Success',
          style: textMedium.copyWith(color: AppColor.black, fontSize: 20.sp),
        ),
        showTitle: true,
        centerTitle: false,
        action: [
          Padding(
              padding: EdgeInsets.only(right: 5).r,
              child: Icon(
                Icons.more_vert,
                color: AppColor.lightGreen,
              ))
        ],
      ),
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15).r,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.only(left: 27, right: 38, top: 43, bottom: 55).r,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10).r,
                          border:
                              Border.all(color: AppColor.black.withOpacity(0.15))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          20.verticalSpace,
                          Image.asset(
                            Assets.imageCal,
                            width: 179.r,
                            height: 165.r,
                          ),
                          43.verticalSpace,
                          Text(
                              'Lab tests have been scheduled successfully, You will receive a mail of the same. ',
                              style: textRegular.copyWith(
                                  fontSize: 18.sp, color: AppColor.timeColor),
                              textAlign: TextAlign.center),
                          17.verticalSpace,
                          Text(
                            '${labTestStore.selectedDate} | $convertedTime',
                            style: textRegular.copyWith(
                                fontSize: 16.sp, color: AppColor.grey),
                          )
                        ],
                      ),
                    ),
                    // Expanded(child: SizedBox.shrink()),

                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15).r,
              child: SizedBox(
                width: double.maxFinite,
                height: 45.h,
                child: AppElevatedButton(
                    onPressed: () {
                      AutoRouter.of(context).popUntilRoot();
                      labTestStore.cartList.clear();
                      labTestStore.dateController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10).r),
                        elevation: 0),
                    title: Text(
                      'Back To home',
                      style: textBold.copyWith(
                          fontSize: 14.sp, color: AppColor.white),
                    )),
              ),
            ),
            15.verticalSpace
          ],
        ),
      ),
    );
  }
}
