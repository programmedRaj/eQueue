import 'dart:convert';

class Service {
  String service;
  String servicedescription;
  String servicerates;
  Service({
    this.service,
    this.servicedescription,
    this.servicerates,
  });

  Service copyWith({
    String service,
    String servicedescription,
    String servicerates,
  }) {
    return Service(
      service: service ?? this.service,
      servicedescription: servicedescription ?? this.servicedescription,
      servicerates: servicerates ?? this.servicerates,
    );
  }

  Service merge(Service model) {
    return Service(
      service: model.service ?? this.service,
      servicedescription: model.servicedescription ?? this.servicedescription,
      servicerates: model.servicerates ?? this.servicerates,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'service': service,
      'servicedescription': servicedescription,
      'servicerates': servicerates,
    };
  }

  factory Service.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Service(
      service: map['service'],
      servicedescription: map['servicedescription'],
      servicerates: map['servicerates'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Service.fromJson(String source) =>
      Service.fromMap(json.decode(source));

  @override
  String toString() =>
      'Service(service: $service, servicedescription: $servicedescription, servicerates: $servicerates)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Service &&
        o.service == service &&
        o.servicedescription == servicedescription &&
        o.servicerates == servicerates;
  }

  @override
  int get hashCode =>
      service.hashCode ^ servicedescription.hashCode ^ servicerates.hashCode;
}
