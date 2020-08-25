import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

// class GlobalPositive {
// // {"name":"Total Positif","value":"19,379,517"}
//   final String name;
//   final String value;
//   GlobalPositive({this.name, this.value});
//   factory GlobalPositive.fromJson(Map<String, dynamic> json) {
//     return GlobalPositive(
//       name: json['name'],
//       value: json['value'],
//     );
//   }
// }

// class GlobalRecovered {
// // {"name":"Total Positif","value":"19,379,517"}
//   final String name;
//   final String value;
//   GlobalRecovered({this.name, this.value});
//   factory GlobalRecovered.fromJson(Map<String, dynamic> json) {
//     return GlobalRecovered(
//       name: json['name'],
//       value: json['value'],
//     );
//   }
// }

// class GlobalDeath {
// // {"name":"Total Positif","value":"19,379,517"}
//   final String name;
//   final String value;
//   GlobalDeath({this.name, this.value});
//   factory GlobalDeath.fromJson(Map<String, dynamic> json) {
//     return GlobalDeath(
//       name: json['name'],
//       value: json['value'],
//     );
//   }
// }

class CountryList {
  final List<Country> countries;
  CountryList({this.countries});
  factory CountryList.fromJson(List<dynamic> parsedJson) {
    List<Country> countries = new List<Country>();
    countries = parsedJson.map((i) => Country.fromJson(i)).toList();
    return new CountryList(countries: countries);
  }
}

class Country {
  // [{"name":"Indonesia","positif":"121,226","sembuh":"77,557","meninggal":"5,593","dirawat":"38,076"}]
  final String name;
  final String positive;
  final String recovered;
  final String death;
  final String hospitalized;
  Country(
      {this.name,
      this.positive,
      this.recovered,
      this.death,
      this.hospitalized});
  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
        name: json['name'],
        positive: json['positif'],
        recovered: json['sembuh'],
        death: json['meninggal'],
        hospitalized: json['dirawat']);
  }
}

// FOR NEWS API
// {"status":"ok","totalResults":70,"articles":[
// {"source":{"id":null,"name":"Jawapos.com"},"author":"JawaPos.com","title":"Dokter ","description":"Korona.","url":"https://www.jawapos.com",
// "urlToImage":"https://cdn-asset.jawapos.com","publishedAt":"2020-08-13T08:36:48Z","content":"JawaPos.com [+2111 chars]"}
class News {
  String status;
  int totalResults;
  List<Article> articles;

  News({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from(
            json["articles"].map((x) => Article.fromJson(x))),
      );
}

class Article {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  DateTime publishedAt;
  String content;

  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: Source.fromJson(json["source"]),
        author: json["author"] == null ? null : json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"] == null ? null : json["content"],
      );
}

class Source {
  String id;
  String name;

  Source({
    this.id,
    this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"] == null ? null : json["id"],
        name: json["name"],
      );
}

// EMERGENCY
class DataModel {
  Confirmed confirmed;
  Confirmed recovered;
  Confirmed deaths;
  String dailySummary;
  CountryDetail dailyTimeSeries;
  String image;
  String source;
  String countries;
  CountryDetail countryDetail;
  DateTime lastUpdate;

  DataModel({
    @required this.confirmed,
    @required this.recovered,
    @required this.deaths,
    @required this.dailySummary,
    @required this.dailyTimeSeries,
    @required this.image,
    @required this.source,
    @required this.countries,
    @required this.countryDetail,
    @required this.lastUpdate,
  });

  factory DataModel.fromMap(Map<String, dynamic> json) => DataModel(
        confirmed: json["confirmed"] == null
            ? null
            : Confirmed.fromMap(json["confirmed"]),
        recovered: json["recovered"] == null
            ? null
            : Confirmed.fromMap(json["recovered"]),
        deaths:
            json["deaths"] == null ? null : Confirmed.fromMap(json["deaths"]),
        dailySummary:
            json["dailySummary"] == null ? null : json["dailySummary"],
        dailyTimeSeries: json["dailyTimeSeries"] == null
            ? null
            : CountryDetail.fromMap(json["dailyTimeSeries"]),
        image: json["image"] == null ? null : json["image"],
        source: json["source"] == null ? null : json["source"],
        countries: json["countries"] == null ? null : json["countries"],
        countryDetail: json["countryDetail"] == null
            ? null
            : CountryDetail.fromMap(json["countryDetail"]),
        lastUpdate: json["lastUpdate"] == null
            ? null
            : DateTime.parse(json["lastUpdate"]),
      );

