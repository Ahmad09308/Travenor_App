import 'package:dio/dio.dart';
import 'package:travenor_app/core/model/AirportModel.dart';

abstract class AirportService {
  Future<List<AirportModel>> getAllAirports();
  Future<List<AirportModel>> searchAirports(String query); 
}

class AirportServiceImp extends AirportService {
  final Dio dio = Dio();
  final String baseurl = "https://freetestapi.com/api/v1/airports";

  @override
  Future<List<AirportModel>> getAllAirports() async {
    try {
      final response = await dio.get(baseurl);
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((airport) => AirportModel.fromJson(airport))
            .toList();
      } else {
        throw Exception('Failed to load airports');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Future<List<AirportModel>> searchAirports(String query) async {
    try {
      final response = await dio.get('$baseurl?search=$query');
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((airport) => AirportModel.fromJson(airport))
            .toList();
      } else {
        throw Exception('Failed to load search results');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
