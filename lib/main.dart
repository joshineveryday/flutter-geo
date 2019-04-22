import 'dart:async';
import 'dart:convert' show json;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'dart:io';

void main() => runApp(LocationApp());

class LocationApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Locator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LocationPage(title: 'Geolocation Algorithm'),
    );
  }
}

class DataLoader {
  List<Object> data;

   DataLoader() {
    }

  Future<List<Object>> loadData() async {
    var dataString = await rootBundle.loadString('lib/data/coordinates_100.json');
    var jsonData = await json.decode(dataString);
    return jsonData;
  }
}


class LocationPage extends StatefulWidget {
  LocationPage({Key key, this.title}) : super(key: key);

  final String title;
  
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<LocationPage> {
  List<int> _closestPeople = [];
  var stringData = '';

  void _handlePress() {

    setState(() {
      _closestPeople = []; 
    });
  }

  

  Future<Position> _loadDataRunAlgo() async{
    var jsonData = await DataLoader().loadData();
    print (jsonData);
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    return position;
  }
  
  //mock datafile
  //read from file

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Results',
            ),
            Text(
              '$_closestPeople',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadDataRunAlgo,
        tooltip: 'Find People',
        child: Icon(Icons.add),
      ),
    );
  }
}
