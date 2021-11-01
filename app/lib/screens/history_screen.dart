import 'package:app/providers/locations.dart';
import 'package:app/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  static const routeName = '/history';

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  var _isLoading = false;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<Locations>(context, listen: false).fetchLocations().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  Future<void> _refreshLocations(BuildContext context) async {
    await Provider.of<Locations>(context, listen: false).fetchLocations();
  }

  @override
  Widget build(BuildContext context) {
    final locationsData = Provider.of<Locations>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('History'),
          leading: BackButton(
             color: Colors.white,
             onPressed : () => Navigator.pop(context)), 
          actions: <Widget>[
            TextButton(
              child: Text(
                'Start tracking',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(MapScreen.routeName);
              },
            ),
          ],
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () => _refreshLocations(context),
                child: SingleChildScrollView(
                  child: locationsData.points == null
                  ? Center(
                    child:Text('No locations'))
                  : DataTable(
                    dividerThickness: 5.0,
                    columns: [
                      DataColumn(label: Text('Latitude',style: TextStyle(color: Colors.black87, fontSize: 15,fontWeight:FontWeight.bold ))),
                      DataColumn(label: Text('Longitude',style: TextStyle(color: Colors.black87, fontSize: 15,fontWeight:FontWeight.bold ))),
                      DataColumn(label: Text('Time',style: TextStyle(color: Colors.black87, fontSize: 15,fontWeight:FontWeight.bold ))),
                    ],
                    rows: List.generate(locationsData.points!.length, (i) {
                      return DataRow(cells: [
                        DataCell(
                            Text(locationsData.points![i].latitude.toString())),
                        DataCell(
                            Text(locationsData.points![i].longitude.toString())),
                        DataCell(Text(DateTime.now().toString())),
                      ]);
                    }),
                  ),
                )));
  }
}
