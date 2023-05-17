
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ifstatic/Model/restaurant_model.dart';
import 'package:ifstatic/Services/api_services.dart';

class RestaurantProvider extends ChangeNotifier{

  String currentAddress ="";
  Position? currentPosition;

  //For device location permisson
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showToast('Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showToast('Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showToast("Location permissions are permanently denied, we cannot request permissions.");
      return false;
    }
    return true;
  }

  //Function for getting the latitude and longitude
  Future<void> getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
            currentPosition = position;
            getAddressFromLatLng(currentPosition!);
            getRestaurantList(currentPosition!);
      }
    ).catchError((e) {
      print(e.toString());
    });
    notifyListeners();
  }

  //Function for getting the exact address from latitude and longitude
  Future<void> getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        currentPosition!.latitude, currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      currentAddress = '${place.street}, ${place.subLocality}, ${place.country}';


    }).catchError((e) {
      print(e.toString());
    });

    notifyListeners();
  }

  //To recieve the data fetched from API
  final ApiServices _apiServices = ApiServices();
  RestaurantModel? resturantModel;
  List<Details> details = [];
  bool isLoading = false;

  Future<void> getRestaurantList(Position position) async{
    isLoading = true;
    notifyListeners();

    try{
      resturantModel = await _apiServices.getResturants(position);
      details = resturantModel!.data;
    }
    catch(e)
    {
      print(e.toString());
    }

    isLoading = false;
    notifyListeners();

  }

  //Search implementations
  void searchRestaurants(String query)
  {
     final suggestions = details.where((element) {
       final name = element.name.toLowerCase();
       final input = query.toLowerCase();
       return name.contains(input);
     }).toList();

     details = suggestions;
     notifyListeners();
  }

}


void showToast(String text) => Fluttertoast.showToast
  (
  msg: text,
  fontSize: 13.0,
  backgroundColor: Color(0xFF091945),
  textColor: Colors.white,
  gravity: ToastGravity.BOTTOM,
);