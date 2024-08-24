import 'dart:math';
import 'dart:ui';
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
                // no back button
                automaticallyImplyLeading: false,
                expandedHeight: 240.0,
                titleSpacing: 0,
                centerTitle: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  // change title's horizontal padding. Make this in the center as the page is scrolled

                  titlePadding: EdgeInsets.only(
                    bottom: lerpDouble(10, 60, sqrt(_opacity))!,
                  ),
                  centerTitle: true,
                  title: Stack(
                    clipBehavior: Clip.none,
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
                              lerpDouble(0, 1, sqrt(_opacity))!,
                            ),
                            borderRadius: BorderRadius.circular(0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5 * _opacity * _opacity),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        '레스토랑 한국점',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  background: Image.network(
                    'https://www.eatright.org/-/media/images/eatright-landing-pages/foodgroupslp_804x482.jpg?as=0&w=967&rev=d0d1ce321d944bbe82024fff81c938e7&hash=E6474C8EFC5BE5F0DA9C32D4A797D10D',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (snapshot.connectionState == ConnectionState.waiting)
                SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              if (snapshot.hasError)
                SliverFillRemaining(
                  child: Center(
                    child: Text('An error occurred while loading the menu.'),
                  ),
                ),
              if (snapshot.hasData)
                SliverToBoxAdapter(
                  child: OrderPageBody(
                    sections: snapshot.data,
                    language: _language,
                    onLanguageChanged: _onLanguageChanged,
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

  OrderPageBody({
    Key? key,
    required this.sections,
    required this.language,
    required this.onLanguageChanged,
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
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Language: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                DropdownButton<String>(
                  value: language,
                  items: <String>['English', 'Korean', 'Chinese', 'Japanese'].map((String value) {
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
                ),
              ],
            ),
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
            return SectionWidget(section: sections[index], languageCode: languageCode);
          },
        ),
      ],
    );
  }
}
