class ForecastResponse {
  String? cod;
  int? message;
  int? cnt;
  List<Forecast>? forecasts;
  City? city;

  ForecastResponse({
    this.cod,
    this.message,
    this.cnt,
    this.forecasts,
    this.city,
  });

  factory ForecastResponse.fromJson(Map<String, dynamic> json) => ForecastResponse(
    cod: json['cod'],
    message: json['message'],
    cnt: json['cnt'],
    forecasts: json['list'] == null ? [] : List<Forecast>.from(json['list']!.map((x) => Forecast.fromJson(x))),
    city: json['city'] == null ? null : City.fromJson(json['city']),
  );

  Map<String, dynamic> toJson() => {
    'cod': cod,
    'message': message,
    'cnt': cnt,
    'list': forecasts == null ? [] : List<dynamic>.from(forecasts!.map((x) => x.toJson())),
    'city': city?.toJson(),
  };
}

class City {
  int? id;
  String? name;
  Coord? coord;
  String? country;
  int? population;
  int? timezone;
  int? sunrise;
  int? sunset;

  City({
    this.id,
    this.name,
    this.coord,
    this.country,
    this.population,
    this.timezone,
    this.sunrise,
    this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json['id'],
    name: json['name'],
    coord: json['coord'] == null ? null : Coord.fromJson(json['coord']),
    country: json['country'],
    population: json['population'],
    timezone: json['timezone'],
    sunrise: json['sunrise'],
    sunset: json['sunset'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'coord': coord?.toJson(),
    'country': country,
    'population': population,
    'timezone': timezone,
    'sunrise': sunrise,
    'sunset': sunset,
  };
}

class Coord {
  double? lat;
  double? lon;

  Coord({
    this.lat,
    this.lon,
  });

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
    lat: json['lat']?.toDouble(),
    lon: json['lon']?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'lat': lat,
    'lon': lon,
  };
}

class Forecast {
  int? dt;
  Main? main;
  List<Weather>? weather;
  Clouds? clouds;
  Wind? wind;
  int? visibility;
  double? pop;
  Rain? rain;
  Sys? sys;
  DateTime? dtTxt;

  Forecast({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.rain,
    this.sys,
    this.dtTxt,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
    dt: json['dt'],
    main: json['main'] == null ? null : Main.fromJson(json['main']),
    weather: json['weather'] == null ? [] : List<Weather>.from(json['weather']!.map((x) => Weather.fromJson(x))),
    clouds: json['clouds'] == null ? null : Clouds.fromJson(json['clouds']),
    wind: json['wind'] == null ? null : Wind.fromJson(json['wind']),
    visibility: json['visibility'],
    pop: json['pop']?.toDouble(),
    rain: json['rain'] == null ? null : Rain.fromJson(json['rain']),
    sys: json['sys'] == null ? null : Sys.fromJson(json['sys']),
    dtTxt: json['dt_txt'] == null ? null : DateTime.parse(json['dt_txt']),
  );

  Map<String, dynamic> toJson() => {
    'dt': dt,
    'main': main?.toJson(),
    'weather': weather == null ? [] : List<dynamic>.from(weather!.map((x) => x.toJson())),
    'clouds': clouds?.toJson(),
    'wind': wind?.toJson(),
    'visibility': visibility,
    'pop': pop,
    'rain': rain?.toJson(),
    'sys': sys?.toJson(),
    'dt_txt': dtTxt?.toIso8601String(),
  };
}

class Clouds {
  int? all;

  Clouds({
    this.all,
  });

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
    all: json['all'],
  );

  Map<String, dynamic> toJson() => {
    'all': all,
  };
}

class Main {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? seaLevel;
  int? grndLevel;
  int? humidity;
  double? tempKf;

  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.seaLevel,
    this.grndLevel,
    this.humidity,
    this.tempKf,
  });

  factory Main.fromJson(Map<String, dynamic> json) => Main(
    temp: json['temp']?.toDouble(),
    feelsLike: json['feels_like']?.toDouble(),
    tempMin: json['temp_min']?.toDouble(),
    tempMax: json['temp_max']?.toDouble(),
    pressure: json['pressure'],
    seaLevel: json['sea_level'],
    grndLevel: json['grnd_level'],
    humidity: json['humidity'],
    tempKf: json['temp_kf']?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'temp': temp,
    'feels_like': feelsLike,
    'temp_min': tempMin,
    'temp_max': tempMax,
    'pressure': pressure,
    'sea_level': seaLevel,
    'grnd_level': grndLevel,
    'humidity': humidity,
    'temp_kf': tempKf,
  };
}

class Rain {
  double? the3H;

  Rain({
    this.the3H,
  });

  factory Rain.fromJson(Map<String, dynamic> json) => Rain(
    the3H: json['3h']?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    '3h': the3H,
  };
}

class Sys {
  String? pod;

  Sys({
    this.pod,
  });

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
    pod: json['pod'],
  );

  Map<String, dynamic> toJson() => {
    'pod': pod,
  };
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    id: json['id'],
    main: json['main'],
    description: json['description'],
    icon: json['icon'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'main': main,
    'description': description,
    'icon': icon,
  };
}

class Wind {
  double? speed;
  int? deg;
  double? gust;

  Wind({
    this.speed,
    this.deg,
    this.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
    speed: json['speed']?.toDouble(),
    deg: json['deg'],
    gust: json['gust']?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'speed': speed,
    'deg': deg,
    'gust': gust,
  };
}
