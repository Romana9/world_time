import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart';

class AllCountries {
  String link = "";
  String countryName = "";
  String flag = "";

  AllCountries(
      {required this.link, required this.countryName, required this.flag});

  late bool isDayTime;
  late String timeNow;
  late String timeZone;
  getData() async {
    Response response =
        await get(Uri.parse('http://worldtimeapi.org/api/timezone/$link'));
    Map recivedData = jsonDecode(response.body);
    DateTime dateTime = DateTime.parse(recivedData["utc_datetime"]);

    int offset = int.parse(recivedData["utc_offset"].substring(0, 3));

    DateTime realTime = dateTime.add(Duration(hours: offset));
    timeNow = DateFormat('hh:mm a').format(realTime);

    timeZone = recivedData["timezone"];

    if (realTime.hour >= 5 && realTime.hour <= 18) {
      isDayTime = true;
    } else {
      isDayTime = false;
    }
  }
}
