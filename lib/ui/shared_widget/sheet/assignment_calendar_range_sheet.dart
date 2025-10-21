import 'package:flutter/material.dart';
import 'package:shantika_cubit/utility/extensions/date_time_extensions.dart';

// import '../../../features/guard_schedule/widget/assignment_calendar_range_view.dart';
import '../../color.dart';
import '../../dimension.dart';
import '../../typography.dart';
import '../custom_button.dart';
import '../custom_card.dart';
import '../custom_close_button.dart';
import '../custom_dropdown_button.dart';

// ignore: must_be_immutable
class AssignmentCalendarRangeSheet extends StatefulWidget {
  AssignmentCalendarRangeSheet({
    super.key,
    this.onDateRangeSelected,
  });

  final Function(DateTime? startDate, DateTime? endDate, String? startTime, String? endTime)? onDateRangeSelected;

  @override
  State<AssignmentCalendarRangeSheet> createState() => _AssignmentCalendarRangeSheetState();
}

class _AssignmentCalendarRangeSheetState extends State<AssignmentCalendarRangeSheet> {
  DateTime? _startDate;
  DateTime? _endDate;
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

    bool isValidBooking = (_startDate ?? DateTime.now()).add(Duration(hours: startTimeToInt)).isBefore(
          (_endDate ?? DateTime.now()).add(Duration(hours: endTimeToInt)),
        );

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
                shadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(16, 24, 40, 0.12), // Warna shadow
                    offset: Offset(0, 5), // Posisi shadow (x: 0, y: 5)
                    blurRadius: 15, // Seberapa blur shadow-nya
                    spreadRadius: 0, // Seberapa luas shadow-nya
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                padding: EdgeInsets.all(space200),
                child: Column(),
                // child: AssignmentCalendarRangeView(
                //   onRangeSelected: (startDate, endDate) {
                //     WidgetsBinding.instance.addPostFrameCallback((_) {
                //       setState(() {
                //         _startDate = startDate;
                //         _endDate = endDate;
                //       });
                //     });
                //   },
                // ),
              ),
              const SizedBox(height: space400),
              Row(
                children: [
                  Text('Ketersediaan Pada : ', style: smRegular),
                ],
              ),
              Text(
                '${(_startDate ?? DateTime.now()).convert(format: "EEEE, d MMMM y")} - ${(_endDate ?? DateTime.now()).convert(format: "EEEE, d MMMM y")}',
                style: smSemiBold,
              ),
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
                visible: !isValidBooking,
                child: Text(
                  'Waktu selesai tidak boleh kurang dari waktu mulai',
                  style: xsRegular.copyWith(color: iconDanger),
                ),
              ),
              SizedBox(height: space400),
              CustomButton(
                onPressed: selectedStartTime != null && selectedEndTime != null
                    ? () {
                        if (isValidBooking) {
                          widget.onDateRangeSelected?.call(
                            _startDate ?? DateTime.now(),
                            _endDate ?? DateTime.now(),
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
