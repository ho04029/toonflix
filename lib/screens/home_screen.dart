import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 2,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "오늘의 웹툰",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.touch,
                  PointerDeviceKind.stylus,
                  PointerDeviceKind.unknown,
                },
              ),
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Expanded(child: makeList(snapshot)),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return Webtoon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },
      separatorBuilder: (context, index) => SizedBox(width: 40),
    );
  }
}
