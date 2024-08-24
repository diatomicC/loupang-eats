import 'dart:math';
import 'package:flutter/material.dart';
import 'package:zzk/logic/csvReader.dart';
import '../classes/FoodSectionClass.dart';
import 'sub/body.dart';

class OrderPage extends StatefulWidget {
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  ScrollController _scrollController = ScrollController();
  double _opacity = 1.0;
  String _language = 'Chinese';
  bool _isGridMode = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final scrollPosition = _scrollController.offset;
    final maxScroll = 150.0;

    setState(() {
      _opacity = 1.0 - (scrollPosition / maxScroll).clamp(0.0, 1.0);
    });
  }

  Future<List<FoodSection>> menuData = read();

  void _onLanguageChanged(String newLanguage) {
    setState(() {
      _language = newLanguage;
    });
  }

  void _toggleViewMode() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(seconds: 1)); // 로딩 시간 설정
    setState(() {
      _isGridMode = !_isGridMode;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: menuData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Scaffold(
          body: CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 240.0,
                titleSpacing: 0,
                centerTitle: false,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  title: Container(
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: -8 * 2,
                          right: -8 * 2,
                          top: -4 * 2,
                          bottom: -4 * 2,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.lerp(
                                Theme.of(context).appBarTheme.backgroundColor,
                                Colors.white,
                                sqrt(_opacity),
                              ),
                              borderRadius: BorderRadius.circular(0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.5 * _opacity * _opacity),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          'Our Menu',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  background: Image.network(
                    'https://www.eatright.org/-/media/images/eatright-landing-pages/foodgroupslp_804x482.jpg?as=0&w=967&rev=d0d1ce321d944bbe82024fff81c938e7&hash=E6474C8EFC5BE5F0DA9C32D4A797D10D',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (_isLoading) // 로딩 중일 때 표시
                SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (snapshot.connectionState == ConnectionState.waiting)
                SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (snapshot.hasError)
                SliverFillRemaining(
                  child: Center(
                    child: Text('An error occurred while loading the menu.'),
                  ),
                )
              else if (snapshot.hasData)
                SliverToBoxAdapter(
                  child: OrderPageBody(
                    sections: snapshot.data,
                    language: _language,
                    onLanguageChanged: _onLanguageChanged,
                    isGridMode: _isGridMode,
                    onToggleViewMode: _toggleViewMode,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class OrderPageBody extends StatelessWidget {
  final List<FoodSection> sections;
  final String language;
  final Function(String) onLanguageChanged;
  final bool isGridMode;
  final VoidCallback onToggleViewMode;

  OrderPageBody({
    Key? key,
    required this.sections,
    required this.language,
    required this.onLanguageChanged,
    required this.isGridMode,
    required this.onToggleViewMode,
  }) : super(key: key);

  final Map<String, String> languageCodeMap = {
    'English': 'EN',
    'Korean': 'KO',
    'Chinese': 'ZH',
    'Japanese': 'JA',
  };

  @override
  Widget build(BuildContext context) {
    String languageCode = languageCodeMap[language] ?? 'ZH';

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Language: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: DropdownButton<String>(
                        value: language,
                        items: <String>[
                          'English',
                          'Korean',
                          'Chinese',
                          'Japanese'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          if (value != null) {
                            onLanguageChanged(value);
                          }
                        },
                        alignment: Alignment.center,
                        isExpanded: false,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(isGridMode ? Icons.list : Icons.grid_view),
                onPressed: onToggleViewMode,
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.grey,
          thickness: 1,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: sections.length,
          itemBuilder: (BuildContext context, int index) {
            return SectionWidget(
              section: sections[index],
              languageCode: languageCode,
              isGridMode: isGridMode,
            );
          },
        ),
      ],
    );
  }
}
