import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_model.dart';

//https://youtu.be/17Oh028Jpis?t=325 static에 대한 영상
/*
class Car {
  static int wheels = 4;
  Car (required this.wheels) // 접근 불가
}
var z4 = Car(4)
z4.wheels // 에러 접근 불가.

* static은 내부나 외부에서 this.를 통해서 접근이 안됨.
직접 해당 클래스를 통해서 접근이 가능

class Car {
  static int wheels = 4;
  Car (required Car.wheels) 
}
var z4 = Car(4)
Car.wheels //4

이번 코드에서 static을 사용한 이유는 매번 ApiService를 사용하기 위해서
인스턴스를 만들필요 없이 ApiService.gettodaysToons() 이런식으로 사용할 수 있도록 하기 위함.
 */
class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        final toon = WebtoonModel.fromJson(webtoon);
        webtoonInstances.add(toon);
      }
      return webtoonInstances;
    }
    throw Error();
  }
}
