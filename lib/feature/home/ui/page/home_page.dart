// ignore_for_file: cascade_invocations

import 'package:flutter/material.dart';
import 'package:scalable_flutter_app_starter/core/extension/context.dart';

import 'package:scalable_flutter_app_starter/core/ui/widget/news_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  late List<NewsItem> newsList;

  late final List<_HomeTab> _tabs;

  final List<String> _items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5'
  ];

  final List<String> _filteredItems = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _filteredItems.addAll(_items);
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
        // builder: (context) => ListView.builder(
        //   itemCount: newsList.length,
        //   itemBuilder: (context, index) {
        //     return NewsItemWidget(newsItem: newsList[index]);
        //   },
        // ),
        // send to route /home
        builder: (context) => Center(
          child: Column(
            children: [
              Image.asset(
                'assets/images/logot.png',
                //width: 100,
                //height: 100,
                color: const Color.fromARGB(255, 39, 99, 63),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: newsList.length,
                  itemBuilder: (context, index) {
                    return NewsItemWidget(newsItem: newsList[index]);
                  },
                ),
              ),
            ],
          ),
          // child: TextField(
          //   controller: _searchController,
          //   onChanged: filterSearchResults,
          //   decoration: const InputDecoration(
          //     hintText: 'Search',
          //     border: InputBorder.none,
          //   ),
          // ),
        ),
      ),
      _HomeTab(
        label: 'Serviços',
        icon: Icons.work,
        builder: (context) => const Center(child: Text('Explorar serviços')),
      ),
      _HomeTab(
        label: 'Ouvidoria',
        icon: Icons.feedback,
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
      // _HomeTab(
      //   label: 'Perfil',
      //   icon: Icons.person,
      //   builder: (context) => GestureDetector(
      //     onTap: () {
      //       Dialogs.showLogOutConfirmationDialog(context);
      //     },
      //     child: const Center(child: Text('Deslogar')),
      //   ),
      // ),
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
            //backgroundColor: const Color(0xFF27633f),
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
        //backgroundColor: const Color(0xFF27633f),
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
    // if (index == 4) {
    //   Dialogs.showLogOutConfirmationDialog(context);
    // }
    setState(() => _selectedIndex = index);
  }

  void filterSearchResults(String query) {
    final filteredList = <String>[];
    filteredList.addAll(_items);

    if (query.isNotEmpty) {
      filteredList.retainWhere(
          (item) => item.toLowerCase().contains(query.toLowerCase()));
    }

    setState(() {
      _filteredItems
        ..clear()
        ..addAll(filteredList);
    });
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
