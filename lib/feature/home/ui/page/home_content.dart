import 'package:flutter/material.dart';
import 'package:scalable_flutter_app_starter/core/ui/widget/news_item.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({
    super.key,
  });

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  late List<NewsItem> newsList;
  final List<NewsItem> _filteredItems = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initialize newsList here
    newsList = [
      NewsItem(
        title: 'Agendamento',
        description:
            'Defensoria suspende atendimento nesta terça-feira (9) no edifício Pantanal Business, em Cuiabá',
        imageUrl: Icons.calendar_month,
      ),
      NewsItem(
        title: 'Meu processo',
        description:
            'Defensoria Pública quer ouvir sociedade sobre a implantação da inteligência artificial',
        imageUrl: Icons.folder,
      ),
      NewsItem(
        title: 'Ouvidoria',
        description:
            'Defensoria Pública quer ouvir sociedade sobre a implantação da inteligência artificial',
        imageUrl: Icons.contact_mail,
      ),
      NewsItem(
        title: 'Defensorias',
        description:
            'Defensoria Pública quer ouvir sociedade sobre a implantação da inteligência artificial',
        imageUrl: Icons.location_city_rounded,
      ),
    ];

    _filteredItems.addAll(newsList);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/logot.png',
                  width: 250,
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
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
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
              //onChanged: widget.onFilter,
              onChanged: filterSearchResults,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Flexible(
            child: GridView.builder(
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                return NewsItemWidget(newsItem: _filteredItems[index]);
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void filterSearchResults(String query) {
    final filteredList = <NewsItem>[];
    filteredList.addAll(newsList);

    if (query.isNotEmpty) {
      filteredList.retainWhere(
          (item) => item.title.toLowerCase().contains(query.toLowerCase()));
    } else {
      filteredList
        ..clear()
        ..addAll(newsList);
    }

    setState(() {
      _filteredItems
        ..clear()
        ..addAll(filteredList);
    });
  }
}
