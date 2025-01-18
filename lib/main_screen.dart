import 'package:attendanceqrscan/eventlist.dart';
import 'package:attendanceqrscan/qr_scanner.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Color blueColor = const Color(0xFF2C28BF);
  int _selectedIndex = 0;

  final List<Widget?> _pages = [
    EventListPage(),
    null,
    QRScannerPage(),
    null,
    null,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          BottomNavigationBar(
            backgroundColor: Colors.black,
            selectedItemColor: blueColor,
            unselectedItemColor: Colors.grey,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list_alt),
                label: 'Record',
              ),
              BottomNavigationBarItem(
                icon: SizedBox.shrink(), // An invisible widget as the icon
                label: '', // An empty string for the label
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.question_answer),
                label: 'Quiz',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: MediaQuery.of(context).size.width / 2 - 40,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = 2; // Handle QR Scanner tap
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: _selectedIndex == 2 ? 80 : 70,
                width: _selectedIndex == 2 ? 80 : 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    if (_selectedIndex == 2)
                      BoxShadow(
                        color: blueColor.withOpacity(0.4),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                  ],
                ),
                child: Icon(
                  Icons.qr_code_scanner,
                  color: blueColor,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(size.width / 2 - 35, 0);
    path.arcToPoint(
      Offset(size.width / 2 + 35, 0),
      radius: const Radius.circular(35),
      clockwise: false,
    );
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
