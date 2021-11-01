import 'package:app/screens/history_screen.dart';
import 'package:app/screens/map_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Check history',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(HistoryScreen.routeName);
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Image.asset('assets/images/sky2.jpg'),
            SizedBox(height: 20),
            Text(
              'GPS track is the best way to know the locations of your devices in real time,no matter where you are you can always know the geographical location of the device .',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: EdgeInsets.all(25),
              child: FlatButton(
                child: Text(
                  'Start tracking',
                  style: TextStyle(fontSize: 20.0),
                ),
                color: Colors.purple,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).pushNamed(MapScreen.routeName);
                },
              ),
            )
          ],
        ));
  }
}
