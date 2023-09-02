import 'dart:async';

import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';
class LocationCard extends StatelessWidget {
  final TextEditingController latController;
  final TextEditingController longController;
  final Future<void> Function(double lat, double long) locationFuture;

  const LocationCard(
      {super.key,
        required this.latController,
        required this.longController,
        required this.locationFuture});

  @override
  Widget build(BuildContext context) {
    Timer debounce = Timer(const Duration(seconds: 1), () {});
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blue,
              child: Icon(
                SolarIconsBold.mapArrowUp,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: TextFormField(
                onChanged: (text) {
                  if (debounce.isActive) debounce.cancel();

                  // Start a new timer to trigger action after 1 second (adjust as needed)
                  debounce = Timer(const Duration(seconds: 1), () {
                    // Perform your action here when the user stops typing
                    double lat = double.parse(latController.text.trim());
                    double long = double.parse(longController.text.trim());
                    locationFuture(lat, long);
                  });
                },
                keyboardType: TextInputType.number,
                controller: latController,
                decoration: const InputDecoration(
                    constraints: BoxConstraints(maxHeight: 48),
                    border: OutlineInputBorder(),
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black12,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    labelText: "Latitude",
                    labelStyle: TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w100)),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.green,
              child: Icon(
                SolarIconsBold.mapArrowDown,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: TextFormField(
                onChanged: (text) {
                  if (debounce.isActive) debounce.cancel();

                  // Start a new timer to trigger action after 1 second (adjust as needed)
                  debounce = Timer(const Duration(seconds: 1), () {
                    // Perform your action here when the user stops typing
                    // model.searchCoordinates();
                    double lat = double.parse(latController.text.trim());
                    double long = double.parse(longController.text.trim());
                    locationFuture(lat, long);
                  });
                },
                keyboardType: TextInputType.number,
                controller: longController,
                decoration: const InputDecoration(
                    constraints: BoxConstraints(maxHeight: 48),
                    border: OutlineInputBorder(),
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black12,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    labelText: "Longitude",
                    labelStyle: TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w100)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
