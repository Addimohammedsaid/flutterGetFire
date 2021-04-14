import 'package:flutter/cupertino.dart';

import '../model/user.model.dart';
import '../provider/cloud_firestore.provider.dart';

class UserRepository {
  final CloudFirestoreApi apiClient;

  UserRepository({@required this.apiClient}) : assert(apiClient != null);

  Future<List<UserModel>> getAll() async {
    final result = await apiClient.getCollection();
    return result.docs.map((json) => UserModel.fromJson(json.data()));
  }

  Stream<List<UserModel>> getStreamAll() {
    return apiClient.getStreamCollection().map((query) =>
        query.docs.map((e) => UserModel.fromJson(e.data())).toList());
  }

  Future<UserModel> getId(id) async {
    final json = await apiClient.getDocument(id);
    return UserModel.fromJson(json.data());
  }

  delete(id) {
    return apiClient.deleteDocument(id);
  }

  edit(obj) {
    return apiClient.updateDocument(obj, obj.id);
  }

  add(obj) {
    return apiClient.postDocument(obj);
  }
}
