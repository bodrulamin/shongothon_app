class Committee {
  int id;
  String name;
  String session;
  String inaugurationDate;
  String? termination;
  bool isFolder;
  int serial;

  // Constructor with empty default values for strings
  Committee({
    this.id = 1,
    this.name = '',
    this.session = '',
    this.inaugurationDate = '',
    this.termination,
    this.isFolder = false,
    this.serial = 1,
  });

  // Factory constructor to create an instance from a JSON map
  factory Committee.fromJson(Map<String, dynamic> json) {
    return Committee(
      id: json['id'] ?? 1,
      name: json['name'] ?? '',
      session: json['session'] ?? '',
      inaugurationDate: json['inaugurationDate'] ?? '',
      termination: json['termination'],
      isFolder: json['isFolder'] ?? false,
      serial: json['serial'] ?? 1,
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'session': session,
      'inaugurationDate': inaugurationDate,
      'termination': termination,
      'isFolder': isFolder,
      'serial': serial,
    };
  }
}