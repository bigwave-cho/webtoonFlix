import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_model.dart';

class ApiService {
  final String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  final String today = "today";

//async함수는 Future타입을 반환
  Future<List<WebtoonModel>> getTodaysToons() async {
    // async : 비동기 함수로 await 지정 시 해당 await문은 동기적으로 실행됨.
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      //response의 body프로퍼티의 타입은 String임을 확인.
      //따라서 json 으로 decode -> dynamic타입으로 변환(any)해서 반환
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        //webtoon -> {title:...}
        //api로부터 json을 WebtoonModle의 named constructor fromJson을 통해서 인스턴스 생성.
        final toon = WebtoonModel.fromJson(webtoon);
        //모델 클래스를 통해 초기화된 클래스를 toon에 할당하여 인스턴스 생성.
        webtoonInstances.add(toon);
      }
      return webtoonInstances;
    }
    throw Error();
  }
}
