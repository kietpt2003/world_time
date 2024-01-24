import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  late String location; //location name for the ui
  late String time; //the time in that location
  late String flag; //url to an asset flag icon
  late String url; //location url for api endpoint
  late bool isDaytime; //true or false if daytime or not
  WorldTime({required this.location, required this.flag, required this.url});
  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.parse('https://worldtimeapi.org/api/timezone/${url}'));
      Map data = jsonDecode(response.body);
      String dateTime = data['datetime'];
      String offset = data['utc_offset'];
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset.substring(1, 3))));

      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('error: $e');
      time = "Could not get time data";
    }
  }
}
