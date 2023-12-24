Contact contactFromJson(Map<String, dynamic> json) => Contact.fromJson(json);

class Contact {
  bool _success = false;
  Status? _status;
  List<Data>? _data;

  Contact({required bool success, Status? status, List<Data>? data}) {
    this._success = success;

    if (status != null) {
      this._status = status;
    }
    if (data != null) {
      this._data = data;
    }
  }

  bool get success => _success;

  set success(bool success) => _success = success;

  Status? get status => _status;

  set status(Status? status) => _status = status;

  List<Data>? get data => _data;

  set data(List<Data>? data) => _data = data;

  Contact.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    if (json['data'] != null) {
      _data = <Data>[];
      json['data'].forEach((v) {
        _data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this._success;
    if (this._status != null) {
      data['status'] = this._status!.toJson();
    }
    if (this._data != null) {
      data['data'] = this._data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Status {
  String _code = "";
  String _message = "";

  Status({required String code, required String message}) {
    this._code = code;
    this._message = message;
  }

  String get code => _code;

  set code(String code) => _code = code;

  String get message => _message;

  set message(String message) => _message = message;

  Status.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    data['message'] = this._message;
    return data;
  }
}

class Data {
  String _id = "";
  String _name = "";
  String _email = "";

  Data({required String id, required String name, required String email}) {
    this._id = id;
    this._name = name;
    this._email = email;
  }

  String get id => _id;

  set id(String id) => _id = id;

  String get name => _name;

  set name(String name) => _name = name;

  String get email => _email;

  set email(String email) => _email = email;

  Data.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['email'] = this._email;
    return data;
  }
}
