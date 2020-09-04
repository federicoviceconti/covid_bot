import 'package:covid_bot/api/base_api.dart';
import 'package:covid_bot/client/result_response.dart';
import 'package:covid_bot/covid_api/model/countries.dart';
import 'package:covid_bot/covid_api/model/day_country_case.dart';
import 'package:covid_bot/covid_api/model/stats_summary.dart';

class CovidApi extends BaseApi {
  CovidApi(client): super(client);

  Future<ResultResponse<Countries>> getCountries() async {
    return await makeGet(
      path: '/countries',
      convertFunc: (body) => Countries.fromJsonList(body)
    );
  }

  Future<ResultResponse<DayCountryCaseList>> getCasesFromDayOneByCountry(String countrySlug) async {
    return await makeGet(
      path: '/dayone/country/$countrySlug',
      convertFunc: (body) => DayCountryCaseList.fromJsonList(body)
    );
  }

  Future<ResultResponse<StatsSummary>> getSummary() async {
    return await makeGet(
      path: '/summary',
      convertFunc: (body) => StatsSummary.fromJson(body)
    );
  }

  Future<ResultResponse<DayCountryCaseList>> getTotalCasesByCountry(String countrySlug) async {
    return await makeGet(
      path: '/total/country/$countrySlug',
      convertFunc: (body) => DayCountryCaseList.fromJsonList(body)
    );
  }
}
