import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:karltransportapp/components/info_card.dart';
import 'package:karltransportapp/screens/home.dart';
import 'package:karltransportapp/themes/colors.dart';
import 'package:karltransportapp/widgets/stream_contract.dart';

class CompletedContractsScreen extends StatefulWidget {
  const CompletedContractsScreen({super.key});

  @override
  _CompletedContractsScreenState createState() => _CompletedContractsScreenState();
}

class _CompletedContractsScreenState extends State<CompletedContractsScreen> {
  int _selectedIndex = 1; // Set this to 1 for the completed screen

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Navigate to the selected screen
    if (index == 0) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else if (index == 1) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const CompletedContractsScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GNav(
        backgroundColor: const Color(0xFF17203A),
        color: Colors.white,
        activeColor: Colors.white,
        gap: 8,
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          _onItemTapped(index);
        },
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.document_scanner,
            text: 'Completed',
          ),
          GButton(icon: Icons.person, text: 'Profile'),
          // GButton(icon: Icons.settings, text: 'Settings'),
        ],
      ),
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFF17203A),
        elevation: 10,
        toolbarHeight: 80.0,
        title: const Text("Completed Contracts", style: TextStyle(color: Colors.white)),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Action for notifications
            },
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF17203A),
        child: ListView(
          children: [
            const InfoCard(name: 'User Name', email: 'User Email'),
            const Padding(
              padding: EdgeInsets.only(left: 24),
              child: Divider(
                color: Colors.white24,
                thickness: 1,
              ),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.home, color: Colors.white),
              title: const Text('Home', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.person, color: Colors.white),
              title: const Text('Profile', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.logout, color: Colors.white),
              title: const Text('Logout', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: StreamContract(true), // Assuming true means completed contracts
      ),
    );
  }
}
