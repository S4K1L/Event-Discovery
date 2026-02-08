// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/style.dart';
import 'package:flutter_extension/views/base/custom_button.dart';
import 'package:flutter_extension/views/base/event_photo_picker.dart';
import 'package:flutter_extension/views/screen/common/document_loading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController participantsController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  TimeOfDay? startTime;
  TimeOfDay? endTime;
  DateTime? selectedDate;
  bool enableFee = true;
  File? coverImage;

  @override
  void initState() {
    super.initState();

    final now = TimeOfDay.now();
    startTime = now;
    endTime = TimeOfDay(hour: (now.hour + 1) % 24, minute: now.minute);
    selectedDate = DateTime.now();
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final period = time.period == DayPeriod.am ? "AM" : "PM";
    return "$hour:${time.minute.toString().padLeft(2, '0')} $period";
  }

  Future<void> _pickTime(bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStart ? startTime! : endTime!,
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.blue[50],
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: AppColors.grey[600],
          ),
        ),
        title: Text(
          'Create Event',
          style: AppTextStyles.text16(
            weight: AppTextStyles.semibold,
            color: AppColors.grey[700],
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Cover Photo",
              style: AppTextStyles.text14(weight: AppTextStyles.medium),
            ),
            const SizedBox(height: 8),

            EventCoverPhotoPicker(
              onImagePicked: (file) {
                coverImage = file;
              },
            ),

            const SizedBox(height: 20),

            _label("Event Name"),
            _input(nameController),

            _label("Event Details"),
            _input(descriptionController, maxLines: 3),

            _label("Event Time"),
            Row(
              children: [
                Expanded(child: _timeBox(startTime!, true)),
                const SizedBox(width: 12),
                Expanded(child: _timeBox(endTime!, false)),
              ],
            ),

            _label("Event Date"),
            InkWell(onTap: _pickDate, child: _dateBox()),

            _label("Event Location"),
            _input(locationController),

            _label("Event Participants"),
            _input(participantsController, keyboardType: TextInputType.number),

            const SizedBox(height: 12),

            Row(
              children: [
                Checkbox(
                  value: enableFee,
                  onChanged: (val) => setState(() => enableFee = val!),
                  activeColor: AppColors.primary,
                  checkColor: AppColors.white,
                  side: BorderSide(color: AppColors.grey[300]!, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                Text(
                  "Enable Fee",
                  style: AppTextStyles.text12(
                    weight: AppTextStyles.semibold,
                    color: AppColors.grey[700],
                  ),
                ),
              ],
            ),
            if (enableFee) ...[
              _label("Event Fee"),
              Row(
                children: [
                  /// Currency Dropdown
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.grey[300]!),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: "USD",
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.grey[600],
                          ),
                          items: ["USD", "EUR", "GBP"]
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: AppTextStyles.text14(
                                      color: AppColors.grey[300],
                                      weight: AppTextStyles.regular,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (val) {},
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  /// TO Text
                  Text(
                    "TO",
                    style: AppTextStyles.text14(
                      color: AppColors.grey[500],
                      weight: AppTextStyles.medium,
                    ),
                  ),

                  const SizedBox(width: 12),

                  /// Price Input
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.grey[300]!),
                      ),
                      child: TextField(
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "0.00",
                          border: InputBorder.none,
                          hintStyle: AppTextStyles.text14(
                            color: AppColors.grey[300],
                            weight: AppTextStyles.regular,
                          ),
                        ),
                        style: AppTextStyles.text14(
                          color: AppColors.grey[300],
                          weight: AppTextStyles.regular,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 30),

            SafeArea(
              child: CustomButton(
                onTap: () {
                  Get.to(
                    () => const DocumentLoading(
                      title: "The Event is Under Review",
                      subTitle:
                          "Thank you for create event in our platform! Our team is reviewing the information. After the review the event will live",
                    ),
                  );
                },
                text: "Create Event",
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6, top: 16),
    child: Text(
      text,
      style: AppTextStyles.text12(
        weight: AppTextStyles.semibold,
        color: AppColors.grey[900],
      ),
    ),
  );

  Widget _input(
    TextEditingController controller, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.grey[200]!),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _timeBox(TimeOfDay time, bool isStart) {
    return InkWell(
      onTap: () => _pickTime(isStart),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.grey[300]!),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_formatTime(time)),
            SvgPicture.asset(
              "assets/icons/clock.svg",
              width: 18,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _dateBox() {
    final date = selectedDate ?? DateTime.now();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey[300]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("${date.day}/${date.month}/${date.year}"),
          Icon(
            Icons.calendar_today_outlined,
            size: 18,
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
