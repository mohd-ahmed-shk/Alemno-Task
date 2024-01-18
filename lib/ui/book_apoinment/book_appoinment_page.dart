import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/router/app_router.dart';
import 'package:flutter_demo_structure/values/colors.dart';
import 'package:flutter_demo_structure/values/export.dart';
import 'package:flutter_demo_structure/widget/base_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../core/locator/locator.dart';
import '../../widget/app_elevated_button.dart';
import '../lab_test/store/lab_test_store.dart';

@RoutePage()
class BookAppointmentPage extends StatefulWidget {
  const BookAppointmentPage({super.key});

  @override
  State<BookAppointmentPage> createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage> {
  DateTime? _selectedDay;
  late DateTime _focusedDay;
  late LabTestStore labTestStore;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    labTestStore = locator<LabTestStore>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        backgroundColor: AppColor.white,
        titleWidget: Text(
          'Book Appointment',
          style: textMedium.copyWith(fontSize: 20.sp, color: AppColor.black),
        ),
        showTitle: true,
        centerTitle: false,
        leadingWidget: Icon(Icons.arrow_back),
        leadingIcon: true,
      ),
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15).r,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Date',
                  style:
                      textBold.copyWith(fontSize: 14.sp, color: AppColor.black),
                ),
                10.verticalSpace,
                selectDate(),
                28.verticalSpace,
                Text(
                  'Select Time',
                  style:
                      textBold.copyWith(fontSize: 14.sp, color: AppColor.black),
                ),
                10.verticalSpace,
                selectTime(),
                40.verticalSpace,
                SizedBox(
                  width: double.maxFinite,
                  height: 45.h,
                  child: AppElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (_selectedDay != null) {
                            if (_controller.selectedIndex == null) {
                              text = 'Confirm';
                              _controller.selectedIndex;
                            }
                          }
                          if (_controller.selectedIndex != null) {
                            if (_selectedDay == null) {
                              text = 'Confirm';
                            }
                          }

                          if (_controller.selectedIndex != null &&
                              _selectedDay != null) {
                            context.popRoute();
                            String formattedDate = DateFormat('dd/MM/yyyy')
                                .format(_selectedDay ?? DateTime.now());
                            String appointmentDate = DateFormat('dd MMM yyyy')
                                .format(_selectedDay ?? DateTime.now());
                            labTestStore.selectedDate = appointmentDate;
                            labTestStore.dateController.text =
                                formattedDate.toString() +
                                    " " +
                                    "(${labTestStore.time})";
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: _controller.selectedIndex == null ||
                                  _selectedDay == null
                              ? AppColor.btnGrey
                              : AppColor.primaryColor,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10).r),
                          elevation: 0),
                      title: Text(
                        _controller.selectedIndex != null &&
                                _selectedDay != null
                            ? "Confirm"
                            : text,
                        style: textBold.copyWith(
                            fontSize: 14.sp, color: AppColor.white),
                      )),
                ),
                15.verticalSpace
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox selectDate() {
    return SizedBox(
      height: 280.h,
      child: Container(
        margin: EdgeInsets.only(left: 24, right: 24).r,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5).r,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ]),
        padding: EdgeInsets.symmetric(horizontal: 20).r,
        child: TableCalendar(
          focusedDay: _focusedDay,
          rowHeight: 35.r,
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            headerPadding: EdgeInsets.only(bottom: 20),
            headerMargin: EdgeInsets.zero,
            formatButtonTextStyle: TextStyle(color: AppColor.primaryColor),
            formatButtonDecoration: BoxDecoration(color: AppColor.primaryColor),
            leftChevronIcon:
                Icon(Icons.chevron_left, color: AppColor.primaryColor),
            rightChevronIcon:
                Icon(Icons.chevron_right, color: AppColor.primaryColor),
          ),
          availableGestures: AvailableGestures.all,
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 01, 01),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          calendarStyle: CalendarStyle(
            selectedDecoration: BoxDecoration(
              color: AppColor.primaryColor,
              shape: BoxShape.circle,
            ),
            isTodayHighlighted: false,
            outsideDaysVisible: false,
            selectedTextStyle: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  GroupButton<String> selectTime() {
    return GroupButton(
      options: GroupButtonOptions(
          borderRadius: BorderRadius.circular(5).r,
          selectedColor: AppColor.primaryColor,
          selectedTextStyle:
              textRegular.copyWith(fontSize: 14.sp, color: AppColor.white),
          unselectedTextStyle:
              textRegular.copyWith(fontSize: 14.sp, color: AppColor.timeColor),
          unselectedColor: AppColor.white,
          unselectedBorderColor: AppColor.primaryColor,
          crossGroupAlignment: CrossGroupAlignment.start,
          mainGroupAlignment: MainGroupAlignment.spaceBetween,
          runSpacing: 13.r,
          buttonHeight: 30.h,
          buttonWidth: 90.w,
          spacing: 30.r),
      isRadio: true,
      controller: _controller,
      buttons: _buttons,
      onSelected: (value, index, isSelected) {
        labTestStore.time = value;
        setState(() {});
      },
    );
  }

  bool navigate = false;
  String text = 'Next';
  final _controller = GroupButtonController(
    selectedIndex: null,
  );

  final _buttons = [
    "09:00 AM",
    "08:00 AM",
    "10:00 AM",
    "11:00 AM",
    "12:00 PM",
    "01:00 PM",
    "02:00 PM",
    "03:00 PM",
    "04:00 PM",
    "05:00 PM",
    "06:00 PM",
    "07:00 PM",
  ];
}
