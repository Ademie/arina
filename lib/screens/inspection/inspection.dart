import 'dart:developer';
import 'package:arina/screens/chat/chat.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:ionicons/ionicons.dart';

class Inspection extends StatefulWidget {
  const Inspection({super.key});

  @override
  State<Inspection> createState() => _InspectionState();
}

final EasyInfiniteDateTimelineController _controller =
    EasyInfiniteDateTimelineController();
DateTime? _focusDate;

class _InspectionState extends State<Inspection> {
  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final hour = timeOfDay.hourOfPeriod;
    final minute = timeOfDay.minute.toString().padLeft(2, '0');
    final period = timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hour:$minute $period';
  }

  Time _time = Time(hour: 9, minute: 0, second: 0);

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
      log(newTime.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    BuildContext _context = context;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Inspection'),
        scrolledUnderElevation: 0,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          // SUMMARY CARD
          const SliverToBoxAdapter(child: SummaryCard()),
          // AVAILABILITY-DATE
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
              child: EasyInfiniteDateTimeLine(
                activeColor: const Color(0xFF303030),
                showTimelineHeader: false,
                controller: _controller,
                firstDate: DateTime.now(),
                focusDate: _focusDate,
                lastDate: DateTime.now().add(
                  const Duration(days: 7),
                ),
                onDateChange: (selectedDate) {
                  setState(() {
                    _focusDate = selectedDate;
                    log(selectedDate.millisecondsSinceEpoch.toString());
                  });
                },
              ),
            ),
          ),
          // AVAILABILITY -TIME
          SliverToBoxAdapter(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Time',
                      softWrap: true,
                      maxLines: 3,
                      style: TextStyle(
                        color: Color.fromARGB(190, 48, 48, 48),
                        fontSize: 16,
                        fontFamily: 'Gelasio',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    TextField(
                      readOnly: true,
                      controller:
                          TextEditingController(text: formatTimeOfDay(_time)),
                      onTap: () async {
                        await showModalBottomSheet(
                            context: _context,
                            builder: (context) {
                              return showPicker(
                                  context: context,
                                  isInlinePicker: true,
                                  barrierDismissible: true,
                                  elevation: 1,
                                  value: _time,
                                  onChange: onTimeChanged,
                                  minuteInterval: TimePickerInterval.THIRTY,
                                  iosStylePicker: true,
                                  minHour: 9,
                                  maxHour: 17,
                                  maxMinute: 0,
                                  is24HrFormat: false,
                                  onCancel: () {
                                    Navigator.pop(_context);
                                  });
                            });
                      },
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xFF303030),
                            width: 0.02,
                          )),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xFF303030),
                            width: 0.02,
                          )),
                          suffixIconColor: Color.fromARGB(255, 61, 24, 24),
                          suffixIcon: Icon(Ionicons.chevron_down)),
                    ),
                  ],
                )),
          ),
          // CONTACT
          SliverToBoxAdapter(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Contact',
                      softWrap: true,
                      maxLines: 3,
                      style: TextStyle(
                        color: Color.fromARGB(190, 48, 48, 48),
                        fontSize: 16,
                        fontFamily: 'Gelasio',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    TextField(
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: false),
                      controller: TextEditingController(text: ''),
                      decoration: const InputDecoration(
                          hintText: '0810000100',
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xFF303030),
                            width: 0.02,
                          )),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xFF303030),
                            width: 0.02,
                          )),
                          suffixIconColor: Color.fromARGB(255, 61, 24, 24),
                          suffixIcon: Icon(Ionicons.chevron_down)),
                    ),
                  ],
                )),
          ),
        ],
      ),
      // BOOK NOW
      bottomNavigationBar: Container(
        height: 100,
        color: Colors.white,
        padding: const EdgeInsets.only(bottom: 30, right: 25, left: 25),
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Chat()));
          },
          icon: const Icon(
            Ionicons.book,
            color: Colors.white,
          ),
          label: const Text(
            'Book Now',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Nunito Sans',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF232323),
            minimumSize: const Size(370, 60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            shadowColor: const Color(0x3F303030),
            elevation: 10,
          ),
        ),
      ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    super.key,
    this.title,
    this.imageURL,
    this.address,
    this.pricing,
  });
  final String? title;
  final String? imageURL;
  final String? address;
  final String? pricing;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(25),
      color: Colors.white,
      child: SizedBox(
        height: 150,
        child: Row(
          children: [
            // SUMMARY IMAGE
            Container(
              height: 400,
              width: 170,
              margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                image: DecorationImage(
                    image: AssetImage(
                        imageURL ?? "assets/images/products/house.jpg"),
                    fit: BoxFit.cover),
              ),
            ),
            // SUMMARY TEXT
            SizedBox(
              height: 400,
              width: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? 'James Villa',
                    softWrap: true,
                    maxLines: 3,
                    style: const TextStyle(
                      color: Color(0xFF303030),
                      fontSize: 18,
                      fontFamily: 'Gelasio',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  Text(
                    address ?? '14, James Kowope Street, Akure Ondo, Nigeria',
                    softWrap: true,
                    maxLines: 3,
                    style: const TextStyle(
                      color: Color.fromARGB(197, 48, 48, 48),
                      fontSize: 12,
                      fontFamily: 'Nunito Sans',
                      height: 0,
                    ),
                  ),
                  Text(
                    pricing ?? "₦300000/Year",
                    softWrap: true,
                    maxLines: 3,
                    style: const TextStyle(
                      color: Color(0xFF303030),
                      fontSize: 14,
                      fontFamily: 'Gelasio',
                      fontWeight: FontWeight.bold,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
