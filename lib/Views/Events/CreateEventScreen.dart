import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:university/Controller/AuthController.dart';
import 'package:university/Views/Helper.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../Controller/EventController.dart';
import '../../Models/UniversityModel.dart';

class CreateEventScreen extends StatefulWidget {
  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _locationController = TextEditingController();

  final TextEditingController _dateController = TextEditingController();

  final TextEditingController _startTimeController = TextEditingController();

  final TextEditingController _endTimeController = TextEditingController();

  final TextEditingController _eventCreatorController = TextEditingController();

  final TextEditingController _categoryController = TextEditingController();

  final TextEditingController _feesController = TextEditingController();

  EventController _eventController = Get.put(EventController());

  DateTime? date;

  TimeOfDay? starttime;

  TimeOfDay? endtime;

  final formKey = GlobalKey<FormState>();

  String? dropdownValue = "University";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themecolor,
        title: Text('Create Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              SizedBox(height: 16.0),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Event Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an event name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Location',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _dateController,
                readOnly: true,
                onTap: () async {
                  date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    _dateController.text =
                        DateFormat('MM/dd/yyyy').format(date!);
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Date (MM/dd/yyyy)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a date';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _startTimeController,
                readOnly: true,
                onTap: () async {
                  starttime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (starttime != null) {
                    _startTimeController.text = starttime!.format(context);
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Start Time (HH:MM)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a start time';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _endTimeController,
                readOnly: true,
                onTap: () async {
                  endtime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (endtime != null) {
                    _endTimeController.text = endtime!.format(context);
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'End Time (HH:MM)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an end time';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _eventCreatorController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Event Creator',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an event creator';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _categoryController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category for the event';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Category',
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name of the event creator';
                  }
                  return null;
                },
                controller: _feesController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Fees',
                ),
              ),
              SizedBox(height: 16.0),

              Card(
                color: themecolor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: DropdownButton(
                    // icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    value: dropdownValue.toString(),
                    elevation: 16,
                    dropdownColor: themecolor,
                    borderRadius: BorderRadius.circular(15),
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    underline: Container(
                      height: 2,
                      color: Colors.transparent,
                    ),
                    // hint: 'Select an option'.text.white.make(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue;
                        print(dropdownValue);
                      });
                    },
                    // selectedItemBuilder: (context) {
                    //   return <Widget>[
                    //     Container(
                    //       width: Get.width * 0.8,
                    //       decoration: BoxDecoration(
                    //           // color: Colors.black,
                    //           borderRadius: BorderRadius.circular(5),
                    //           border: Border.all(color: Colors.transparent)),
                    //       padding: EdgeInsets.all(10),
                    //       child: "$dropdownValue".text.white.make(),
                    //       // style: TextStyle(color: Colors.white),
                    //       // ),
                    //     ),
                    //   ];
                    // },
                    items: <String>['University', 'Student']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: "$value".text.color(Colors.white).make(),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 16.0),

              // SizedBox(height: 16.0),
              GestureDetector(
                // style: ButtonStyle(backgroundColor: themecolor),
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    final Event newEvent = Event(
                      who: dropdownValue.toString(),
                      id: currentuserdata!
                          .id, // Firestore will generate a unique ID for us
                      name: _nameController.text.trim(),
                      location: _locationController.text.trim(),
                      date: date!,
                      startTime: starttime!,
                      endTime: endtime!,
                      eventCreator: _eventCreatorController.text.trim(),
                      category: _categoryController.text.trim(),
                      fees: _feesController.text.trim(),
                    );

                    await _eventController.createEvent(newEvent, context);

                    // Clear the text fields after creating the event
                    _nameController.clear();
                    _locationController.clear();
                    _dateController.clear();
                    _startTimeController.clear();
                    _endTimeController.clear();
                    _eventCreatorController.clear();
                    _categoryController.clear();
                    _feesController.clear();
                  }
                },
                child: Card(
                  color: Colors.transparent,
                  elevation: 8,
                  child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: themecolor,
                          borderRadius: BorderRadius.circular(13)),
                      child: Center(
                        child: Text(
                          'Create Event',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
