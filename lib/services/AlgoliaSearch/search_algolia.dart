import 'dart:async';
import 'package:algolia/algolia.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eye_test/theme/theme.dart';

import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  SearchBar({Key key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final Algolia _algoliaApp = AlgoliaApplication.algolia;
  String _searchTerm;

  Future<List<AlgoliaObjectSnapshot>> _operation(String input) async {
    var query = _algoliaApp.instance.index('ListOfApps').search(input);
    var querySnap = await query.getObjects();
    var results = querySnap.hits;
    return results;
  }
  Widget _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: LightColor.background,
       leading: Container(),
      actions: <Widget>[
        Expanded(
          child: TextField(
              autofocus: true,
              onChanged: (val) {
                setState(() {
                  _searchTerm = val;
                });
              },
              style: TextStyle(color: Colors.black, fontSize: 20),
              decoration:  InputDecoration(
                   
                  border: InputBorder.none,
                  hintText: 'search '.tr(),
                  hintStyle: TextStyle(color: Colors.black),
                  prefixIcon: const Icon(Icons.search, color: Colors.black))),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[

            StreamBuilder<List<AlgoliaObjectSnapshot>>(
              stream: Stream.fromFuture(_operation(_searchTerm)),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Image.asset('assets/png/pixeltrue-search-1.png'));
                } else {
                  var currSearchStuff = snapshot.data;

                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Container();
                    default:
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return CustomScrollView(
                          shrinkWrap: true,
                          slivers: <Widget>[
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return _searchTerm.isNotEmpty
                                      ? DisplaySearchResult(
                                          name: currSearchStuff[index]
                                              .data['name'],
                                          // appUsageInfos: currSearchStuff[index]
                                          //     .data['appsUsageModel'],
                                         totalDuration: currSearchStuff[index]
                                              .data['totalDuration'],
                                        )
                                      : Container();
                                },
                                childCount: currSearchStuff.length ?? 0,
                              ),
                            ),
                          ],
                        );
                      }
                  }
                }
              },
            ),
          ]),
        ),
      ),
    );
  }
}

class DisplaySearchResult extends StatelessWidget {
  final String name;
  final String appUsageInfos;
  final int totalDuration;

  DisplaySearchResult({Key key, this.name, this.appUsageInfos, this.totalDuration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text(
        name ?? '',
        style: TextStyle(color: Colors.black),
      ),
      // Text(
      //   appUsageInfos. ?? '',
      //   style: TextStyle(color: Colors.black),
      // ),
      Text(
        totalDuration.toString() ?? '',
        style: TextStyle(color: Colors.black),
      ),
      Divider(
        color: Colors.black,
      ),
      SizedBox(height: 20)
    ]);
  }
}

class AlgoliaApplication{
  static final Algolia algolia = Algolia.init(
    applicationId: 'FO2RGMNVSH', //ApplicationID
    apiKey: '5049b0fea8f0b0425341f49ed7d4a870', //search-only api key in flutter code
  );
}