  Map<String, dynamic> toMap() => {
        "confirmed": confirmed == null ? null : confirmed.toMap(),
        "recovered": recovered == null ? null : recovered.toMap(),
        "deaths": deaths == null ? null : deaths.toMap(),
        "dailySummary": dailySummary == null ? null : dailySummary,
        "dailyTimeSeries":
            dailyTimeSeries == null ? null : dailyTimeSeries.toMap(),
        "image": image == null ? null : image,
        "source": source == null ? null : source,
        "countries": countries == null ? null : countries,
        "countryDetail": countryDetail == null ? null : countryDetail.toMap(),
        "lastUpdate": lastUpdate == null ? null : lastUpdate.toIso8601String(),
      };
}

class DetailCountry {
  Confirmed confirmed;
  Confirmed recovered;
  Confirmed deaths;
  DateTime lastUpdate;

  DetailCountry({
    @required this.confirmed,
    @required this.recovered,
    @required this.deaths,
    @required this.lastUpdate,
  });

  factory DetailCountry.fromMap(Map<String, dynamic> json) => DetailCountry(
        confirmed: json["confirmed"] == null
            ? null
            : Confirmed.fromMap(json["confirmed"]),
        recovered: json["recovered"] == null
            ? null
            : Confirmed.fromMap(json["recovered"]),
        deaths:
            json["deaths"] == null ? null : Confirmed.fromMap(json["deaths"]),
        lastUpdate: json["lastUpdate"] == null
            ? null
            : DateTime.parse(json["lastUpdate"]),
      );

  Map<String, dynamic> toMap() => {
        "confirmed": confirmed == null ? null : confirmed.toMap(),
        "recovered": recovered == null ? null : recovered.toMap(),
        "deaths": deaths == null ? null : deaths.toMap(),
        "lastUpdate": lastUpdate == null ? null : lastUpdate.toIso8601String(),
      };
}

class Confirmed {
  int value;
  String detail;

  Confirmed({
    @required this.value,
    @required this.detail,
  });

  factory Confirmed.fromMap(Map<String, dynamic> json) => Confirmed(
        value: json["value"] == null ? null : json["value"],
        detail: json["detail"] == null ? null : json["detail"],
      );

  Map<String, dynamic> toMap() => {
        "value": value == null ? null : value,
        "detail": detail == null ? null : detail,
      };
}

class CountryDetail {
  String pattern;
  String example;

  CountryDetail({
    @required this.pattern,
    @required this.example,
  });

  factory CountryDetail.fromMap(Map<String, dynamic> json) => CountryDetail(
        pattern: json["pattern"] == null ? null : json["pattern"],
        example: json["example"] == null ? null : json["example"],
      );

  Map<String, dynamic> toMap() => {
        "pattern": pattern == null ? null : pattern,
        "example": example == null ? null : example,
      };
}

class ProvinceList {
  final List<Province> provinces;
  ProvinceList({this.provinces});
  factory ProvinceList.fromJson(List<dynamic> parsedJson) {
    List<Province> provinces = new List<Province>();
    provinces = parsedJson.map((i) => Province.fromJson(i)).toList();
    return new ProvinceList(provinces: provinces);
  }
}

class Province {
  int fid;
  int kodeProvi;
  String provinsi;
  int positif;
  int sembuh;
  int meninggal;
  Province(
      {this.fid,
      this.kodeProvi,
      this.provinsi,
      this.positif,
      this.sembuh,
      this.meninggal});
  factory Province.fromJson(Map<String, dynamic> json) => Province(
      fid: json["fid"],
      kodeProvi: json["kodeProvi"],
      provinsi: json["provinsi"],
      positif: json["kasusPosi"],
      sembuh: json["kasusSemb"],
      meninggal: json["kasusMeni"]);
}
