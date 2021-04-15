class MovieDetailModel {
  bool adult;
  String backdrop_path;
  BelongsToCollection belongs_to_collection;
  int budget;
  List<Genres> genres;
  String homepage;
  int id;
  String imdb_id;
  String original_language;
  String original_title;
  String overview;
  double popularity;
  String poster_path;
  List<ProductionCompanies> production_companies;
  List<ProductionCountries> production_countries;
  String release_date;
  int revenue;
  int runtime;
  List<SpokenLanguages> spoken_languages;
  String status;
  String tagline;
  String title;
  bool video;
  double vote_average;
  int vote_count;

  MovieDetailModel(
      {this.adult,
      this.backdrop_path,
      this.belongs_to_collection,
      this.budget,
      this.genres,
      this.homepage,
      this.id,
      this.imdb_id,
      this.original_language,
      this.original_title,
      this.overview,
      this.popularity,
      this.poster_path,
      this.production_companies,
      this.production_countries,
      this.release_date,
      this.revenue,
      this.runtime,
      this.spoken_languages,
      this.status,
      this.tagline,
      this.title,
      this.video,
      this.vote_average,
      this.vote_count});

  MovieDetailModel.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdrop_path = json['backdrop_path'];

    ///
    // belongs_to_collection = json['belongs_to_collection'] != null
    //     ? new BelongsToCollection.fromJson(json['belongs_to_collection'])
    //     : null;
    budget = json['budget'];
    if (json['genres'] != null) {
      genres = new List<Genres>();
      json['genres'].forEach((v) {
        genres.add(new Genres.fromJson(v));
      });
    }
    homepage = json['homepage'];
    id = json['id'];
    imdb_id = json['imdb_id'];
    original_language = json['original_language'];
    original_title = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    poster_path = json['poster_path'];
    if (json['production_companies'] != null) {
      production_companies = new List<ProductionCompanies>();
      json['production_companies'].forEach((v) {
        production_companies.add(new ProductionCompanies.fromJson(v));
      });
    }
    if (json['production_countries'] != null) {
      production_countries = new List<ProductionCountries>();
      json['production_countries'].forEach((v) {
        production_countries.add(new ProductionCountries.fromJson(v));
      });
    }
    release_date = json['release_date'];
    revenue = json['revenue'];
    runtime = json['runtime'];
    if (json['spoken_languages'] != null) {
      spoken_languages = new List<SpokenLanguages>();
      json['spoken_languages'].forEach((v) {
        spoken_languages.add(new SpokenLanguages.fromJson(v));
      });
    }
    status = json['status'];
    tagline = json['tagline'];
    title = json['title'];
    video = json['video'];
    vote_average = json['vote_average'];
    vote_count = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdrop_path;
    if (this.belongs_to_collection != null) {
      data['belongs_to_collection'] = this.belongs_to_collection.toJson();
    }
    data['budget'] = this.budget;
    if (this.genres != null) {
      data['genres'] = this.genres.map((v) => v.toJson()).toList();
    }
    data['homepage'] = this.homepage;
    data['id'] = this.id;
    data['imdb_id'] = this.imdb_id;
    data['original_language'] = this.original_language;
    data['original_title'] = this.original_title;
    data['overview'] = this.overview;
    data['popularity'] = this.popularity;
    data['poster_path'] = this.poster_path;
    if (this.production_companies != null) {
      data['production_companies'] =
          this.production_companies.map((v) => v.toJson()).toList();
    }
    if (this.production_countries != null) {
      data['production_countries'] =
          this.production_countries.map((v) => v.toJson()).toList();
    }
    data['release_date'] = this.release_date;
    data['revenue'] = this.revenue;
    data['runtime'] = this.runtime;
    if (this.spoken_languages != null) {
      data['spoken_languages'] =
          this.spoken_languages.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['tagline'] = this.tagline;
    data['title'] = this.title;
    data['video'] = this.video;
    data['vote_average'] = this.vote_average;
    data['vote_count'] = this.vote_count;
    return data;
  }
}

class BelongsToCollection {
  int id;
  String name;
  String poster_path;
  String backdropPath;

  BelongsToCollection(
      {this.id, this.name, this.poster_path, this.backdropPath});

  BelongsToCollection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    poster_path = json['poster_path'];
    backdropPath = json['backdrop_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['poster_path'] = this.poster_path;
    data['backdrop_path'] = this.backdropPath;
    return data;
  }
}

class Genres {
  int id;
  String name;

  Genres({this.id, this.name});

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class ProductionCompanies {
  int id;
  String logoPath;
  String name;
  String originCountry;

  ProductionCompanies({this.id, this.logoPath, this.name, this.originCountry});

  ProductionCompanies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logoPath = json['logo_path'];
    name = json['name'];
    originCountry = json['origin_country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['logo_path'] = this.logoPath;
    data['name'] = this.name;
    data['origin_country'] = this.originCountry;
    return data;
  }
}

class ProductionCountries {
  String iso31661;
  String name;

  ProductionCountries({this.iso31661, this.name});

  ProductionCountries.fromJson(Map<String, dynamic> json) {
    iso31661 = json['iso_3166_1'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iso_3166_1'] = this.iso31661;
    data['name'] = this.name;
    return data;
  }
}

class SpokenLanguages {
  String englishName;
  String iso_639_1;
  String name;

  SpokenLanguages({this.englishName, this.iso_639_1, this.name});

  SpokenLanguages.fromJson(Map<String, dynamic> json) {
    englishName = json['english_name'];
    iso_639_1 = json['iso_639_1'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['english_name'] = this.englishName;
    data['iso_639_1'] = this.iso_639_1;
    data['name'] = this.name;
    return data;
  }
}
