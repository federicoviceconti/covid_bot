class DayCountryCaseList {
  List<DayCountryCase> dayCases = [];

  DayCountryCaseList({
    this.dayCases,
  });

  DayCountryCaseList.fromJsonList(List<dynamic> json) {
    dayCases = json.map((it) {
      return DayCountryCase.fromJson(it);
    }).toList();
  }
}

class DayCountryCase {
  String country;
  String countryCode;
  String province;
  String city;
  String cityCode;
  String lat;
  String lon;
  int confirmed;
  int deaths;
  int recovered;
  int active;
  String dateTime;

  DayCountryCase({
    this.country,
    this.countryCode,
    this.province,
    this.city,
    this.cityCode,
    this.lat,
    this.lon,
    this.confirmed,
    this.deaths,
    this.recovered,
    this.active,
    this.dateTime,
  });

  DayCountryCase.fromJson(Map<dynamic, dynamic> json) {
    country = json['Country'];
    countryCode = json['CountryCode'];
    province = json['Province'];
    city = json['City'];
    cityCode = json['CityCode'];
    lat = json['Lat'];
    lon = json['Lon'];
    confirmed = json['Confirmed'];
    deaths = json['Deaths'];
    recovered = json['Recovered'];
    active = json['Active'];
    dateTime = json['Date'];
  }
}