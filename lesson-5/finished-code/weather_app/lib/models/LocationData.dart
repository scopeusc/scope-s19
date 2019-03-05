class LocationData {
  final String title;
  final int woeid;

  LocationData({this.title,this.woeid});

  factory LocationData.fromJson(List<dynamic> json) {
    return LocationData(
      title: json[0]['title'],
      woeid: json[0]['woeid']
    );
  }
}