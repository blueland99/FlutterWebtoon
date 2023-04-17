import 'package:flutter/material.dart';
import 'package:flutter_webtoon/models/webtoon_model.dart';
import 'package:flutter_webtoon/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        shadowColor: Colors.grey.withOpacity(0.3),
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text(
          '오늘의 웹툰',
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: makeList(snapshot),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<dynamic> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    offset: const Offset(5, 5),
                    color: Colors.black.withOpacity(0.5),
                  )
                ],
              ),
              clipBehavior: Clip.hardEdge,
              width: 250,
              child: Image.network(
                webtoon.thumb,
                headers: const {
                  "User-Agent":
                      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              webtoon.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
    );
  }
}
