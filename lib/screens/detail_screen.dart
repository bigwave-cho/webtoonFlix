import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode.dart';
import 'package:toonflix/services/api_service.dart';

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
          widget.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
            vertical: 50,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.id,
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
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: webtoon,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.about,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              '${snapshot.data!.genre} / ${snapshot.data!.age}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                  return const Text('Loading');
                },
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: episodes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    //ListView써도 되지만 ListView는 세팅할 것이 많음
                    // 그래서 리스트가 적다면 Column등으로 해도 괜찮음.
                    return Column(
                      children: [
                        for (var epidsode in snapshot.data!)
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.green.shade400,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 10,
                                    offset: const Offset(1, 1),
                                    color: Colors.grey.withOpacity(0.8),
                                  ),
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      epidsode.title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.chevron_right_rounded,
                                      color: Colors.white,
                                    )
                                  ]),
                            ),
                          )
                      ],
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
