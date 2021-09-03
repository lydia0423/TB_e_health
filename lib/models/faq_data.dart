
class FaqData {
  final String title;
  final String text;

  FaqData._({required this.title, required this.text});

  factory FaqData.fromJson(Map<String, dynamic> json) {
    return new FaqData._(
      title: json['title'],
      text: json['text'],
    );
  }

}

