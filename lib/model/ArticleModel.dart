class Articlemodel {
  final String title;
  final String desc;
  final String? image;

  Articlemodel({required this.title, required this.desc, required this.image});

  factory Articlemodel.fromJson(Map<String, dynamic> json) {
    return Articlemodel(
        title: json["title"] ?? "no title",
        desc: json["description"] ?? "no description",
        image: json["urlToImage"] ?? "no image");
  }
}
