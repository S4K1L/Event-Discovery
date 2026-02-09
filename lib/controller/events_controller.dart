import 'package:get/get.dart';

import '../data/model/event_model.dart';

enum EventTab { myEvent, attending, saved }

enum EventHistoryTab { upcomingEvent, pastEvent }

class EventsController extends GetxController {
  var selectedTab = EventTab.myEvent.obs;
  var historySelectedTab = EventHistoryTab.upcomingEvent.obs;

  final myEvents = <EventModel>[].obs;
  final attendingEvents = <EventModel>[].obs;
  final savedEvents = <EventModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDummyEvents();
  }

  Future<void> refreshCurrentTab() async {
    await Future.delayed(const Duration(seconds: 1));

    loadDummyEvents();
  }

  List<EventModel> get currentEvents {
    switch (selectedTab.value) {
      case EventTab.myEvent:
        return myEvents;
      case EventTab.attending:
        return attendingEvents;
      case EventTab.saved:
        return savedEvents;
    }
  }

  List<EventModel> get historyEvents {
    switch (historySelectedTab.value) {
      case EventHistoryTab.upcomingEvent:
        return myEvents;
      case EventHistoryTab.pastEvent:
        return attendingEvents;
    }
  }

  void changeTab(EventTab tab) {
    selectedTab.value = tab;
  }

  void changeHistoryTab(EventHistoryTab tab) {
    historySelectedTab.value = tab;
  }

  void loadDummyEvents() {
    myEvents.assignAll([
      EventModel(
        id: "1",
        title: "My Private Concert",
        description: "Exclusive music night",
        imageUrl: "assets/images/banner.png",
        date: DateTime.now().add(const Duration(days: 2)),
        startTime: "6:00 PM",
        endTime: "9:00 PM",
        totalSeats: 40,
        bookedSeats: 30,
        price: 25,
        totalEarnings: 500,
        organizerName: "John Doe",
        locationName: "City Hall",
        locationAddress: "Downtown Street",
      ),

      EventModel(
        id: "2",
        title: "Zack Private Concert",
        description: "Exclusive music night",
        imageUrl: "assets/images/banner.png",
        date: DateTime.now().add(const Duration(days: 2)),
        startTime: "6:00 PM",
        endTime: "9:00 PM",
        totalSeats: 40,
        bookedSeats: 30,
        price: 75,
        totalEarnings: 1500,
        organizerName: "John Doe",
        locationName: "City Hall",
        locationAddress: "Downtown Street",
      ),
    ]);

    attendingEvents.assignAll([
      EventModel(
        id: "2",
        title: "Tech Meetup",
        description: "Networking for developers",
        imageUrl: "assets/images/banner.png",
        date: DateTime.now().add(const Duration(days: 5)),
        startTime: "10:00 AM",
        endTime: "1:00 PM",
        totalSeats: 100,
        bookedSeats: 88,
        price: 10,
        organizerName: "Tech Group",
        locationName: "Innovation Hub",
        locationAddress: "Silicon Avenue",
      ),
    ]);

    savedEvents.assignAll([
      EventModel(
        id: "3",
        title: "Startup Pitch Day",
        description: "Pitch your startup idea",
        imageUrl: "assets/images/banner.png",
        date: DateTime.now().add(const Duration(days: 10)),
        startTime: "2:00 PM",
        endTime: "6:00 PM",
        totalSeats: 60,
        bookedSeats: 20,
        price: 90,
        organizerName: "Startup Inc",
        locationName: "Business Center",
        locationAddress: "Market Road",
      ),
    ]);
  }
}
