// api get 받은 리스트 요소들을 클래스 리스트로 만들기
class WebtoonModel {
  final String title, thumb, id;

  //named constructor
  //클래스의 프로퍼티를 json으로 초기화
  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
}
