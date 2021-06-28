import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rehmat/core/models/bloodrequest.dart';
import 'package:rehmat/core/models/userDetails.dart';

class DataBaseService {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference requestCollection =
      FirebaseFirestore.instance.collection('Blood Requests');

  //------------------------------------------add new User
  Future addNewUser(Map<String, dynamic> _dataMap) async {
    await userCollection.doc(_dataMap['uid']).set(_dataMap).catchError((e) {
      print("-----------------------error in add new user in database " +
          e.toString());
    });
  }

// get user data

  Stream<UserDetails> getCurrentUserDetails(String userID) {
    print(
        '-------------------------inside get current user details in database');
    return userCollection
        .doc(userID)
        .snapshots()
        .map((event) => UserDetails.fromMap(event.data()));
  }

  Stream<List<UserDetails>> getAllUsers() {
    print('-------------------------inside get all user details in database');

    return userCollection.snapshots().map(_allUserFromsnapShot);
  }

  List<UserDetails> _allUserFromsnapShot(QuerySnapshot snap) {
    List<UserDetails> allUsers = [];
    for (int i = 0; i < snap.docs.length; i++) {
      allUsers.add(UserDetails.fromMap(snap.docs[i].data()));
    }
    return allUsers;
  }
  //---------------------------------------------- B L O O D ---- R E Q U E S T

  Future addNewRequest(Map<String, dynamic> _dataMap) async {
    print(
        '--------------------------inside add new request functionin database');
    requestCollection.doc(_dataMap['uid']).set(_dataMap).catchError((e) {
      print("-----------------------error in add new request in database " +
          e.toString());
    });
  }

  Stream<List<BloodRequest>> getAllRequest() {
    print('-------------------------inside get all requests in database');
    return requestCollection.snapshots().map(_allRequestFromSnapshot);
  }

  List<BloodRequest> _allRequestFromSnapshot(QuerySnapshot snap) {
    List<BloodRequest> _allRequests = [];

    for (int i = 0; i < snap.docs.length; i++) {
      _allRequests.add(BloodRequest.fromMap(snap.docs[i].data()));
    }
    return _allRequests;
  }
}
