class Organization {
  final int id;
  final String name;
  final String shortName;
  final String logoUrl;
  final String typographyUrl;

  Organization({
    required this.id,
    this.name = "",
    this.shortName = "",
    this.logoUrl = "",
    this.typographyUrl = "",
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        shortName: json['shortName'] ?? '',
        logoUrl: json['logoUrl'] ?? '',
        typographyUrl: json['typographyUrl'] ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'shortName': shortName,
      'logoUrl': logoUrl,
      'typographyUrl': typographyUrl,
    };
  }
}