import 'dart:io';
import 'dart:core';
import 'package:geolocator/geolocator.dart';


// You are here and people are all around you
// At any given moment we would like to be able to specify
// a radius and have the people within that radius returned to us.
// Write a function that takes in your current location
// and a radius and returns the people within that radius.
List<Object> getCoordsInRadius(
    List<Object> coords, Position location, double radius) {
  List<Object> closeCoords = [];
  double r_2 = radius * radius;
  for(int i=0; i<coords.length; i++) {
      Object point = coords[i];

      double xDist = num.abs(location.longitude - point.longitude);
      double yDist = num.abs(location.latitude - point.latitude);
      double dist = xDist**2 + yDist**2;
      if (dist <= radius) {
        closeCoords.add(point);
      }
  }
  return closeCoords;
}
