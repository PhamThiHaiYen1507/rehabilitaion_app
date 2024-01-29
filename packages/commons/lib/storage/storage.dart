import 'dart:convert';

import 'package:commons/commons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class _IStorage {
  Future<_IStorage> init();

  void put<T>(dynamic key, T value);

  void putList<T>(dynamic key, T value);

  T? get<T>(dynamic key, [T Function(Map<String, dynamic> data)? decoder]);

  List<T>? getList<T>(dynamic key, [T Function(Map data)? decoder]);

  void delete(dynamic key);
}

class Storage {
  late final _IStorage _storage;
  late MobileStorage _dynamicStorage;
  static Storage? _instance;

  static Future<void> init() async {
    final _IStorage str;

    if (kIsWeb) {
      str = await _WebStorage().init();
    } else {
      str = await MobileStorage().init();
    }

    _instance ??= Storage._(str);
    _instance!._dynamicStorage = await MobileStorage().init();
  }

  Storage._(this._storage);

  ///only work with mobile
  // ignore: library_private_types_in_public_api
  static MobileStorage get dynamicStorage => _instance!._dynamicStorage;

  static setDynamicStorage(MobileStorage str) {
    assert(_instance != null, 'You must be call "init" method');
    _instance!._dynamicStorage = str;
  }

  static void put<T>(dynamic key, T value) {
    assert(_instance != null, 'You must be call "init" method');
    _instance!._storage.put(key, value);
  }

  static void putList<T>(dynamic key, T value) {
    assert(_instance != null, 'You must be call "init" method');
    _instance!._storage.putList(key, value);
  }

  static T? get<T>(dynamic key,
      [T Function(Map<String, dynamic> data)? decoder]) {
    assert(_instance != null, 'You must be call "init" method');
    return _instance!._storage.get(key, decoder);
  }

  static List<T>? getList<T>(dynamic key, [T Function(Map data)? decoder]) {
    assert(_instance != null, 'You must be call "init" method');
    return _instance!._storage.getList(key, decoder);
  }

  static void delete(dynamic key) {
    assert(_instance != null, 'You must be call "init" method');
    _instance!._storage.delete(key);
  }
}

class MobileStorage extends _IStorage {
  late final Box box;

  @override
  void delete(key) {
    box.delete(key.toString());
  }

  @override
  T? get<T>(key, [T Function(Map<String, dynamic> data)? decoder]) {
    // try {
    final data = box.get(key.toString());

    if (decoder != null && data != null) {
      return decoder(json.decode(data));
    } else {
      return data;
    }
    // } catch (_) {
    //   if (kDebugMode) {
    //     print(_);
    //   }
    //   return null;
    // }
  }

  @override
  List<T>? getList<T>(key, [T Function(Map data)? decoder]) {
    try {
      final data = box.get(key.toString());

      if (decoder != null && data != null) {
        return (json.decode(data) as List).map((e) => decoder(e)).toList();
      } else {
        return data;
      }
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
      return null;
    }
  }

  @override
  Future<MobileStorage> init([String? id]) async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    const FlutterSecureStorage secureStorage = FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true));
    String? keyEncrpt = await secureStorage.read(key: id ?? 'encrpt');
    keyEncrpt ??= const Uuid().v4();
    secureStorage.write(key: id ?? 'encrpt', value: keyEncrpt);

    String? encrpt = await secureStorage.read(key: keyEncrpt);

    if (encrpt == null) {
      final String key = base64UrlEncode(Hive.generateSecureKey());
      await secureStorage.write(key: keyEncrpt, value: key);
      encrpt = key;
    }

    final encryptionKey = base64Url.decode(encrpt);

    String? boxName = await secureStorage.read(key: id ?? 'BoxName');
    boxName ??= const Uuid().v4();
    secureStorage.write(key: id ?? 'BoxName', value: boxName);

    box = await Hive.openBox(id ?? boxName,
        encryptionCipher: HiveAesCipher(encryptionKey));

    return this;
  }

  @override
  void put<T>(key, T value) {
    try {
      if (value is ExtendModel) {
        box.put(key.toString(), json.encode(value.toJson()));
      } else {
        box.put(key.toString(), json.encode((value as dynamic).toJson()));
      }
    } catch (_) {
      box.put(key, value);
      if (kDebugMode) {
        print(_);
      }
    }
  }

  @override
  void putList<T>(key, T value) {
    try {
      if (value is List<ExtendModel>) {
        box.put(
            key.toString(), json.encode(value.map((e) => e.toJson()).toList()));
      } else {
        box.put(key.toString(), value);
      }
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
    }
  }
}

class _WebStorage extends _IStorage {
  late final SharedPreferences pref;

  @override
  void delete(key) {
    pref.remove(key.toString());
  }

  @override
  T? get<T>(key, [T Function(Map<String, dynamic> data)? decoder]) {
    try {
      final dynamic data = pref.getString(key.toString());

      if (decoder != null && data != null) {
        return decoder(json.decode(data.toString()));
      } else {
        return data;
      }
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
      return null;
    }
  }

  @override
  List<T>? getList<T>(key, [T Function(Map data)? decoder]) {
    try {
      final data = pref.getStringList(key.toString());

      if (decoder != null && data != null) {
        return data.map((e) => decoder(json.decode(e))).toList();
      } else {
        return data as List<T>;
      }
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
      return null;
    }
  }

  @override
  Future<_WebStorage> init() async {
    pref = await SharedPreferences.getInstance();

    return this;
  }

  @override
  void put<T>(key, T value) {
    try {
      if (value is ExtendModel) {
        pref.setString(key.toString(), json.encode(value.toJson()));
      } else {
        pref.setString(key.toString(), value.toString());
      }
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
    }
  }

  @override
  void putList<T>(key, T value) {
    try {
      if (value is List<ExtendModel>) {
        pref.setStringList(
            key.toString(), value.map((e) => json.encode(e.toJson())).toList());
      } else {
        pref.setStringList(key.toString(), value as List<String>);
      }
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
    }
  }
}
