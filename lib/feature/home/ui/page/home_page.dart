// ignore_for_file: cascade_invocations

import 'package:flutter/material.dart';
import 'package:scalable_flutter_app_starter/core/extension/context.dart';
import 'package:scalable_flutter_app_starter/core/ui/widget/news_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scalable_flutter_app_starter/feature/appbar/ui/appbar.dart';
import 'package:url_launcher/url_launcher.dart';

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
        builder: (context) => Center(
          child: Column(
            children: [
              // Stack(
              //   children: [
              //     Positioned(
              //       right: 0,
              //       child: IconButton(
              //         onPressed: () {},
              //         icon: const Icon(Icons.notifications),
              //         alignment: Alignment.topRight,
              //       ),
              //     ),
              //     Positioned(
              //       top: 0,
              //       right: 0,
              //       child: Container(
              //         width: 8,
              //         height: 8,
              //         decoration: const BoxDecoration(
              //           color: Colors.red,
              //           shape: BoxShape.circle,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logot.png',
                      width: 300,
                      height: 100,
                      color: const Color.fromARGB(255, 39, 99, 63),
                      alignment: AlignmentDirectional.center,
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.notifications,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // add search box
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    labelText: 'Qual serviço você procura?',
                    hintText: '',
                    prefixIcon: Icon(Icons.search),
                    focusColor: Color.fromARGB(255, 39, 99, 63),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 39, 99, 63),
                      ),
                    ),
                  ),
                  onChanged: filterSearchResults,
                ),
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
              // FloatingActionButton(
              //   backgroundColor: Colors.transparent,
              //   elevation: 0,
              //   highlightElevation: 0,
              //   disabledElevation: 0,
              //   hoverColor: Colors.transparent,
              //   onPressed: () async {
              //     const url = 'whatsapp://send?phone=+5565993291981';
              //     if (await canLaunchUrl(Uri.parse(url))) {
              //       await launchUrl(Uri.parse(url));
              //     } else {
              //       ScaffoldMessenger.of(context).showSnackBar(
              //         const SnackBar(
              //           content: Text('WhatsApp não está instalado.'),
              //         ),
              //       );
              //     }
              //   },
              //   child: const DecoratedBox(
              //     decoration: BoxDecoration(
              //       color: Colors.transparent,
              //       borderRadius: BorderRadius.all(
              //         Radius.circular(100),
              //       ),
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.transparent,
              //           spreadRadius: 1,
              //           blurRadius: 1,
              //           offset: Offset(3, 5),
              //         ),
              //       ],
              //     ),
              //     child: FaIcon(
              //       FontAwesomeIcons.whatsapp,
              //       size: 45,
              //       color: Colors.green,
              //     ),
              //   ),
              // ),
            ],
          ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
