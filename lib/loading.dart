import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';

import 'LocationScreen.dart';
import 'network.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  LoadingState createState() => LoadingState();
}

class LoadingState extends State<Loading> {
  Position? position;
  double? lat;
  double? lon;
  location() async {
    await getLocation();
  }

  getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    permission = await Geolocator.requestPermission();

    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);

    lat = position!.latitude;
    lon = position!.longitude;
    networkhelper helper = networkhelper(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?units=metric&lat=$lat&lon=$lon&appid=931e8bdeccb205992200128a5f3a3e95'));

    var weatherdata = await helper.getdata();
    print(weatherdata);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(locationWeather: weatherdata);
    }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    location();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: SpinKitDoubleBounce(color: Colors.grey, size: 40)),
      ),
    );
  }
}
