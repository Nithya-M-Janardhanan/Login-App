import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sample_task/machine_test/hexcolor.dart';
import 'package:table_calendar/table_calendar.dart';

import '../provider/user_provider.dart';

class CalenderNew extends StatefulWidget {
  const CalenderNew({Key? key}) : super(key: key);

  @override
  State<CalenderNew> createState() => _CalenderNewState();
}

class _CalenderNewState extends State<CalenderNew> {
  // DateTime chosenDate = DateTime.now();
  final dateFormat = DateFormat('dd EEEE');
  final dateFormatForYear = DateFormat('MMMM yyyy');
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedCalendarDate;
  @override
  void initState() {
    super.initState();
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
                    Text('sample calendar'),
                    ElevatedButton(
                      onPressed: (){
                        showModalBottomSheet(context: context,isScrollControlled: true, builder: (cntx){
                          return Container(
                            color: Colors.black,
                            height: MediaQuery.of(context).size.height * 0.75,
                            child:
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 20,top: 15),
                                  height: 90,
                                  width: double.maxFinite,
                                  color: HexColor('#212429'),
                                  child: Consumer<UserProvider>(
                                      builder: (context, model,child) {
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(dateFormat.format(model.chosenDate),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                            const SizedBox(height: 10,),
                                            Text(dateFormatForYear.format(model.chosenDate),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                          ],
                                        );
                                      }
                                  ),
                                ),
                                Expanded(
                                  child: TableCalendar(
                                    availableGestures: AvailableGestures.all,
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
                                        selectedDecoration: ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),color: Colors.green,),
                                        selectedTextStyle: const TextStyle(color: Colors.black),
                                        outsideTextStyle: const TextStyle(color: Colors.white24),
                                        defaultTextStyle: const TextStyle(color: Colors.white70),
                                        weekendTextStyle: const TextStyle(color: Colors.white70),
                                        rangeStartTextStyle: const TextStyle(color: Colors.green),
                                        isTodayHighlighted: false
                                    ),
                                    firstDay: DateTime.utc(2010, 10, 16),
                                    lastDay: DateTime.utc(2030, 3, 14),
                                    currentDay: _selectedDay,
                                    focusedDay: _focusedDay,
                                    onDaySelected: (selectedDay, focusedDay) {
                                      if (!isSameDay(_selectedCalendarDate, selectedDay)) {
                                        setState(() {
                                          _selectedDay = selectedDay;
                                          _focusedDay = focusedDay;
                                        });
                                      }
                                    },
                                    selectedDayPredicate: (currentSelectedDate){
                                      return (isSameDay(
                                          _selectedDay, currentSelectedDate));
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:  [
                                      Consumer<UserProvider>(
                                          builder: (context, snap,child) {
                                            return GestureDetector(onTap: (){
                                              setState(() {
                                                snap.chosenDate = DateTime.now();
                                              });
                                            }, child: Text('Today',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 16),));
                                          }
                                      ),
                                      Text('CANCEL',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 16),),
                                      Text('OK',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 16),),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                      },
                      child: const Text(
                          'Calendar'
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
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
