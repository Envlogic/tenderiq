import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login_page.dart';
import 'screens/admin_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseDataConnect.instanceFor(
    connectorConfig: ConnectorConfig(
      'asia-south1',
      'default',
      'tenderiq-f763c-service',
    ),
    sdkType: CallerSDKType.generated,
  );
  final prefs = await SharedPreferences.getInstance();
  final userType = prefs.getString('usertype');
  runApp(TenderIQApp(userType: userType));
}

class TenderIQApp extends StatelessWidget {
  final String? userType;
  const TenderIQApp({super.key, this.userType});

  @override
  Widget build(BuildContext context) {
    Widget homeWidget;
    if (userType == null) {
      homeWidget = const LoginPage();
    } else if (userType == 'admin') {
      homeWidget = const AdminPage();
    } else {
      homeWidget = MainScreen();
    }
    return MaterialApp(
      title: 'Tender IQ',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: homeWidget,
      debugShowCheckedModeBanner: false,
    );
  }
}
