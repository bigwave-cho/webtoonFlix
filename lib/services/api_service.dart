import 'package:http/http.dart' as http;
// 위처럼 as로 패키지를 namespace 지정이 가능하다.

class ApiService {
  final String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  final String today = "today";
  //api 요청을 위해 flutter는 http라는 패키지가 필요
  // flutter pub add http  or pubspec.yaml에 직접 추가
  void getTodaysToons() async {
    //http패키지의 get에 인자로 들어갈 url을 Uri타입으로 parsing.
    final url = Uri.parse('$baseUrl/$today');

    // Future<Response> get(Uri url, {Map<String, String>? headers})
    // 리턴 타입이 Future임을 알 수 있음.
    // Future은 await와 함께 사용함.
    // Future 타입은 현재가 아닌 미래에 받을 결과 값의 타입을 알려주는 것이고
    // 요청이 완료되었을 때 Response라는 타입을 반환함을 알려줌.
    final response = await http.get(url);
    //Response response : response의 타입이 Response임을 알 수 있음.

    if (response.statusCode == 200) {
      print(response.body);
      return;
    }
    throw Error();
  }
}
