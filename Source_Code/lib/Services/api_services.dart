import 'package:geolocator/geolocator.dart';
import 'package:ifstatic/Model/restaurant_model.dart';
import 'package:dio/dio.dart';

class ApiServices{

  final String _url =  "https://theoptimiz.com/restro/public/api/get_resturants";

  Future<RestaurantModel> getResturants(Position position) async{

    try {
      Response response = await Dio().post(
        _url,
        data: {
          "lat": position.latitude,
          "lng": position.longitude,
        },
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );

      return RestaurantModel.fromJson(response.data);
    } on DioError {
      rethrow;
    }
  }

}