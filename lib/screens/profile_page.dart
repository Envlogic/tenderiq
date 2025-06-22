import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../generated/default_connector/default.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const String userId = '6763ec20-b327-4b1a-8e55-fbc42b02c184';
  late Future<_ProfileData> _futureProfileData;

  @override
  void initState() {
    super.initState();
    _futureProfileData = _fetchProfileData();
  }

  Future<_ProfileData> _fetchProfileData() async {
    final userBuilder = DefaultConnector.instance.getUserProfile(
      userId: userId,
    );
    final countBuilder = DefaultConnector.instance.getFollowedTenderCount(
      userId: userId,
    );
    final userResult = await userBuilder.execute();
    final countResult = await countBuilder.execute();
    final followedCount = countResult.data.user?.activity?.tendersFollowed;
    return _ProfileData(
      user: userResult.data.user,
      followedCount: followedCount,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // final constrainedWidth = width > 1000 ? width * 0.7 : width * 0.95;

    return FutureBuilder<_ProfileData>(
      future: _futureProfileData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: \\${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.user == null) {
          return const Center(child: Text('User not found.'));
        }
        final user = snapshot.data!.user!;
        final followedCount = snapshot.data!.followedCount;
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 700),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _profileHeader(user),
                    const SizedBox(height: 24),
                    _sectionTitle("Company Details"),
                    _infoTile("Organization", user.company.name ?? "-"),
                    _infoTile("Registered Email", user.email ?? "-"),
                    // _infoTile("GSTIN", "29ABCDE1234F1Z5"), // Not in API
                    // _infoTile("Contact Number", "+91 9865 4310"), // Not in API
                    const SizedBox(height: 24),
                    _sectionTitle("Preferences"),
                    _infoTile(
                      "Preferred Categories",
                      user.preferences?.preferredCategories?.join(", ") ?? "-",
                    ),
                    _infoTile(
                      "Preferred Locations",
                      user.preferences?.preferredLocations?.join(", ") ?? "-",
                    ),
                    _infoTile(
                      "Notification Settings",
                      (user.preferences?.notificationEnabled ?? false)
                          ? "Enabled"
                          : "Disabled",
                    ),
                    const SizedBox(height: 24),
                    _sectionTitle("Your Activity"),
                    _infoTile(
                      "Tenders Followed",
                      followedCount?.toString() ?? "-",
                    ),
                    _infoTile(
                      "Tenders Submitted",
                      user.activity?.tendersSubmitted?.toString() ?? "-",
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.logout),
                        label: const Text("Logout"),
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.remove('usertype');
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (_) => const LoginPage(),
                            ),
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _profileHeader(GetUserProfileUser user) {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage:
              user.profilePicUrl != null && user.profilePicUrl!.isNotEmpty
                  ? NetworkImage(user.profilePicUrl!)
                  : const AssetImage("assets/userpic.jpg") as ImageProvider,
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.fullName ?? "-",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(user.email ?? "-", style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _infoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(
              "$label:",
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class _ProfileData {
  final GetUserProfileUser? user;
  final int? followedCount;
  _ProfileData({required this.user, required this.followedCount});
}
