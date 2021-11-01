import 'package:app/providers/auth.dart';
import 'package:app/providers/locations.dart';
import 'package:app/screens/auth_screen.dart';
import 'package:app/screens/history_screen.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth()
        ),
        ChangeNotifierProvider.value(
          value: Locations()
        ),
       
      ], 
      
        child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
              title: 'Tracking',
              theme: ThemeData(
                primarySwatch: Colors.purple,
                accentColor: Colors.deepOrange,
                fontFamily: 'Lato',
              ),
              debugShowCheckedModeBanner :false,
              home: auth.isAuth ? HomeScreen() : AuthScreen(),
              routes: {
                MapScreen.routeName : (ctx) => MapScreen(),
                HistoryScreen.routeName : (ctx) => HistoryScreen()
                
              },
            ),
      ),
    );
  }
}
