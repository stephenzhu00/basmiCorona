import 'dart:convert';

import 'package:basmicorona/models/api_model.dart';
import 'package:http/http.dart' as http;

// Future<GlobalPositive> fetchGlobalPositive() async {
//   final response = await http.get('https://api.kawalcorona.com/positif/');
//   if (response.statusCode == 200) {
//     return GlobalPositive.fromJson(json.decode(response.body));
//   } else {
//     throw Exception('failed to load global data positive');
//   }
// }

// Future<GlobalRecovered> fetchGlobalRecovered() async {
//   final response = await http.get('https://api.kawalcorona.com/sembuh/');
//   if (response.statusCode == 200) {
//     return GlobalRecovered.fromJson(json.decode(response.body));
//   } else {
//     throw Exception('failed to load global data sembuh');
//   }
// }

// Future<GlobalDeath> fetchGlobalDeath() async {
//   final response = await http.get('https://api.kawalcorona.com/meninggal/');
//   if (response.statusCode == 200) {
//     return GlobalDeath.fromJson(json.decode(response.body));
//   } else {
//     throw Exception('failed to load global data meninggal');
//   }
// }

// Future<CountryList> fetchIndonesiaCase() async {
//   final response = await http.get('https://api.kawalcorona.com/indonesia');
//   if (response.statusCode == 200) {
//     return CountryList.fromJson(json.decode(response.body));
//   } else {
//     throw Exception('failed to load indonesia data');
//   }
// }

Future<List<Article>> getNews() async {
  List<Article> list;
  final response = await http.get(
      'http://newsapi.org/v2/top-headlines?country=id&category=health&apiKey=d920475c5b034095bbf7c064c780742d');
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    var rest = data["articles"] as List;
    list = rest.map<Article>((json) => Article.fromJson(json)).toList();
    print("List size: ${list.length}");
    return list;
    // return News.fromJson(json.decode(response.body));
  } else {
    throw Exception('failed to load indonesia data');
  }
}

// Emergency
Future<DataModel> fetchDataModel() async {
  final response = await http.get("https://covid19.mathdro.id/api");
  if (response.statusCode == 200) {
    var res = DataModel.fromMap(json.decode(response.body));
    return res;
  } else {
    return null;
  }
}

Future<DetailCountry> fetchIndonesiaData() async {
  final response =
      await http.get("https://covid19.mathdro.id/api/countries/idn");
  if (response.statusCode == 200) {
    var res = DetailCountry.fromMap(json.decode(response.body));
    return res;
  } else {
    return null;
  }
}

Future<Province> fetchProvinceData() async {
  final response =
      await http.get("https://indonesia-covid-19.mathdro.id/api/provinsi/");
  if (response.statusCode == 200) {
    List<Province> list;
    var data = json.decode(response.body);
    var listData = data["data"] as List;
    list = listData.map<Province>((json) => Province.fromJson(json)).toList();
    Province tempJakarta;
    for (int i = 0; i < list.length - 1; i++) {
      if (list.elementAt(i).fid == 11) {
        tempJakarta = list.elementAt(i);
      }
    }
    return tempJakarta;
  } else {
    throw Exception('failed to load indonesia data');
  }
}

Future<List<Province>> fetchListProvince() async {
  final response =
      await http.get("https://indonesia-covid-19.mathdro.id/api/provinsi/");
  if (response.statusCode == 200) {
    List<Province> list;
    var data = json.decode(response.body);
    var listData = data["data"] as List;
    list = listData.map<Province>((json) => Province.fromJson(json)).toList();
    list.sort((a, b) => a.fid.compareTo(b.fid));
    list.removeLast();
    return list;
  } else {
    throw Exception('failed to load province data');
  }
}
