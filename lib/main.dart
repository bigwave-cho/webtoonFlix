import 'package:flutter/material.dart';
import 'package:toonflix/screens/home_screen.dart';
import 'package:toonflix/services/api_service.dart';

void main() {
  //기존 static을 안붙이면 인스턴스를 생성 후 메서드 사용가능.
  // ApiService().getTodaysToons();
  //static 모디파이어 설정
  ApiService.getTodaysToons();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
