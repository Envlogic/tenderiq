import 'package:flutter/material.dart';
import '../generated/default_connector/default.dart';

class NotificationItem {
  final String message;
  final bool isNew;

  NotificationItem({required this.message, this.isNew = false});
}

class NotificationsPanel extends StatefulWidget {
  const NotificationsPanel({super.key});

  @override
  State<NotificationsPanel> createState() => _NotificationsPanelState();
}

class _NotificationsPanelState extends State<NotificationsPanel> {
  static const String userId = '6763ec20-b327-4b1a-8e55-fbc42b02c184';
  late Future<List<NotificationItem>> _futureNotifications;

  @override
  void initState() {
    super.initState();
    _futureNotifications = _fetchNotifications();
  }

  Future<List<NotificationItem>> _fetchNotifications() async {
    final builder = DefaultConnector.instance.getNotifications(userId: userId);
    final result = await builder.execute();
    return result.data.notifications
        .map((n) => NotificationItem(message: n.message, isNew: !n.isRead))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Notifications",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: FutureBuilder<List<NotificationItem>>(
              future: _futureNotifications,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: \\${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      "No notifications yet.",
                      style: TextStyle(color: Colors.black54),
                    ),
                  );
                }
                final notifications = snapshot.data!;
                return ListView.separated(
                  itemCount: notifications.length,
                  separatorBuilder:
                      (_, __) =>
                          Divider(height: 20, color: Colors.grey.shade300),
                  itemBuilder: (context, index) {
                    final item = notifications[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 4,
                      ),
                      child: Row(
                        children: [
                          if (item.isNew)
                            Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                            ),
                          Expanded(
                            child: Text(
                              item.message,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight:
                                    item.isNew
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
