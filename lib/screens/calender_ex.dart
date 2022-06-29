
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sample_task/machine_test/hexcolor.dart';
import 'package:table_calendar/table_calendar.dart';

import '../provider/user_provider.dart';
import 'k_events.dart';

class CalenderEx extends StatefulWidget {
  const CalenderEx({Key? key}) : super(key: key);

  @override
  State<CalenderEx> createState() => _CalenderExState();
}

class _CalenderExState extends State<CalenderEx> {
  PageController? pageController;
  final dateFormat = DateFormat('dd EEEE');
  final dateFormatForYear = DateFormat('MMMM yyyy');
  DateTime _focusedDay = DateTime.now();
  int? initialPage;

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }
  @override
  void initState() {
    super.initState();
  }
@override
  void dispose() {
    super.dispose();
    pageController?.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          color: Colors.grey,
          child: Center(
            child: Column(
              children: [
                const Text('sample calendar'),
                ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return Container(
                            color: Colors.black,
                            height: MediaQuery.of(context).size.height * 0.75,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 20, top: 15),
                                  height: 90,
                                  width: double.maxFinite,
                                  color: HexColor('#212429'),
                                  child: Consumer<UserProvider>(
                                      builder: (context, model, child) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          dateFormat.format(model.chosenDate),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          dateFormatForYear
                                              .format(model.chosenDate),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                                Expanded(
                                  child: Consumer<UserProvider>(
                                      builder: (context, snapshot, child) {
                                    return TableCalendar(
                                      pageJumpingEnabled: true,
                                      rowHeight: 48,
                                      daysOfWeekHeight: 20,
                                      headerStyle: const HeaderStyle(
                                          titleCentered: true,
                                          formatButtonVisible: false,
                                          titleTextStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                          leftChevronIcon: Icon(
                                            Icons.chevron_left,
                                            color: Colors.white70,
                                          ),
                                          rightChevronIcon: Icon(
                                            Icons.chevron_right,
                                            color: Colors.white70,
                                          )),
                                      daysOfWeekStyle: const DaysOfWeekStyle(
                                          weekdayStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          weekendStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                      startingDayOfWeek:
                                          StartingDayOfWeek.monday,
                                      calendarStyle: CalendarStyle(
                                          cellMargin:
                                              const EdgeInsets.all(15.0),
                                          todayDecoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(5)),
                                            color: Colors.orange,
                                          ),
                                          todayTextStyle: const TextStyle(
                                              color: Colors.black),
                                          selectedDecoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            color: Colors.white,
                                          ),
                                          selectedTextStyle: const TextStyle(
                                              color: Colors.black),
                                          outsideTextStyle: const TextStyle(
                                              color: Colors.white24),
                                          outsideDaysVisible: false,
                                          defaultTextStyle: const TextStyle(
                                              color: Colors.white70),
                                          weekendTextStyle: const TextStyle(
                                              color: Colors.white70),
                                          rangeStartTextStyle: const TextStyle(
                                              color: Colors.white),
                                          isTodayHighlighted: false,
                                        rangeStartDecoration:  ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(5)),
                                          color: Colors.blueGrey,
                                        ),
                                      ),
                                      firstDay: DateTime.utc(2010, 10, 16),
                                      lastDay: DateTime.utc(2030, 3, 14),
                                      rangeStartDay: DateTime.now(),
                                      currentDay: snapshot.chosenDate,
                                      focusedDay: _focusedDay,
                                      onDaySelected: (date, events) {
                                        snapshot.dateFn(date);
                                        if (!isSameDay(
                                            snapshot.chosenDate, events)) {
                                            snapshot.chosenDate = events;
                                            // _focusedDay = events;
                                        }
                                      },
                                      onPageChanged: (focusedDay){
                                        _focusedDay = focusedDay;
                                      },
                                      onCalendarCreated: (page){
                                        pageController = page;
                                        initialPage ??= page.initialPage;
                                        if(initialPage == page.initialPage){
                                          initialPage = pageController?.initialPage;
                                        }
                                        print(page.initialPage);
                                      },
                                      /*calendarBuilders: CalendarBuilders(
                                             selectedBuilder: (context, date, _){
                                               return Container(
                                                   margin: const EdgeInsets.all(4.0),
                                               alignment: Alignment.center,
                                               decoration: BoxDecoration(
                                               color: Colors.white,
                                               borderRadius: BorderRadius.circular(10.0)),
                                               child: Text(
                                               date.day.toString(),
                                               style: TextStyle(color: Colors.black),
                                               ));
                                             },
                                             todayBuilder: (context, date, events) => Container(
                                                 margin: const EdgeInsets.all(5.0),
                                                 alignment: Alignment.center,
                                                 decoration: BoxDecoration(
                                                     color: Colors.orange,
                                                     borderRadius: BorderRadius.circular(10.0)),
                                                 child: Text(
                                                   date.day.toString(),
                                                   style: TextStyle(color: Colors.white),
                                                 )),
                                           ),*/
                                      selectedDayPredicate: (day) {
                                        return isSameDay(
                                            snapshot.chosenDate, day);
                                      },
                                    );
                                  }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Consumer<UserProvider>(
                                          builder: (context, snap, child) {
                                        return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                snap.setTodayDate();
                                                if(pageController != null && initialPage != null){
                                                  pageController!.animateToPage(initialPage!, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                                                }
                                              });
                                            },
                                            child: const Text(
                                              'Today',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16),
                                            ));
                                      }),
                                      GestureDetector(
                                        child: const Text(
                                          'CANCEL',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16),
                                        ),
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                      ),
                                      const Text(
                                        'OK',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  },
                  child: const Text('Calendar'),
                ),
              ],
            ),
          ),
        ),
      )),
      /*bottomSheet: Container(
        color: Colors.black,
        height: MediaQuery.of(context).size.height * 0.65,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20,top: 15),
              height: 90,
              width: double.maxFinite,
              color: HexColor('#212429'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dateFormat.format(chosenDate),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Text(dateFormatForYear.format(chosenDate),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            Expanded(
              child: TableCalendar(
                rowHeight: 48,
                daysOfWeekHeight: 20,
                headerStyle: const HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    titleTextStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),
                    leftChevronIcon: Icon(Icons.chevron_left,color: Colors.white70,),
                    rightChevronIcon: Icon(Icons.chevron_right,color: Colors.white70,)
                ),
                daysOfWeekStyle: const DaysOfWeekStyle(weekdayStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),weekendStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarStyle:  CalendarStyle(
                  cellMargin: const EdgeInsets.all(15.0),
                  todayDecoration: ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),color: Colors.white),
                  todayTextStyle: const TextStyle(color: Colors.black),
                  selectedDecoration: ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),color: Colors.white,),
                  selectedTextStyle: const TextStyle(color: Colors.black),
                  outsideTextStyle: const TextStyle(color: Colors.white24),
                  defaultTextStyle: const TextStyle(color: Colors.white70),
                  weekendTextStyle: const TextStyle(color: Colors.white70),
                  rangeStartTextStyle: const TextStyle(color: Colors.green)
                ),
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
                onDaySelected: (date, events) {
                  setState(() {
                    chosenDate = date;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Today',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 16),),
                  Text('CANCEL',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 16),),
                  Text('OK',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 16),),
                ],
              ),
            )
          ],
        ),
      ),*/
    );
  }
}
