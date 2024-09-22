// ignore_for_file: file_names

class AirportModel {
  final int id;
  final String name;
  final String code;
  final Location location;
  final String city;
  final String country;
  final String timezone;
  final List<Terminal> terminals;
  final List<String> airlines;
  final List<String> services;
  final ContactInfo contactInfo;

  AirportModel({
    required this.id,
    required this.name,
    required this.code,
    required this.location,
    required this.city,
    required this.country,
    required this.timezone,
    required this.terminals,
    required this.airlines,
    required this.services,
    required this.contactInfo,
  });

 
  factory AirportModel.fromJson(Map<String, dynamic> json) {
    return AirportModel(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      location: Location.fromJson(json['location']),
      city: json['city'],
      country: json['country'],
      timezone: json['timezone'],
      terminals: List<Terminal>.from(
        json['terminals'].map((terminal) => Terminal.fromJson(terminal)),
      ),
      airlines: List<String>.from(json['airlines']),
      services: List<String>.from(json['services']),
      contactInfo: ContactInfo.fromJson(json['contact_info']),
    );
  }
}

class Location {
  final double latitude;
  final double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

class Terminal {
  final String name;
  final List<Gate> gates;

  Terminal({
    required this.name,
    required this.gates,
  });

  factory Terminal.fromJson(Map<String, dynamic> json) {
    return Terminal(
      name: json['name'],
      gates: List<Gate>.from(
        json['gates'].map((gate) => Gate.fromJson(gate)),
      ),
    );
  }
}

class Gate {
  final String gateNumber;
  final List<String> airlines;

  Gate({
    required this.gateNumber,
    required this.airlines,
  });

  factory Gate.fromJson(Map<String, dynamic> json) {
    return Gate(
      gateNumber: json['gate_number'],
      airlines: List<String>.from(json['airlines']),
    );
  }
}

class ContactInfo {
  final String phone;
  final String email;
  final String website;

  ContactInfo({
    required this.phone,
    required this.email,
    required this.website,
  });

  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return ContactInfo(
      phone: json['phone'],
      email: json['email'],
      website: json['website'],
    );
  }
}
