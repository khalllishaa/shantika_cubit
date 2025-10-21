import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shantika_cubit/utility/extensions/date_time_extensions.dart';

// import '../../../features/guard_schedule/widget/assignment_calendar_view.dart';
import '../../color.dart';
import '../../dimension.dart';
import '../../typography.dart';
import '../custom_button.dart';
import '../custom_card.dart';
import '../custom_close_button.dart';
import '../custom_dropdown_button.dart';

// ignore: must_be_immutable
class AssignmentCalendarSheet extends StatefulWidget {
  AssignmentCalendarSheet({
    super.key,
    this.onDaySelected,
    this.maxBookingHours = 12,
    this.monthCount,
  });

  final int? maxBookingHours;

  final void Function(DateTime, String?, String?)? onDaySelected;
  final int? monthCount;

  @override
  State<AssignmentCalendarSheet> createState() => _AssignmentCalendarSheetState();
}

class _AssignmentCalendarSheetState extends State<AssignmentCalendarSheet> {
  DateTime? _selectedDay;
  OptionValue? selectedStartTime;

  OptionValue? selectedEndTime;

  List<OptionValue> hoursList = List.generate(24, (index) {
    int hour = index + 1;
    return OptionValue(
      value: hour.toString(),
      label: "${hour.toString().padLeft(2, '0')}:00",
    );
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = kToolbarHeight;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final bottomSheetHeight = screenHeight - appBarHeight - statusBarHeight;

    int startTimeToInt = int.tryParse(selectedStartTime?.value ?? "0") ?? 1;
    int endTimeToInt = int.tryParse(selectedEndTime?.value ?? "0") ?? 1;

    DateFormat format = DateFormat("HH:mm");

    DateTime start = format.parse(selectedStartTime?.label ?? "00:00");
    DateTime end = format.parse(selectedEndTime?.label ?? "00:00");

    Duration difference = end.difference(start);
    int hours = difference.inHours;

    bool isValidBooking = widget.monthCount != null ? true : startTimeToInt < endTimeToInt;
    //bool isDayPicker = widget.type == DatePickerType.day;
    bool withinMaxHours = hours <= (widget.maxBookingHours ?? 12);

    return Container(
      height: bottomSheetHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(space400),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: space400),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Atur Jadwal Penugasan', style: xlSemiBold),
                  CustomCloseButton(),
                ],
              ),
              const SizedBox(height: space400),
              CustomCard(
                shadow: const [],
                borderRadius: BorderRadius.circular(12),
                color: bgFillInfo,
                padding: EdgeInsets.all(space300),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/images/ic_info.svg', color: bg),
                    SizedBox(width: space200),
                    Text('Jadwal penugasan maks. 1 hari', style: smMedium.copyWith(color: bg)),
                  ],
                ),
              ),
              const SizedBox(height: space400),
              // CustomCard(
              //     shadow: const [
              //       BoxShadow(
              //         color: Color.fromRGBO(16, 24, 40, 0.12), // Warna shadow
              //         offset: Offset(0, 5), // Posisi shadow (x: 0, y: 5)
              //         blurRadius: 15, // Seberapa blur shadow-nya
              //         spreadRadius: 0, // Seberapa luas shadow-nya
              //       ),
              //     ],
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(10),
              //     padding: EdgeInsets.all(space200),
              //     child: AssignmentCalendarView(
              //       onDaySelected: (e) {
              //         WidgetsBinding.instance.addPostFrameCallback((_) {
              //           setState(() {
              //             _selectedDay = e;
              //           });
              //         });
              //       },
              //     )),
              const SizedBox(height: space400),
              if (widget.monthCount != null) ...[
                Text('Ketersediaan Jam', style: smRegular),
                Row(
                  children: [
                    if (widget.monthCount != null)
                      Text(
                        (_selectedDay ?? DateTime.now()).convert(format: "EEEE, d MMMM y"),
                        style: smSemiBold,
                      ),
                    if (widget.monthCount != null) SizedBox(width: space400),
                    Text(
                      Jiffy.parseFromDateTime(_selectedDay ?? DateTime.now())
                          .add(months: widget.monthCount!)
                          .format(pattern: "EEEE, d MMMM y"),
                      style: smSemiBold,
                    ),
                  ],
                ),
              ] else ...[
                Row(
                  children: [
                    Text('Ketersediaan Jam, ', style: smRegular),
                    Text(
                      (_selectedDay ?? DateTime.now()).convert(format: "EEEE, d MMMM y"),
                      style: smSemiBold,
                    ),
                  ],
                ),
              ],
              const SizedBox(height: space400),
              Row(
                children: [
                  Expanded(
                    child: CustomDropDownButton(
                      getLabel: (e) => e.label,
                      titleSection: 'Mulai',
                      selectedItem: selectedStartTime,
                      dropdownItems: hoursList,
                      hint: 'Pilih waktu',
                      onChanged: (e) {
                        // setState(() {
                        //   selectedStartTime = e;
                        // });
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            selectedStartTime = e;
                          });
                        });
                      },
                    ),
                  ),
                  SizedBox(width: space400),
                  Expanded(
                    child: CustomDropDownButton(
                      getLabel: (e) => e.label,
                      titleSection: 'Selesai',
                      selectedItem: selectedEndTime,
                      dropdownItems: hoursList,
                      hint: 'Pilih waktu',
                      onChanged: (e) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            selectedEndTime = e;
                          });
                        });
                      },
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: startTimeToInt > endTimeToInt,
                child: Text(
                  'Waktu selesai tidak boleh kurang dari waktu mulai',
                  style: xsRegular.copyWith(color: iconDanger),
                ),
              ),
              Visibility(
                visible: !withinMaxHours,
                child: Text(
                  'Maksimal penyewaan adalah ${widget.maxBookingHours} Jam',
                  style: xsRegular.copyWith(color: iconDanger),
                ),
              ),
              //Spacer(),
              SizedBox(height: space400),
              CustomButton(
                onPressed: selectedStartTime != null && selectedEndTime != null && withinMaxHours
                    ? () {
                        if (isValidBooking && withinMaxHours) {
                          widget.onDaySelected?.call(
                            _selectedDay ?? DateTime.now(),
                            selectedStartTime?.label,
                            selectedEndTime?.label,
                          );
                          Navigator.pop(context);
                        }
                      }
                    : null,
                child: Text('Simpan Jadwal'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
