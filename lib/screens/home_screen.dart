import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/api_service.dart';

// with FutureBuilder
//FutureBuilder 덕에 stateful widget이 필요 없슈.
class HomeScreen extends StatelessWidget {
  //컴파일 후에도 데이터가 변화하므로 const 지우기
  HomeScreen({super.key});

  Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

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
        // FutureBuilder는 알아서 webtoons를 await해줌.
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Text('There is data!');
          }
          return const Text('Loading');
        },
      ),
    );
  }
}
