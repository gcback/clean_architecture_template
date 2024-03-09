import 'dart:convert';
import 'package:http/http.dart' as http;

import 'entity.dart';
import 'repository.dart';

abstract class Source {
  Future fetch(int no, {int perPage = 10});
  Future add(UserEntity rawUser);

  Source();

  factory Source.client({required SourceType type}) => switch (type) {
        == SourceType.remote => RemoteSource(),
        == SourceType.localdb => LocalDBSource(),
        _ => MockSource(),
      };
}

class MockSource implements Source {
  @override
  Future<Map> fetch(int no, {int perPage = 10}) async {
    return {};
  }

  @override
  Future add(UserEntity rawUser) {
    // TODO: implement add
    throw UnimplementedError();
  }
}

class LocalDBSource implements Source {
  @override
  Future<Map> fetch(int no, {int perPage = 10}) async {
    return {};
  }

  @override
  Future add(UserEntity rawUser) {
    // TODO: implement add
    throw UnimplementedError();
  }
}

class RemoteSource implements Source {
  // RemoteSource();

  var client = http.Client();

  @override
  Future<Map> fetch(int no, {int perPage = 10}) async {
    try {

      var response = await client.get(
        Uri.http(
          'spsms.dyndns.org:3100',
          'api/collections/profiles/records',
          {
            'filter': perPage > 0 ? 'no>$no' : 'no==$no',
            if (perPage > 0) 'perPage': '$perPage',
          },
        ),
      );

      await Future.delayed(const Duration(milliseconds: 1500));


      return jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future add(UserEntity rawUser) async {
    return true;
  }
}
