import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;
  bool darkMode = true;  // your app is already dark themed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(color: Color(0xFF512D80)),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Color(0xFF512D80)),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          const Text(
            "General",
            style: TextStyle(
              color: Color(0xFF512D80),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          // Notifications toggle
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SwitchListTile(
              title: const Text(
                "Enable Notifications",
                style: TextStyle(color: Colors.white),
              ),
              value: notificationsEnabled,
              activeColor: Color(0xFF512D80),
              onChanged: (value) {
                setState(() {
                  notificationsEnabled = value;
                });
              },
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            "Appearance",
            style: TextStyle(
              color: Color(0xFF512D80),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          // Dark mode toggle
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SwitchListTile(
              title: const Text(
                "Dark Mode",
                style: TextStyle(color: Colors.white),
              ),
              value: darkMode,
              activeColor: Color(0xFF512D80),
              onChanged: (value) {
                setState(() {
                  darkMode = value;
                });
              },
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            "Account",
            style: TextStyle(
              color: Color(0xFF512D80),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          // Placeholder account options
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                ListTile(
                  title: const Text("Edit Profile", style: TextStyle(color: Colors.white)),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
                  onTap: () {},
                ),
                Divider(color: Colors.white24, height: 1),
                ListTile(
                  title: const Text("Change Password", style: TextStyle(color: Colors.white)),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
                  onTap: () {},
                ),
                Divider(color: Colors.white24, height: 1),
                ListTile(
                  title: const Text("Log Out", style: TextStyle(color: Colors.redAccent)),
                  trailing: const Icon(Icons.logout, color: Colors.redAccent),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
