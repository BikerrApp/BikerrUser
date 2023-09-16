import 'dart:developer';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/modules/home/screens/add_bike.dart';
import 'package:bikerr_partner_app/src/modules/home/screens/booking_bikes_expanded.dart';
import 'package:bikerr_partner_app/src/modules/home/screens/my_listing.dart';
import 'package:bikerr_partner_app/src/services/http_client_service.dart';
import 'package:bikerr_partner_app/src/utils/strings/icons.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late final bmc = Get.find<BaseController>();

  final isTakenBikesLoading = false.obs;

  final switchValue = false.obs;
  final isDocumentInfo = false.obs;

  final optionList = [
    {
      "icon": bookingIcon,
      "name": "Upcoming Bookings",
    },
    {
      "icon": listingIcon,
      "name": "Listing",
    },
    {
      "icon": addListingIcon,
      "name": "Add Listing",
    },
    {
      "icon": earningIcon,
      "name": "Total Earnings",
    },
  ];
  
  optionsTap(value) async {
    switch (value) {
      case 0:
        Get.to(() => BookedBikesExpandedComp(bmc: bmc));
        break;
      case 1:
        Get.to(() => MyListingScreen(bmc: bmc));
        break;
      case 2:
        Get.to(() => AddBikeScreen(bmc: bmc));
        break;
      case 3:
        await getBookedAndTakenBikes();
        break;
      default:
    }
  }

  getBookedAndTakenBikes() async {
    try {
      var response = await HttpService.get(
        "booked-and-taken",
        isLoading: isTakenBikesLoading,
        headerData: {
          'Authorization' : 'Bearer fmvmKA47SHyj9OhaEosrmZ:APA91bFYbvQul-W7k1xtAXcR1sq918x3kORpP6sDRhaD76aoJvwk09hqbneHcxBPKsI1OtaZNJfuKcEJiM1wYjsBQnj6XP1rAg3zn-VAsjPyeagsiWTxFBZNLFYUjFglAgsx49FDjOYD',
        },
      );
      log("$response", name: "haskdjfhkasjdf");
    } catch (e) {
      log("$e");
    }
  }
}
