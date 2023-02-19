import 'package:flutter/material.dart';
import 'package:toonflix/screens/home_screen.dart';
import 'package:toonflix/services/api_service.dart';

void main() {
  // api 클래스 실행해보기
  ApiService().getTodaysToons();
  runApp(const App());
}

class App extends StatelessWidget {
  //widget은 key를 가지고 있으며 ID처럼 사용된다.
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
