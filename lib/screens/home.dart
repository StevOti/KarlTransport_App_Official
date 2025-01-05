import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:karltransportapp/auth/main.dart';
import 'package:karltransportapp/components/info_card.dart';
import 'package:karltransportapp/screens/add_contract_screen.dart';
import 'package:karltransportapp/screens/completed_contracts_screen.dart';
import 'package:karltransportapp/screens/profile_screen.dart'; // Ensure ProfileScreen is imported
import 'package:karltransportapp/themes/colors.dart';
import 'package:karltransportapp/widgets/stream_contract.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase authentication import

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool show = true;
  int _selectedIndex = 0; // Track the selected index

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Navigate to the selected screen
    if (index == 0) {
      // Stay on HomeScreen, no action needed
    } else if (index == 1) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const CompletedContractsScreen()));
    } else if (index == 2) {
      // Navigate to ProfileScreen
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    }
  }

  // Logout function
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();  // Sign out from Firebase
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AuthPage()), // Navigate to Login screen
      );
    } catch (e) {
      // Handle any errors, such as network issues or failures to sign out
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error signing out. Please try again.')),
      );
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
          GButton(icon: Icons.person, text: 'Profile'), // Profile tab
        ],
      ),
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFF17203A),
        elevation: 10,
        toolbarHeight: 80.0,
        title: const Text("Home", style: TextStyle(color: Colors.white)),
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
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              leading: const Icon(Icons.home, color: Colors.white),
              title: const Text('Home', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
              leading: const Icon(Icons.person, color: Colors.white),
              title: const Text('Profile', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              onTap: () {
                logout();  // Call logout function
              },
              leading: const Icon(Icons.logout, color: Colors.white),
              title: const Text('Logout', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: show,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddContractScreen()));
          },
          backgroundColor: custom_green,
          child: const Icon(Icons.add, size: 30, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              setState(() {
                show = true;
              });
            }
            if (notification.direction == ScrollDirection.reverse) {
              setState(() {
                show = false;
              });
            }
            return true;
          },
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: StreamContract(false), // StreamContract now takes full available space
              ),
            ],
          ),
        ),
      ),
    );
  }
}
