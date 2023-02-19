import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode.dart';
import 'package:toonflix/services/api_service.dart';

// 유저가 툰 클릭하면 보여줄 screen 말이 screen이지 위젯임을 명심
class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // 아래 방법은 여전히 error
  // Future<WebtoonDetailModel> webtoon = ApiService.getToonById(widget.id);

  // date fetch 전에 이미 렌더링 될 것이기 때문에 좀 이따 할당해주기 위해 late 부여
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;

  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.getLatestEpisodesById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          // stateful로 컨버트되면서 별개의 클래스가 되기 때문에
          // widget을 통해 프로퍼티에 접근
          // widget이 DetailScreen 위젯을 가리킴.
          widget.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 2,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: widget.id, //기존 stateless였을 때는 id 였음. stateful되면서 widget.id
                child: Container(
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
                  child: Image.network(widget.thumb),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/*
Home screen에서는 ApiService 메서드가 아무런 arg도 요구하지 않았기에 stateless가 가능
Detail에서는 arg를 요구하고 초기에 arg전달이 불가하기 때문에 Stateful widget, late, initState로
해결
 */