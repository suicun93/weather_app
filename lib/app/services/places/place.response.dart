class Place {
  String? name;
  Map<String, String>? localNames;
  double? lat;
  double? lon;
  String? country;
  String? state;

  Place({
    this.name,
    this.localNames,
    this.lat,
    this.lon,
    this.country,
    this.state,
  });

  @override
  String toString() {
    return 'Place{lat: $lat, lon: $lon}';
  }

  String get fullName => '${name ?? ''}, ${state ?? ''}, ${country ?? ''}';

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        name: json['name'],
        localNames: json['local_names'] == null
            ? null
            : Map.from(json['local_names']!)
                .map((k, v) => MapEntry<String, String>(k, v)),
        lat: json['lat']?.toDouble(),
        lon: json['lon']?.toDouble(),
        country: json['country'],
        state: json['state'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'local_names': localNames == null
            ? null
            : Map.from(localNames!)
                .map((k, v) => MapEntry<String, dynamic>(k, v)),
        'lat': lat,
        'lon': lon,
        'country': country,
        'state': state,
      };
}
