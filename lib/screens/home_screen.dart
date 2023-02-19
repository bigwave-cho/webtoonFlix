import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
//error : This class (or a class that this class inherits from) is marked as '@immutable',
// but one or more of its instance fields aren't final: HomeScreen.webtoons
// StatelessWidget인데 아래 webtoons를 상수 선언 안해줘서 그럼 final 추가
  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          '오늘의 웹툰',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 2,
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //## ListView : 많은 아이템을 보여줄 땐 column이나 row대신 ListView가 적당
            // 아래는 ListView 기초적 사용예제
            // return ListView(
            //   children: [
            //     for (var webtoon in snapshot.data!) Text(webtoon.title)
            //   ],
            // ); //근데 한번에 데이터 다 불러와서 메모리 부하 가능

            // ## ListView.builder는 viewport에 있는 데이터만 불러오고 벗어나면 삭제
            // return ListView.builder(
            //   scrollDirection: Axis.horizontal,
            //   itemCount: snapshot.data!.length,
            //   itemBuilder: (context, index) {
            //     //index 덕분에 해당되는 데이터만 불러오기 가능해짐
            //     print(index); // 스크롤하고 디버그 콘솔에서 확인 가능.
            //     var webtoon = snapshot.data![index];
            //     return Text(webtoon.title);
            //   },
            // );

            return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var webtoon = snapshot.data![index];
                  return Text(webtoon.title);
                },
                // itemBuilder의 위젯 사이에 놓여질 위젯 생성
                separatorBuilder: ((context, index) {
                  return const SizedBox(
                    width: 20,
                  );
                }),
                itemCount: snapshot.data!.length);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
