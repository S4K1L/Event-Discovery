import 'package:flutter_extension/data/model/event_model.dart';
import 'package:flutter_extension/data/model/notification_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedLocation = "Near You".obs;
  var selectedTimeFilter = "This Week".obs;
  RxBool isBookmarked = false.obs;
  RxBool isHost = true.obs;
  RxInt value = 1.obs;

  void increment() => value.value++;
  void decrement() => value.value = value.value > 0 ? value.value - 1 : 0;

  void toggleBookmark() {
    isBookmarked.value = !isBookmarked.value;
  }

  void setLocation(String value) {
    selectedLocation.value = value;
  }

  void setTimeFilter(String value) {
    selectedTimeFilter.value = value;
  }

  final List<EventModel> dummyEvents = [
    EventModel(
      id: "1",
      title: "Rooftop Sunset Sessions",
      description:
          "Join us for the ultimate nightlife experience. Dance, drink, and vibe with top DJs spinning electrifying beats all night long.",
      imageUrl: "assets/images/banner.png",
      date: DateTime(2025, 3, 21),
      startTime: "09:00 PM",
      endTime: "02:00 AM",
      totalSeats: 40,
      bookedSeats: 10,
      price: 50.00,
      organizerName: "Sean John",
      locationName: "Yellowstone National Park",
      locationAddress: "Wyoming",
    ),
    EventModel(
      id: "2",
      title: "Tech Innovators Meetup",
      description:
          "Network with industry leaders and explore the latest trends in AI, robotics, and startup innovation.",
      imageUrl: "assets/images/banner.png",
      date: DateTime(2025, 4, 5),
      startTime: "06:00 PM",
      endTime: "09:00 PM",
      totalSeats: 100,
      bookedSeats: 65,
      price: 15.00,
      organizerName: "Silicon Valley Hub",
      locationName: "Innovation Center",
      locationAddress: "San Francisco, CA",
    ),
    EventModel(
      id: "3",
      title: "Live Jazz Night",
      description:
          "An evening of smooth jazz performances featuring local and international artists.",
      imageUrl: "assets/images/banner.png",
      date: DateTime(2025, 5, 12),
      startTime: "07:30 PM",
      endTime: "11:30 PM",
      totalSeats: 60,
      bookedSeats: 48,
      price: 30.00,
      organizerName: "Blue Note Events",
      locationName: "Downtown Jazz Club",
      locationAddress: "New Orleans, LA",
    ),
    EventModel(
      id: "4",
      title: "Startup Pitch Night",
      description:
          "Watch emerging startups pitch their ideas to top investors and VCs.",
      imageUrl: "assets/images/banner.png",
      date: DateTime(2025, 6, 18),
      startTime: "05:00 PM",
      endTime: "08:00 PM",
      totalSeats: 80,
      bookedSeats: 32,
      price: 20.00,
      organizerName: "Venture Circle",
      locationName: "Tech Park Auditorium",
      locationAddress: "Austin, TX",
    ),
    EventModel(
      id: "5",
      title: "Beachside Yoga Retreat",
      description:
          "Relax and recharge with guided yoga sessions by the ocean at sunrise.",
      imageUrl: "assets/images/banner.png",
      date: DateTime(2025, 7, 2),
      startTime: "06:00 AM",
      endTime: "09:00 AM",
      totalSeats: 25,
      bookedSeats: 18,
      price: 40.00,
      organizerName: "Zen Life Studio",
      locationName: "Santa Monica Beach",
      locationAddress: "California",
    ),
  ];

  var notifications = <NotificationModel>[
    NotificationModel(
      unread: true,
      title: "Payment received successfully",
      dateTime: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    NotificationModel(
      unread: true,
      title: "Your order has been shipped",
      dateTime: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    NotificationModel(
      unread: false,
      title: "New login detected",
      dateTime: DateTime.now().subtract(const Duration(days: 1)),
    ),
    NotificationModel(
      unread: false,
      title: "Subscription renewed",
      dateTime: DateTime.now().subtract(const Duration(days: 3)),
    ),
    NotificationModel(
      unread: false,
      title: "Weekly report is ready",
      dateTime: DateTime.now().subtract(const Duration(days: 8)),
    ),
  ].obs;

  void markAsRead(int index) {
    notifications[index] = NotificationModel(
      unread: false,
      title: notifications[index].title,
      dateTime: notifications[index].dateTime,
    );
  }

  void deleteNotification(int index) {
    notifications.removeAt(index);
  }
}
