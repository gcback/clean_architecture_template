import 'dart:convert';
import 'package:http/http.dart' as http;

import '../common/exceptions.dart';
import 'entity.dart';
import 'source_iface.dart';

class SourceRemote implements DataSource {
  SourceRemote._();
  static final _instance = SourceRemote._();

  factory SourceRemote() => _instance;
  static get instance => _instance;

  var client = http.Client();

  @override
  Future<Map> get(int id, int count) async {
    try {
      var response = await client.get(
        Uri.http(
          'spsms.dyndns.org:3100',
          'api/collections/profiles/records',
          {
            'filter': count > 0 ? 'no>$id' : 'no==$id',
            if (count > 0) 'perPage': '$count',
          },
        ),
      );

      await Future.delayed(const Duration(milliseconds: 1500));

      return jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    } catch (e) {
      throw SourceLayerException(e.toString());
    }
  }

  @override
  Future<bool> add(UserEntity rawUser) async {
    return true;
  }

  @override
  Future<bool> remove(int id) async {
    return true;
  }
}
