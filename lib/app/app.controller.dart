import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  // var for automatically start collecting data
  FirebaseAnalytics analytics;

  @override
  onInit() {
    // start collecting one intilized
    analytics = new FirebaseAnalytics();
    super.onInit();
  }
}
