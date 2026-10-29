import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/footer.dart';
import '../../discover/screens/discoverTab.dart';
import '../../destinations/screens/destinationsTab.dart';
import '../../schedule/screens/guideTab.dart';
import '../../schedule/screens/plannerTab.dart';
import '../../bookings/screens/bookingsTab.dart';
import '../../profile/screens/profileAccount.dart';
import '../../chat/screens/chatScreen.dart';

part 'mainScreenUI.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _navItems = const [
    {
      'icon': Icons.home_outlined,
      'activeIcon': Icons.home_rounded,
      'label': 'Home',
    },
    {
      'icon': Icons.explore_outlined,
      'activeIcon': Icons.explore_rounded,
      'label': 'Explore',
    },
    {
      'icon': Icons.calendar_month_outlined,
      'activeIcon': Icons.calendar_month_rounded,
      'label': 'Schedule',
    },
    {
      'icon': Icons.receipt_long_outlined,
      'activeIcon': Icons.receipt_long_rounded,
      'label': 'Booking',
    },
    {
      'icon': Icons.person_outline_rounded,
      'activeIcon': Icons.person_rounded,
      'label': 'Account',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth >= 1000;
    final bool isTablet = screenWidth >= 650 && screenWidth < 1000;
    final theme = Theme.of(context);

    final List<Widget> tabs = [
      DiscoverTab(
        onSelectPackage: (packageName) {
          setState(() => _selectedIndex = 5);
        },
      ),
      DestinationsTab(
        onSelectPackage: (packageName) {
          setState(() => _selectedIndex = 5);
        },
      ),
      const GuideTab(),
      BookingsTab(
        onNavigateToChat: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen()));
        },
        onBack: () => setState(() => _selectedIndex = 0),
      ),
      const ProfileAccountScreen(showBackButton: false),
      PlannerTab(
        onBack: () => setState(() => _selectedIndex = 0),
      ),
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Row(
        children: [
          if (isDesktop) _buildDesktopSidebar(theme) else if (isTablet) _buildTabletNavigationRail(theme),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: tabs,
            ),
          ),
        ],
      ),
      bottomNavigationBar: (!isDesktop && !isTablet && _selectedIndex < 5)
          ? Footer(
              selectedIndex: _selectedIndex,
              navItems: _navItems,
              onDestinationSelected: (index) {
                setState(() => _selectedIndex = index);
              },
            )
          : null,
    );
  }
}
