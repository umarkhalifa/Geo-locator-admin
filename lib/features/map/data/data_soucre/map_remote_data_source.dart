import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class MapRemoteDataSource{

  Future<LocationData> getUsersLocation()async{
    final location = Location();
    try{
      await location.requestPermission();
      return await location.getLocation().then((value) {
        return value;
      });
    }catch(e){
      throw(Exception('Error getting location'));
    }
  }
  //CONVERT LATITUDE TO UTM
  Future<LatLng> calculateUtm(double northing,double easting,int zone,String band) async {
    try {
      String lat = '';
      String long = '';
      final url =
      Uri.parse('https://awsm-tools.com/utm-to-lat-long?form%5Beasting%5D=$easting&form%5Bnorthing%5D=$northing&form%5Bzone%5D=$zone&form%5Bband%5D=${band.toUpperCase()}&form%5Bellipsoid%5D=WGS+84');
      final response = await http.get(url);
      dom.Document html = dom.Document.html(response.body);
      final titles1 = html
          .querySelectorAll("body > div.content > div.container.section > table > tbody > tr:nth-child(1) > td > span > span")
          .map((e) => e.innerHtml.trim())
          .toList();
      lat = titles1[0].substring(0,8);
      long = titles1[0].substring(10,18);
      return LatLng(double.parse(lat), double.parse(long));
    } catch(e){
      throw(Exception(e.toString()));
    }
  }
}

final mapDataSourceProvider = Provider((ref) => MapRemoteDataSource());