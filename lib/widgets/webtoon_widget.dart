import 'package:flutter/material.dart';
import 'package:toonflix/screens/detail_screen.dart';

// 위젯 코드 분리
class Webtoon extends StatelessWidget {
  final String title, thumb, id;

  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    // 제스쳐 이벤트 감지하기
    return GestureDetector(
      onTap: () {
        //route: DetailScreen같은 Stateless Widget을 애니메이션효과로
        // 감싸서 스크린처럼 보이도록 만들어줌.
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true, //화면 전환 수평 수직 결정
            builder: (context) => DetailScreen(
              title: title,
              thumb: thumb,
              id: id,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 250,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  blurRadius: 15,
                  offset: const Offset(10, 10),
                  color: Colors.black.withOpacity(0.5),
                )
              ],
            ),
            child: Image.network(thumb),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
