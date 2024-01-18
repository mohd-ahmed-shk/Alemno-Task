import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/generated/assets.dart';
import 'package:flutter_demo_structure/router/app_router.dart';
import 'package:flutter_demo_structure/values/colors.dart';
import 'package:flutter_demo_structure/values/export.dart';
import 'package:flutter_demo_structure/widget/app_elevated_button.dart';
import 'package:flutter_demo_structure/widget/base_app_bar.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/locator/locator.dart';
import '../../data/model/lab_test/popular/popular_model.dart';
import '../lab_test/store/lab_test_store.dart';

@RoutePage()
class MyCartPage extends StatefulWidget {
  const MyCartPage({super.key});

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  late LabTestStore labTestStore;

  @override
  void initState() {
    super.initState();
    labTestStore = locator<LabTestStore>();
    labTestStore.calculateTotalAmount();
    labTestStore.calculateTotalDiscount();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColor.white,
        leadingWidget: Icon(Icons.arrow_back),
        titleWidget: Text(
          'My Cart',
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
      body: SafeArea(child: Center(
        child: SingleChildScrollView(
          child: Observer(
            builder: (context) {
              if (labTestStore.cartList.isEmpty) {
                return Center(
                    child: Text(
                  'Empty',
                  style: textBlack,
                ));
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15).r,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Review',
                        style: textMedium.copyWith(
                            fontSize: 20.sp, color: AppColor.primaryColor),
                      ),
                      12.verticalSpace,
                      Container(
                        height: 39.h,
                        decoration: BoxDecoration(
                            color: AppColor.primaryColor.withOpacity(0.8),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5).r,
                              topLeft: Radius.circular(5).r,
                            )),
                        child: Center(
                          child: Text(
                            'Pathology tests',
                            style: textBold.copyWith(
                                color: AppColor.white, fontSize: 14.sp),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5).r,
                            bottomRight: Radius.circular(5).r,
                          ),
                          border: Border.all(
                              color: AppColor.black.withOpacity(0.15)),
                        ),
                        child: ListView.separated(
                          itemCount: labTestStore.cartList.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            PopularModel data = labTestStore.cartList[index];

                            return testItem(data, index);
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              color: AppColor.black.withOpacity(0.15),
                              endIndent: 10,
                              indent: 10,
                            );
                          },
                        ),
                      ),
                      15.verticalSpace,
                      selectDate(context),
                      15.verticalSpace,
                      amountDescription(),
                      15.verticalSpace,
                      hardCopyOfReports(),
                      15.verticalSpace,
                      SizedBox(
                          width: double.maxFinite,
                          height: 45.h,
                          child: AppElevatedButton(
                              onPressed: () {
                                if (labTestStore
                                    .dateController.text.isNotEmpty) {
                                  context.pushRoute(SuccessRoute());
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      labTestStore.dateController.text.isEmpty
                                          ? AppColor.btnGrey
                                          : AppColor.primaryColor,
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10).r),
                                  elevation: 0),
                              title: Text(
                                'Schedule',
                                style: textBold.copyWith(
                                    fontSize: 14.sp, color: AppColor.white),
                              ))),
                      15.verticalSpace
                    ],
                  ),
                );
              }
            },
          ),
        ),
      )),
    );
  }

  Container hardCopyOfReports() {
    return Container(
        padding: const EdgeInsets.all(12).r,
        decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(5).r,
            border: Border.all(color: AppColor.black.withOpacity(0.15))),
        child: InkWell(
          onTap: () {
            labTestStore.wantHardCopy();
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                labTestStore.hardCopy
                    ? Assets.imageCheckboxBase
                    : Assets.imageCheckbox,
                width: 10.r,
                height: 10.r,
              ),
              5.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hard copy of reports',
                        style: textMedium.copyWith(
                            fontSize: 11.sp,
                            color: AppColor.black.withOpacity(0.8))),
                    Text(
                      'Reports will be delivered within 3-4 working days. Hard copy charges are non-refundable once the reports have been dispatched.',
                      style: textRegular.copyWith(
                          fontSize: 11.sp, color: AppColor.grey),
                    ),
                    5.verticalSpace,
                    Text('₹150 per person',
                        style: textRegular.copyWith(
                            fontSize: 11.sp, color: AppColor.grey))
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Container amountDescription() {
    return Container(
        padding: const EdgeInsets.only(
          top: 19.19,
          left: 31,
          right: 48,
          bottom: 12.47,
        ),
        decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(5).r,
            border: Border.all(color: AppColor.black.withOpacity(0.15))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'M.R.P Total',
                  style: textRegular.copyWith(
                      fontSize: 12.sp, color: AppColor.grey),
                ),
                Text('${labTestStore.totalAmount + labTestStore.totalDiscount}',
                    style: textRegular.copyWith(
                        fontSize: 12.sp, color: AppColor.grey))
              ],
            ),
            12.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Discount',
                    style: textRegular.copyWith(
                        fontSize: 12.sp, color: AppColor.grey)),
                Text('${labTestStore.totalDiscount}',
                    style: textRegular.copyWith(
                        fontSize: 12.sp, color: AppColor.grey))
              ],
            ),
            24.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Amount to be Paid',
                    style: textBold.copyWith(
                        fontSize: 15.sp, color: AppColor.primaryColor)),
                Text('₹ ${labTestStore.totalAmount}/-',
                    style: textBold.copyWith(
                        fontSize: 15.sp, color: AppColor.primaryColor))
              ],
            ),
            40.verticalSpace,
            Row(
              children: [
                Text(
                  'Total savings',
                  style: textRegular.copyWith(
                      fontSize: 12.sp, color: AppColor.black.withOpacity(0.6)),
                ),
                20.horizontalSpace,
                Text('₹ ${labTestStore.totalDiscount}',
                    style: textRegular.copyWith(
                        fontSize: 12.sp, color: AppColor.primaryColor))
              ],
            ),
          ],
        ));
  }

  Container selectDate(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(
          top: 25.79,
          left: 14.74,
          right: 24.26,
          bottom: 25.47,
        ),
        decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(5).r,
            border: Border.all(color: AppColor.black.withOpacity(0.15))),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                context.pushRoute(BookAppointmentRoute());
              },
              child: Icon(
                Icons.calendar_month_outlined,
                size: 25.w,
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColor.black.withOpacity(0.15),
                  ),
                  borderRadius: BorderRadius.circular(5).r,
                ),
                child: Observer(
                  builder: (context) {
                    return TextFormField(
                      controller: labTestStore.dateController,
                      readOnly: true,
                      style: textMedium.copyWith(
                          color: AppColor.primaryColor, fontSize: 12.sp),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding:
                              EdgeInsets.only(top: 5, bottom: 5, left: 8).r,
                          hintText: 'Select date',
                          hintStyle: textRegular.copyWith(
                              fontSize: 12.sp, color: AppColor.grey)),
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }

  InkWell testItem(PopularModel data, int index) {
    return InkWell(
      onTap: () {
        labTestStore.calculateTotalAmount();
        labTestStore.calculateTotalDiscount();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 26, vertical: 12).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.diagnosticTitle,
                  style: textSemiBold.copyWith(
                      fontSize: 15.sp, color: AppColor.black),
                ),
                Text(
                  '₹ ${data.amount}/-',
                  style: textBold.copyWith(
                      fontSize: 16.sp, color: AppColor.lightGreen),
                )
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${data.amount + data.discount}',
                style: textRegular.copyWith(
                    fontSize: 11.sp,
                    color: AppColor.grey,
                    decoration: TextDecoration.lineThrough),
              ),
            ),
            2.verticalSpace,
            InkWell(
              onTap: () {
                labTestStore.cartList.removeAt(index);
              },
              child: SizedBox(
                width: 129.w,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12).r,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50).r,
                      border:
                          Border.all(color: AppColor.primaryColor, width: 2)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: AppColor.primaryColor,
                        size: 20.r,
                      ),
                      8.horizontalSpace,
                      Text(
                        'Remove',
                        style: textMedium.copyWith(
                            fontSize: 13.sp, color: AppColor.primaryColor),
                      )
                    ],
                  ),
                ),
              ),
            ),
            12.verticalSpace,
            Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12).r,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50).r,
                  border: Border.all(color: AppColor.primaryColor, width: 2)),
              child: Row(
                children: [
                  Icon(
                    Icons.file_upload_outlined,
                    color: AppColor.primaryColor,
                    size: 20.r,
                  ),
                  8.horizontalSpace,
                  Text(
                    'Upload prescription (optional)',
                    style: textMedium.copyWith(
                        fontSize: 13.sp, color: AppColor.primaryColor),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
