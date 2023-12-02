import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:locate_me_now/Services/LocationServices.dart';
import 'package:locate_me_now/modal/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String location = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startLocationService();
    _getLocation();
  }

  Future<void> _startLocationService() async {
    LocationService().initialize();

    LocationService().getLongitude().then((value) {
      setState(() {
        Users.long = value!;
      });

      LocationService().getLatitude().then((value) {
        setState(() {
          Users.lat = value!;
        });

        LocationService().getAltitude().then((value) {
          setState(() {
            Users.alt = value!;
          });
        });
      });
    });

    print(Users.lat);
    print(Users.long);
    print(Users.alt);
  }

  void _getLocation() async
  {
    List<Placemark> placemark = await placemarkFromCoordinates(Users.lat, Users.long);

    setState(() {
      location = '${placemark[0].street}, ${placemark[0].administrativeArea}, ${placemark[0].postalCode}, ${placemark[0].country}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("image/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
          child: Column(
            children: [
              // Button to find the location i.e, lat, long and alt

              InkWell(
                onTap: () {
                  _startLocationService();
                  _getLocation();
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 200.0, left: 20, right: 20, bottom: 20),
                  child: Container(
                    child: Center(
                      child: Text(
                        "Get Current Location",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    width: 150,
                    height: 30,
                    decoration: BoxDecoration(
                      color: const Color(0xFFa9d470),
                      border: Border.all(color: const Color(0xFFa9d470)),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.9),
                            spreadRadius: 10,
                            blurRadius: 12),
                      ],
                    ),
                  ),
                ),
              ),

              //  Container to display the latitude

              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 10, left: 75),
                child: Container(
                    child: Row(
                  children: [
                    const Text(
                      "Latitude : ",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                    ),
                    Text(
                      Users.lat.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    )
                  ],
                )),
              ),

              // Container to display longitude

              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 10, left: 75),
                child: Container(
                    child: Row(
                  children: [
                    const Text(
                      "Longitude: ",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                    ),
                    Text(
                      Users.long.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    )
                  ],
                )),
              ),

              // Container to display altitude

              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 10, left: 75),
                child: Container(
                    child: Row(
                  children: [
                    const Text(
                      "Altitude : ",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                    ),
                    Text(
                      Users.alt.toStringAsFixed(5),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    )
                  ],
                )),
              ),

              // Container to display address
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 10, left: 75),
                child: Container(
                    child: Text(
                      location,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
