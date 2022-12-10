import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok/core/utils/app_constant.dart';
import 'package:tiktok/models/user_model.dart';

class SearchController extends GetxController {
  final Rx<List<UserModel>> _searchedUserList = Rx<List<UserModel>>([]);

  List<UserModel> get searchedUsers => _searchedUserList.value;

  searchUser(String userName) async {
    _searchedUserList.bindStream(
      AppConstant.firebaseFirestore
          .collection('users')
          .where(
            'name',
            isGreaterThan: userName,
          )
          .snapshots()
          .map(
        (QuerySnapshot snapshot) {
          List<UserModel> temp = [];
          for (var element in snapshot.docs) {
            temp.add(
              UserModel.fromSnap(element),
            );
          }
          return temp;
        },
      ),
    );
  }
}
