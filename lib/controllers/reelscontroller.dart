import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:selivery_client/core/contants/api.dart';

import '../core/services/cache_storage_services.dart';

class Reel {
  String? sId;
  String? url;
  String? createdAt;
  String? expiresAt;
  int? iV;

  Reel({this.sId, this.url, this.createdAt, this.expiresAt, this.iV});

  Reel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    url = json['url'];
    createdAt = json['createdAt'];
    expiresAt = json['expiresAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['url'] = this.url;
    data['createdAt'] = this.createdAt;
    data['expiresAt'] = this.expiresAt;
    data['__v'] = this.iV;
    return data;
  }
}


class ReelService {

  Future<List<Reel>> fetchReels() async {
    final response = await http.get(
        Uri.parse(getreelsapi),
        headers: authHeadersWithToken(CacheStorageServices().token)
    );
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['reels'];
      return data.map((reel) => Reel.fromJson(reel)).toList();
    } else {
      throw Exception('Failed to load reels');
    }
  }

  Future<void> removeReel(String reelId) async {
    final response = await http.post(
      Uri.parse(removereelsapi(reelId)),
        headers: authHeadersWithToken(CacheStorageServices().token)
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to remove reel');
    }
  }
}
