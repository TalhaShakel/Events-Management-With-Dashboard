import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:university/Models/UniversityModel.dart';
import 'package:university/Views/Helper.dart';

class ShowEventsScreen extends StatelessWidget {
  const ShowEventsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ,
      appBar: AppBar(
        backgroundColor: themecolor,
        title: Text('Events'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('events').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final events = snapshot.data!.docs
              .map((doc) => Event.fromJson(doc.data() as Map<String, dynamic>))
              .toList();
          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return eventcard(event, context);
            },
          );
        },
      ),
    );
  }

  Card eventcard(Event newEvent, context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: newEvent.who == "University"
                  ? Color.fromARGB(255, 174, 6, 79)
                  : Color.fromARGB(255, 2, 159, 120),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  newEvent.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  newEvent.location,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  newEvent.date.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Start Time: ${newEvent.startTime.format(context)}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'End Time: ${newEvent.endTime.format(context)}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Event Creator:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  newEvent.eventCreator,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Category:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  newEvent.category,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Fees:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  newEvent.fees,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    '${newEvent.who}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    //  Card(
    //   elevation: 10,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(15),
    //   ),
    //   margin: EdgeInsets.all(16.0),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       // ClipRRect(
    //       //   borderRadius: BorderRadius.only(
    //       //     topLeft: Radius.circular(8.0),
    //       //     topRight: Radius.circular(8.0),
    //       //   ),
    //       //   child: Image.network(
    //       //     'https://via.placeholder.com/350x150',
    //       //     fit: BoxFit.cover,
    //       //     height: 150.0,
    //       //     width: double.infinity,
    //       //   ),
    //       // ),
    //       Padding(
    //         padding: EdgeInsets.all(16.0),
    //         child: Text(
    //           newEvent.name,
    //           style: TextStyle(
    //             fontWeight: FontWeight.bold,
    //             fontSize: 20.0,
    //           ),
    //         ),
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.location_pin),
    //         title: Text(newEvent.location),
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.calendar_today),
    //         title: Text(newEvent.date.toString()),
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.schedule),
    //         title: Text('Start Time: ${newEvent.startTime.format(context)}'),
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.schedule),
    //         title: Text('End Time: ${newEvent.endTime.format(context)}'),
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.person),
    //         title: Text('Event Creator: ${newEvent.eventCreator}'),
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.category),
    //         title: Text('Category: ${newEvent.category}'),
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.attach_money),
    //         title: Text('Fees: ${newEvent.fees}'),
    //       ),
    //     ],
    //   ),
    // );
  }
}
