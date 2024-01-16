// ignore_for_file: cascade_invocations
import 'package:flutter/material.dart';
import 'package:scalable_flutter_app_starter/core/extension/context.dart';
import 'package:scalable_flutter_app_starter/core/ui/widget/news_item.dart';
import 'package:scalable_flutter_app_starter/feature/home/ui/page/home_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late final List<_HomeTab> _tabs;

  @override
  void initState() {
    super.initState();

    // Initialize _tabs here
    _tabs = <_HomeTab>[
      _HomeTab(
        label: 'Serviços',
        icon: Icons.connected_tv_rounded,
        builder: (context) => const HomeContent(),
      ),
      _HomeTab(
        label: 'Ouvidoria',
        icon: Icons.contact_mail,
        builder: (context) => const Center(child: Text('Sistema de Ouvidoria')),
      ),
      _HomeTab(
        label: 'Dúvidas',
        icon: Icons.question_mark_rounded,
        builder: (context) => const Center(child: Text('Dúvidas Frequentes')),
      ),
      _HomeTab(
        label: 'Perfil',
        icon: Icons.person,
        builder: (context) => const Center(child: Text('Perfil')),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final Widget body;
    final Widget? bottomNavigationBar;
    final content = _tabs[_selectedIndex].builder(context);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    if (context.isWide) {
      body = Row(
        children: [
          NavigationRail(
            selectedIconTheme: const IconThemeData(color: Color(0xFF27633f)),
            selectedIndex: _selectedIndex,
            onDestinationSelected: _handleTabSelection,
            destinations: [
              for (final tab in _tabs)
                NavigationRailDestination(
                  label: Text(tab.label),
                  icon: Icon(tab.icon),
                ),
            ],
          ),
          Expanded(child: content),
        ],
      );
      bottomNavigationBar = null;
    } else {
      body = SafeArea(child: content);
      bottomNavigationBar = BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _handleTabSelection,
        items: [
          for (final tab in _tabs)
            BottomNavigationBarItem(
              label: tab.label,
              icon: Icon(tab.icon),
            ),
        ],
      );
    }

    return Scaffold(
      body: body,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _handleTabSelection(int index) {
    // if (index == 4) {
    //   Dialogs.showLogOutConfirmationDialog(context);
    // }
    setState(() => _selectedIndex = index);
  }
}

class _HomeTab {
  const _HomeTab({
    required this.label,
    required this.icon,
    required this.builder,
  });

  final String label;
  final IconData icon;
  final WidgetBuilder builder;
}
