import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rehmat/core/models/bloodrequest.dart';
import 'package:rehmat/core/models/userDetails.dart';
import 'package:rehmat/core/services/database.dart';
import 'package:rehmat/core/viewmodels/baseViewModel.dart';

class RequestBloodViewModel extends BaseViewModel {
  Future<bool> requestBlood(
    String uid,
    String bloodGroup,
    String quantity,
    DateTime dueDate,
    String phone,
    GeoPoint location,
    String address,
  ) async {
    print(
        '-------------------------inside request blood functionin view model');
    DataBaseService().addNewRequest(BloodRequest(
            uid: uid,
            bloodGroup: bloodGroup,
            quantity: quantity,
            dueDate: dueDate,
            location: location,
            address: address,
            phone: phone)
        .toMap());
  }

  UserDetails getRequestedUser(requestId, List<UserDetails> allUsers) {
    UserDetails user;
    for (UserDetails _user in allUsers) {
      if (_user.uid == requestId) {
        user = _user;
        break;
      }
    }
    return user;
  }
}
