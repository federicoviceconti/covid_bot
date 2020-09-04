class Countries {
  List<Country> countries;

  Countries.fromJsonList(List<dynamic> json) {
    countries = json.map((it) => Country.fromJson(it)).toList();
  }
}

class Country {
  String name;
  String slug;
  String isoCode;

  Country.fromJson(json) {
    name = json['Country'];
    slug = json['Slug'];
    isoCode = json['ISO2'];
  }
}