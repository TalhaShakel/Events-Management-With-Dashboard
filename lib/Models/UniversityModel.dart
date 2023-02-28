import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class University {
  final String id;
  final String name;
  final String email;
  final List<Event> events;

  University({
    required this.id,
    required this.name,
    required this.email,
    required this.events,
  });

  factory University.fromJson(Map<String, dynamic> json) {
    final List<dynamic> eventList = json['events'] ?? [];
    final List<Event> events = eventList.map((e) => Event.fromJson(e)).toList();

    return University(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      events: events,
    );
  }

  Map<String, dynamic> toJson(context) {
    final List<dynamic> eventList =
        events.map((e) => e.toJson(context)).toList();

    return {
      'id': id,
      'name': name,
      'email': email,
      'events': eventList,
    };
  }
}

class Event {
  final String id, who;
  final String name;
  final String location;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String eventCreator;
  final String category;
  final String fees;

  Event({
    required this.who,
    required this.id,
    required this.name,
    required this.location,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.eventCreator,
    required this.category,
    required this.fees,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      who: json["who"].toString(),
      id: json['id'],
      name: json['name'],
      location: json['location'],
      date: DateTime.parse(json['date']),
      startTime:
          TimeOfDay.fromDateTime(DateFormat.jm().parse(json['startTime'])),
      endTime: TimeOfDay.fromDateTime(DateFormat.jm().parse(json['endTime']!)),
      // startTime:
      //     TimeOfDay.fromDateTime((json['startTime'] as Timestamp).toDate()),
      // endTime: TimeOfDay.fromDateTime((json['endTime'] as Timestamp).toDate()),
      eventCreator: json['eventCreator'],
      category: json['category'],
      fees: json['fees'],
    );
  }

  Map<String, dynamic> toJson(context) {
    return {
      'id': id,
      "who": who,
      'name': name,
      'location': location,
      'date': date.toIso8601String(),
      'startTime': startTime.format(context),
      'endTime': endTime.format(context),
      'eventCreator': eventCreator,
      'category': category,
      'fees': fees,
    };
  }
}
