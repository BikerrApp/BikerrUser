import 'dart:developer';
import 'package:bikerr_partner_app/src/modules/add_bikes/add_bikes.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/modules/home/screens/booking_bikes_expanded.dart';
import 'package:bikerr_partner_app/src/modules/home/screens/my_listing.dart';
import 'package:bikerr_partner_app/src/services/http_client_service.dart';
import 'package:bikerr_partner_app/src/services/shared_preferences.dart';
import 'package:bikerr_partner_app/src/services/sql_db_services.dart';
import 'package:bikerr_partner_app/src/services/traccar_services.dart';
import 'package:bikerr_partner_app/src/utils/strings/icons.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late final bmc = Get.find<BaseController>();

  final switchValue = false.obs;

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

  final isProfileLoading = false.obs;
  final isTakenBikesLoading = false.obs;
  final isUpcommingLoading = false.obs;
  final isMyBikesLoading = false.obs;

  final userDetailsData = [].obs;
  final bookedAndTakenBikeData = [].obs;
  final upcommingBookingsData = [].obs;
  final myBikesListData = [].obs;
  final totalEarnings = 0.obs;

  @override
  void onInit() async {
    await getUserProfile();
    await getBookedAndTakenBikes();
    await getUpcommingBookings();
    // await getMyBikeList();
    super.onInit();
  }

  optionsTap(value) async {
    switch (value) {
      case 0:
        Get.to(() => BookedBikesExpandedComp(bmc: bmc));
        break;
      case 1:
        Get.to(() => MyListingScreen(bmc: bmc));
        break;
      case 2:
        Get.to(() => AddBikeModule(bmc: bmc));
        break;
      case 3:
        break;
      default:
    }
  }

  getBookedAndTakenBikes() async {
    log("${Traccar.apiToken.value}", name: "sadgasdgasdgs");
    try {
      var response = await HttpService.get(
        "booked-and-taken",
        isLoading: isTakenBikesLoading,
        headerData: {'Authorization': 'Bearer ${Traccar.apiToken.value}'},
      );
      log("$response", name: "haskdjfhkasjdf");
      log("${response["status_code"]}", name: "haskdjfhkasjdf");
      if (response["status_code"] == 200) {
        bookedAndTakenBikeData.value = response["data"];
        bookedAndTakenBikeData.value = bookedAndTakenBikeData.reversed.toList();
        bookedAndTakenBikeData.refresh();
      } else {}
    } catch (e) {
      log("$e");
    }
  }

  getUserProfile() async {
    bool isFirstTime =
        await SharedPreferencesServices.getBoolData(key: "isFirstTime") ?? true;
    switch (isFirstTime) {
      case true:
        {
          var response = await HttpService.get(
            "get-profile",
            headerData: {'Authorization': 'Bearer ${Traccar.apiToken.value}'},
            isLoading: isProfileLoading,
          );
          log("${response["data"]}", name: "sdfhkjashdgkjas");
          log("${response["data"]["user_id"]}", name: "sdfhkjashdgkjas");
          await SharedPreferencesServices.setIntData(
            key: "user_id_int",
            value: response["data"]["id"],
          );
          await setUserDataToDb(
            id: response["data"]["id"],
            userId: response["data"]["user_id"],
            userName: response["data"]["user_name"],
            email: response["data"]["email"],
            mobileNumber: response["data"]["mobile_number"],
            image: "",
          );
          await SharedPreferencesServices.setBoolData(
              key: "isFirstTime", value: false);
          await getUserDataFromDb();
        }
        break;
      case false:
        {
          await getUserDataFromDb();
        }
        break;
      default:
    }
  }

  setUserDataToDb({
    required int id,
    required String userId,
    required String userName,
    required String email,
    required String mobileNumber,
    required String image,
  }) async {
    await SqlDBService.sqlDBServiceinstance.insertUserDetails(
      id: id,
      userId: userId,
      userName: userName,
      email: email,
      mobileNumber: mobileNumber,
      image: image,
    );
    log("ajshdfkjlashdflhasld");
  }

  getUserDataFromDb() async {
    var response = await SqlDBService.sqlDBServiceinstance.getUserDetails();
    userDetailsData.value = response;
    log("$userDetailsData", name: "oiewuoithwjkh23452nbkjb34");
    log("${userDetailsData.first["user_id"]}", name: "jsdhfklajshdgkjlahsdlk");
  }

  getUpcommingBookings() async {
    var response = await HttpService.get(
      "upcomming-booking",
      headerData: {'Authorization': 'Bearer ${Traccar.apiToken.value}'},
      isLoading: isUpcommingLoading,
    );
    log("$response", name: "upcomming-booking");
    if (response["status_code"] == 200) {
      upcommingBookingsData.value = response["data"];
      upcommingBookingsData.value = upcommingBookingsData.reversed.toList();
      upcommingBookingsData.refresh();
      totalEarnings.value = response["total_earing"];
    } else {}
  }

  getMyBikeList() async {
    var response = await HttpService.get(
      "my-bike-list",
      headerData: {'Authorization': 'Bearer ${Traccar.apiToken.value}'},
      isLoading: isMyBikesLoading,
    );
    log("$response", name: "mybikeslist");
  }
}
