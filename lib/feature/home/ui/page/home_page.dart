import 'package:flutter/material.dart';
import 'package:scalable_flutter_app_starter/core/extension/context.dart';
import 'package:scalable_flutter_app_starter/feature/user/ui/widget/profile_tab.dart';

import '../../../../core/ui/dialog/dialogs.dart';
import '../../../../core/ui/widget/news_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  late List<NewsItem> newsList; // Declare but don't initialize here

  late final List<_HomeTab> _tabs;

  @override
  void initState() {
    super.initState();

    // Initialize newsList here
    newsList = [
      NewsItem(
        title: '09/01/2024 - MEDIDA PREVENTIVA',
        description:
            'Defensoria suspende atendimento nesta terça-feira (9) no edifício Pantanal Business, em Cuiabá',
        imageUrl:
            'https://www.defensoria.mt.def.br/dpmt/cache/imagens/institucional_imagem_pq_Institucional_id_1365.jpg',
      ),
      NewsItem(
        title: '08/01/2024 - CONSULTA PÚBLICA',
        description:
            'Defensoria Pública quer ouvir sociedade sobre a implantação da inteligência artificial',
        imageUrl:
            'https://www.defensoria.mt.def.br/dpmt/cache/imagens/institucional_imagem_pq_Institucional_id_1364.jpg',
      ),
      // Add more news items as needed
    ];

    // Initialize _tabs here
    _tabs = <_HomeTab>[
      _HomeTab(
        label: 'Início',
        icon: Icons.home,
        builder: (context) => ListView.builder(
          itemCount: newsList.length,
          itemBuilder: (context, index) {
            return NewsItemWidget(newsItem: newsList[index]);
          },
        ),
      ),
      _HomeTab(
        label: 'Serviços',
        icon: Icons.work,
        builder: (context) => const Center(child: Text('Explorar serviços')),
      ),
      _HomeTab(
        label: 'Sair',
        icon: Icons.logout,
        builder: (context) => GestureDetector(
          onTap: () {
            Dialogs.showLogOutConfirmationDialog(context);
          },
          child: const Center(child: Text('Deslogar')),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final Widget body;
    final Widget? bottomNavigationBar;
    final content = _tabs[_selectedIndex].builder(context);

    if (context.isWide) {
      body = Row(
        children: [
          NavigationRail(
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
    );
  }

  void _handleTabSelection(int index) {
    if (index == 2) {
      Dialogs.showLogOutConfirmationDialog(context);
    }
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
