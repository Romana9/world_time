import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  @override
  Widget build(BuildContext context) {
    data =
        data.isEmpty ? ModalRoute.of(context)!.settings.arguments as Map : data;
    String bgImg = data["isDayTime"] ? "day.png" : "night.png";
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 55, 53, 63),
          image: DecorationImage(
              image: AssetImage("assets/$bgImg"), fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  dynamic result =
                      await Navigator.pushNamed(context, '/location');
                  setState(() {
                    if (result == null) {
                      data = ModalRoute.of(context)!.settings.arguments as Map;
                    } else {
                      data = {
                        "time": result["time"],
                        "location": result["location"],
                        "isDayTime": result["isDayTime"]
                      };
                    }
                  });
                },
                icon: const Icon(
                  Icons.edit_location,
                  color: Color.fromARGB(255, 255, 129, 129),
                  size: 24.0,
                ),
                label: const Text(
                  "Edit location",
                  style: TextStyle(fontSize: 19),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(146, 90, 103, 223)),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(22)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
                ),
              ),
              const SizedBox(
                height: 300,
              ),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 33),
                color: const Color.fromARGB(111, 0, 0, 0),
                child: Column(
                  children: [
                    Text(
                      data["time"],
                      style: const TextStyle(fontSize: 55, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    Text(
                      data["location"],
                      style: const TextStyle(fontSize: 28, color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
