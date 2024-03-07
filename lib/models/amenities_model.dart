class AmenitiesModel {
  String? ceiling;
  String? floor;
  String? roadNetwork;
  String? icon;
  String? pool;
  bool? security;

  AmenitiesModel({
    this.ceiling = "",
    this.floor = "",
    this.roadNetwork = "",
    this.icon = "",
    this.pool = "",
    this.security
  });

  AmenitiesModel.fromJson(this.ceiling, Map<String, dynamic> json)
      : floor = json["floor"] ?? '',
        // roadNetwork = json["roadNetwork"].toDouble(),
        roadNetwork = json["roadNetwork"],
        icon = json["icon"] ?? '',
        pool = json["pool"] ?? '',
        security = json["security"] ?? false;

  Map<String, dynamic> toJson() => {
        "ceiling": ceiling,
        "floor": floor,
        "roadNetwork": roadNetwork,
        "icon": icon,
        "pool": pool,
        "security": security
      };
}
