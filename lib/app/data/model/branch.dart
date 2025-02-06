
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