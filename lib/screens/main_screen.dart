import 'package:flutter/material.dart';
import 'package:tenderiq_frontend/screens/discover_page.dart';
import 'package:tenderiq_frontend/screens/home_page.dart';
import 'package:tenderiq_frontend/screens/profile_page.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late TabController _mainTabController;
  late TabController _subTabController;
  String _selectedLanguage = 'en'; // Default language

  @override
  void initState() {
    _mainTabController = TabController(length: 3, vsync: this);
    _subTabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          automaticallyImplyLeading: false,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo
              const Text(
                "Tender IQ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),

              Expanded(
                child: Center(
                  child: SizedBox(
                    height: 40,
                    width: 330,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          tabBarTheme: TabBarThemeData(
                            dividerColor: Colors.transparent,
                            overlayColor: MaterialStatePropertyAll(
                              Colors.transparent,
                            ),
                          ),
                        ),
                        child: TabBar(
                          controller: _mainTabController,
                          indicator: BoxDecoration(
                            color: Colors.blueAccent.shade200,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          indicatorColor: Colors.transparent,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black87,
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                          tabs: const [
                            Tab(
                              child: SizedBox(
                                width: 90,
                                child: Center(child: Text('Home')),
                              ),
                            ),
                            Tab(
                              child: SizedBox(
                                width: 90,
                                child: Center(child: Text('Discover')),
                              ),
                            ),
                            Tab(
                              child: SizedBox(
                                width: 90,
                                child: Center(child: Text('Profile')),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedLanguage,
                    dropdownColor: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    style: const TextStyle(color: Colors.black),
                    icon: const Icon(Icons.language, color: Colors.black87),
                    items: const [
                      DropdownMenuItem(
                        value: 'en',
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                          ),
                          child: Text('English'),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'hi',
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                          ),
                          child: Text('Hindi'),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedLanguage = value!;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),

          toolbarHeight: 70,
        ),
        body: TabBarView(
          controller: _mainTabController,
          children: [HomePage(), DiscoverPage(), ProfilePage()],
        ),
      ),
    );
  }
}
