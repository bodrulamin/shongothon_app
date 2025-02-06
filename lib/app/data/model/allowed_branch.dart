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

class Branch {
  final int id;
  final String name;
  final String email;
  final String address;
  final int serial;
  final Branch? parent;

  Branch({
    this.id = 0,
    this.name = "",
    this.email = "",
    this.address = "",
    this.serial = 0,
    this.parent,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      serial: json['serial'] ?? 0,
      parent: json['parent'] != null ? Branch.fromJson(json['parent']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'address': address,
      'serial': serial,
      'parent': parent?.toJson(),
    };
  }
}

class AllowedBranch {
  final Organization organization;
  final List<Branch> branches;

  AllowedBranch({
    required this.organization,
    required this.branches,
  });

  factory AllowedBranch.fromJson(Map<String, dynamic> json) {
    return AllowedBranch(
      organization: Organization.fromJson(json['organization']),
      branches: (json['branches'] as List)
          .map((branch) => Branch.fromJson(branch))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'organization': organization.toJson(),
      'branches': branches.map((branch) => branch.toJson()).toList(),
    };
  }
}
