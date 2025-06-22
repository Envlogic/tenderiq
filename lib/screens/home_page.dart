import 'package:flutter/material.dart';
import 'package:tenderiq_frontend/components/recommended_tenders_view.dart';
import 'package:tenderiq_frontend/components/notification.dart';
import 'package:tenderiq_frontend/components/watch_list.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _subTabController;

  @override
  void initState() {
    _subTabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var notifcation = NotificationsPanel();
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              isMobile
                  ? Column(
                    children: [
                      Expanded(child: tabbedTendersView()),
                      const SizedBox(height: 16),
                      notifcation,
                    ],
                  )
                  : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Expanded(child: tabbedTendersView())],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(flex: 1, child: notifcation),
                    ],
                  ),
        );
      },
    );
  }

  Widget tabbedTendersView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: DefaultTabController(
                length: 2,
                child: SizedBox(
                  height: 40,
                  width: 280,
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
                      controller: _subTabController,
                      indicator: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      indicatorColor: Colors.transparent,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.black87,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: const [
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.thumb_up_alt_outlined, size: 18),
                              SizedBox(width: 5),
                              Text("Recommend"),
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.star_outline, size: 18),
                              SizedBox(width: 5),
                              Text("Watch List"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.filter_list, size: 18),
              label: const Text("Filter"),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Expanded(
          child: TabBarView(
            controller: _subTabController,
            children: [RecommendedTendersView(), WatchList()],
          ),
        ),
      ],
    );
  }
}
