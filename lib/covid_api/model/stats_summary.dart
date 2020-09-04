class StatsSummary {
  GlobalStats globalStats;
  List<CountryStats> countryStatList;

  StatsSummary.fromJson(Map<dynamic, dynamic> json) {
    globalStats = GlobalStats.fromJson(json['Global']);
    countryStatList = json['Countries'].map((it) => CountryStats.fromJson(it)).toList().cast<CountryStats>();
  }

  @override
  String toString() => 'globalStats $globalStats\ncountryStatList $countryStatList';
}

class GlobalStats {
  int newConfirmed;
  int totalConfirmed;
  int newDeaths;
  int totalDeaths;
  int newRecovered;
  int totalRecovered;
  
  GlobalStats.fromJson(json) {
    newConfirmed = json['NewConfirmed'];
    totalConfirmed = json['TotalConfirmed'];
    newDeaths = json['NewDeaths'];
    totalDeaths = json['TotalDeaths'];
    newRecovered = json['NewRecovered'];
    totalRecovered = json['TotalRecovered'];
  }

  @override
  String toString() {
    return 'newConfirmed $totalConfirmed totalConfirmed, $newDeaths newDeaths, $totalDeaths totalDeaths, $newRecovered newRecovered, $totalRecovered totalRecovered';
  }
}

class CountryStats {
  String country;
  String countryCode;
  String slug;
  int newConfirmed;
  int totalConfirmed;
  int newDeaths;
  int totalDeaths;
  int newRecovered;
  int totalRecovered;
  String date;

  CountryStats.fromJson(json) {
    country = json['Country'];
    countryCode = json['CountryCode'];
    slug = json['Slug'];
    newConfirmed = json['NewConfirmed'];
    totalConfirmed = json['TotalConfirmed'];
    newDeaths = json['NewDeaths'];
    totalDeaths = json['TotalDeaths'];
    newRecovered = json['NewRecovered'];
    totalRecovered = json['TotalRecovered'];
    date = json['Date'];
  }

  @override
  String toString() {
    return 'country $country countryCode $countryCode slug $slug newConfirmed $newConfirmed totalConfirmed $totalConfirmed newDeaths $newDeaths totalDeaths $totalDeaths newRecovered $newRecovered totalRecovered $totalRecovered date $date';
  }
}