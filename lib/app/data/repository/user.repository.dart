import 'package:flutter/cupertino.dart';

import '../provider/cloud_firestore.provider.dart';
import '../model/user.model.dart';

class UserRepository {
  final CloudFirestoreApi apiClient;

  UserRepository({@required this.apiClient}) : assert(apiClient != null);

  getAll() {
    return apiClient.getCollection();
  }

  getId(id) {
    return apiClient.getDocument(id);
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
