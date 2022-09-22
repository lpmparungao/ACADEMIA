import 'dart:core';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sample1/calendar/calendarModel.dart';
import 'package:sample1/calendar/db.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);
  DateTime _selectedDay = DateTime.now();

  CalendarController _calendarController;
  Map<DateTime, List<dynamic>> _events = {};
  List<CalendarItem> _data = [];

  List<dynamic> _selectedEvents = [];
  List<Widget> get _eventWidgets =>
      _selectedEvents.map((e) => events(e)).toList();

  void initState() {
    super.initState();
    DB.init().then((value) => _fetchEvents());
    _calendarController = CalendarController();
  }

  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  Widget events(var d) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        decoration: BoxDecoration(
            border: Border(
          top: BorderSide(color: Theme.of(context).dividerColor),
        )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(d, style: Theme.of(context).primaryTextTheme.bodyText1),
            IconButton(
              icon: FaIcon(
                FontAwesomeIcons.trashAlt,
                color: Color(0xFFE28C7E),
                size: 15,
              ),
              onPressed: () => _deleteEvent(d),
            ),
          ],
        ),
      ),
    );
  }

  void _onDaySelected(DateTime day, List events) {
    setState(() {
      _selectedDay = day;
      _selectedEvents = events;
    });
  }

  void _selectTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  void _create(BuildContext context) {
    String _name = "";
    //String _details = "";
    var content = TextField(
      style: TextStyle(color: Color.fromRGBO(105, 105, 108, 1), fontSize: 16),
      autofocus: true,
      decoration: InputDecoration(
        labelStyle: TextStyle(
            color: Color.fromRGBO(59, 57, 60, 1),
            fontSize: 18,
            fontWeight: FontWeight.normal),
        labelText: 'Event Name',
      ),
      onChanged: (value) {
        _name = value;
      },
    );
    /*var content1 = TextField(
      style: TextStyle(color: Color.fromRGBO(105, 105, 108, 1), fontSize: 16),
      autofocus: true,
      decoration: InputDecoration(
        labelStyle: TextStyle(
            color: Color.fromRGBO(59, 57, 60, 1),
            fontSize: 18,
            fontWeight: FontWeight.normal),
        labelText: 'Details',
      ),
      onChanged: (value) {
        _details = value;
      },
    );*/
    var btn = ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            primary: Colors.white,
            onPrimary: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            )),
        child: Text('Save',
            style: TextStyle(
                color: Color.fromRGBO(59, 57, 60, 1),
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        onPressed: () {
          if (_name != null) {
            _addEvent(_name);
          } else {
            Navigator.of(context).pop(false);
          }
        });
    SizedBox(width: 40);
    var cancelButton = ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            primary: Colors.white,
            onPrimary: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            )),
        child: Text('Cancel',
            style: TextStyle(
                color: Color.fromRGBO(59, 57, 60, 1),
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        onPressed: () => Navigator.of(context).pop(false));
    /*var pickTime = ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            primary: Colors.white,
            onPrimary: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            )),
        child: Text('Pick Time',
            style: TextStyle(
                color: Color.fromRGBO(59, 57, 60, 1),
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        onPressed: () {
          _selectTime();
        });*/
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: const Offset(0.0, 10.0),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // To make the card compact
                    children: <Widget>[
                      SizedBox(height: 24.0),
                      Text("Add Event",
                          style: TextStyle(
                              color: Color.fromRGBO(59, 57, 60, 1),
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: <Widget>[content],
                        ),
                      ),
                      /*Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: Column(
                          children: <Widget>[content1],
                        ),
                      ),*/
                      /*Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          children: <Widget>[pickTime],
                        ),
                      ),
                      Text(
                        'Selected time: ${_time.format(context)}',
                      ),*/
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[btn, cancelButton]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _fetchEvents() async {
    _events = {};
    List<Map<String, dynamic>> _results = await DB.query(CalendarItem.table);
    _data = _results.map((item) => CalendarItem.fromMap(item)).toList();
    _data.forEach((element) {
      DateTime formattedDate = DateTime.parse(DateFormat('yyyy-MM-dd')
          .format(DateTime.parse(element.date.toString())));
      if (_events.containsKey(formattedDate)) {
        _events[formattedDate].add(element.name.toString());
      } else {
        _events[formattedDate] = [element.name.toString()];
      }
    });
    setState(() {});
  }

  void _addEvent(String event) async {
    CalendarItem item =
        CalendarItem(date: _selectedDay.toString(), name: event);
    await DB.insert(CalendarItem.table, item);
    _selectedEvents.add(event);
    _fetchEvents();

    Navigator.pop(context);
  }

  // Delete doesnt refresh yet, thats it, then done!
  void _deleteEvent(String s) {
    List<CalendarItem> d = _data.where((element) => element.name == s).toList();
    if (d.length >= 1) {
      DB.delete(CalendarItem.table, d[0]);
      _selectedEvents.removeWhere((e) => e == s);
      _fetchEvents();
    }
  }

  Widget calendar() {
    return Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            gradient: LinearGradient(colors: [Colors.white, Colors.white]),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: new Offset(0.0, 5))
            ]),
        child: TableCalendar(
          calendarStyle: CalendarStyle(
            canEventMarkersOverflow: true,
            markersColor: Colors.black54,
            weekdayStyle: TextStyle(color: Colors.black),
            todayColor: Color(0xFFE28C7E).withOpacity(0.6),
            todayStyle: TextStyle(color: Colors.white, fontSize: 15),
            selectedColor: Color(0xFFE28C7E),
            outsideWeekendStyle: TextStyle(color: Colors.grey),
            outsideStyle: TextStyle(color: Colors.grey),
            weekendStyle: TextStyle(color: Colors.black54),
            renderDaysOfWeek: false,
          ),
          onDaySelected: (DateTime day, List events, _) {
            setState(() {
              _selectedDay = day;
              _selectedEvents = events;
            });
          },
          calendarController: _calendarController,
          events: _events,
          headerStyle: HeaderStyle(
            leftChevronIcon:
                Icon(Icons.arrow_back_ios, size: 15, color: Colors.black),
            rightChevronIcon:
                Icon(Icons.arrow_forward_ios, size: 15, color: Colors.black),
            titleTextStyle: TextStyle(color: Colors.black, fontSize: 16),
            formatButtonDecoration: BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.circular(20),
            ),
            formatButtonTextStyle: TextStyle(
                color: Color(0xFFE28C7E),
                fontSize: 13,
                fontWeight: FontWeight.bold),
          ),
        ));
  }

  Widget eventTitle() {
    if (_selectedEvents.length == 0) {
      return Container(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 5),
        child: Text(
          'No Event',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 18,
          ),
        ),
      );
    }
    return Container(
      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: Text(
        'Events',
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 18,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calendar',
          textAlign: TextAlign.center,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Event Manager",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                // Consumer<ThemeNotifier>(
                //       builder: (context, notifier, child) => IconButton(icon: notifier.isDarkTheme ? FaIcon(FontAwesomeIcons.moon, size: 20, color: Colors.white,) : Icon(Icons.wb_sunny), onPressed: () => {notifier.toggleTheme()}))
              ],
            ),
          ),
          calendar(),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Daily Events',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              )),
          eventTitle(),
          Column(
            children: _eventWidgets,
          ),
          SizedBox(height: 60)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFE28C7E),
        onPressed: () => _create(
            context), //Navigator.push(context, MaterialPageRoute(builder: (context) => AddEvent())),
        //onPressed: () => Navigator.of(context)
        //.push(MaterialPageRoute(builder: (context) => EventEditingPage())),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

/*class TimePicker extends StatefulWidget {
  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);

  void _selectTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _selectTime,
              child: Text('SELECT TIME'),
            ),
            SizedBox(height: 8),
            Text(
              'Selected time: ${_time.format(context)}',
            ),
          ],
        ),
      ),
    );
  }
}*/
