import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';

class FirestoreService {
  FirebaseFirestore fsInstance = FirebaseFirestore.instance;
  final String _mainCollection = 'the_wine_reserve';
  /* final String _mainCollection = 'test'; */

  getCollection(String collectionName) async {
    CollectionReference _collection = fsInstance.collection(collectionName);
    try {
      QuerySnapshot snapshot =
          await _collection.orderBy('created_at', descending: true).get();
      List<dynamic> fsReponse = snapshot.docs.map((doc) => doc.data()).toList();
      return fsReponse;
    } catch (e) {
      return null;
    }
  }

  getSubCollection(String mainDocName, String subColName) async {
    CollectionReference _collection = fsInstance
        .collection(_mainCollection)
        .doc(mainDocName)
        .collection(subColName);
    try {
      QuerySnapshot snapshot = await _collection
          .orderBy('picked_date', descending: true)
          .limit(100)
          .get();
      List<dynamic> fsReponse = snapshot.docs.map((doc) => doc.data()).toList();
      return fsReponse;
    } catch (e) {
      // log('Returned error => $e');
      return null;
    }
  }

  getSubCollectionBasic(String mainDocName, String subColName) async {
    CollectionReference _collection = fsInstance
        .collection(_mainCollection)
        .doc(mainDocName)
        .collection(subColName);
    try {
      QuerySnapshot snapshot = await _collection.get();
      List<dynamic> fsReponse = snapshot.docs.map((doc) => doc.data()).toList();
      return fsReponse;
    } catch (e) {
      return null;
    }
  }

  getDocument(String colName, String docName) async {
    DocumentSnapshot _doc =
        await FirebaseFirestore.instance.collection(colName).doc(docName).get();
    return _doc;
  }

  addDocument(Map<String, dynamic> _data) async {
    try {
      await fsInstance.collection('daybook').add(_data);
      return 'add-success';
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return 'permission-denied';
      }
    }
  }

  addItemToDaybook(String _id, Map<String, dynamic> _data) async {
    var targetCollection = fsInstance
        .collection(_mainCollection)
        .doc('records')
        .collection('daybook');
    try {
      await targetCollection.doc(_id).set(_data);
      return 'add-success';
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return 'permission-denied';
      }
    }
  }

  addItemToStock(String _id, Map<String, dynamic> _data) async {
    var targetCollection = fsInstance
        .collection(_mainCollection)
        .doc('records')
        .collection('stock');
    try {
      await targetCollection.doc(_id).set(_data);
      String successMessage = 'add-success';
      return successMessage;
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return 'permission-denied';
      }
    }
  }

  addNewAppUser(String _id, Map<String, dynamic> _data) async {
    var targetCollection = fsInstance
        .collection(_mainCollection)
        .doc('users')
        .collection('user_list');
    try {
      await targetCollection.doc(_id).set(_data);
      String successMessage = 'add-success';
      return successMessage;
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return 'permission-denied';
      }
    }
  }

  removeAppUser(String _docId) async {
    CollectionReference _col = fsInstance
        .collection(_mainCollection)
        .doc('users')
        .collection('user_list');
    try {
      var delResponse = await _col.doc(_docId).delete();
      return delResponse;
    } on FirebaseException catch (e) {
      print(e.code);
    }
  }

  addDocumentWithId2(String _mainCollId, String _mainDocId, String _subCollId,
      String _docId, Map<String, dynamic> _docData) async {
    CollectionReference targetCollection = fsInstance
        .collection(_mainCollId)
        .doc(_mainDocId)
        .collection(_subCollId);
    try {
      await targetCollection.doc(_docId).set(_docData);
      return 'add-success';
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return 'permission-denied';
      }
    }
  }

  addDocWithId2SubCol(String _mainDocId, String _subCollId, String _docId,
      Map<String, dynamic> _docData) async {
    CollectionReference targetCollection = fsInstance
        .collection(_mainCollection)
        .doc(_mainDocId)
        .collection(_subCollId);
    try {
      await targetCollection.doc(_docId).set(_docData);
      return 'add-success';
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return 'permission-denied';
      }
    }
  }

  checkIfDocExists(String docId) {
    final targetDoc = fsInstance
        .collection(_mainCollection)
        .doc('users')
        .collection('user_list')
        .doc(docId)
        .get();
    return targetDoc;
  }

  getDocumentWithId(String _id) async {
    var targetDoc = fsInstance
        .collection(_mainCollection)
        .doc('users')
        .collection('user_list')
        .doc(_id);
    try {
      var getResponse = await targetDoc.get();
      return getResponse;
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  getDocumentById(String _id) async {
    var targetDoc = fsInstance
        .collection(_mainCollection)
        .doc('users')
        .collection('user_list')
        .doc(_id);
    try {
      var getResponse = await targetDoc.get();
      return getResponse;
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  removeDocument(String _docId) async {
    CollectionReference _col = fsInstance
        .collection(_mainCollection)
        .doc('records')
        .collection('daybook');
    try {
      var delResponse = await _col.doc(_docId).delete();
      return delResponse;
    } on FirebaseException catch (e) {
      print(e.code);
    }
  }

  removeDocFromSubCollection(
      String _mainDoc, String _subColl, String _docId) async {
    CollectionReference _col = fsInstance
        .collection(_mainCollection)
        .doc(_mainDoc)
        .collection(_subColl);
    try {
      var delResponse = await _col.doc(_docId).delete();
      return delResponse;
    } on FirebaseException catch (e) {
      // print(e.code);
      return e;
    }
  }

  updateDocument(String _docId, Map<String, Object?> _docData) async {
    CollectionReference _col = fsInstance
        .collection(_mainCollection)
        .doc('records')
        .collection('daybook');
    try {
      var updateResponse = await _col.doc(_docId).update({
        'picked_date': _docData['pickedDate'],
        'cost_area': _docData['costArea'],
        'item_category': _docData['itemCategory'],
        'item_name': _docData['itemName'],
        'quantity': _docData['quantity'],
        'unit': _docData['unit'],
        'price': _docData['price'],
        'payment_status': _docData['paymentStatus'],
        'payment_method': _docData['paymentMethod'],
        'last_update_at': _docData['lastUpdateAt'],
        'entered_by': _docData['enteredBy'],
      });
      return updateResponse;
    } on FirebaseException catch (e) {
      print(e.code);
    }
  }

  updateArrayInDocument(String _docId, String _arrayName,
      List<Map<String, String>> _arrayData) async {
    CollectionReference _col = fsInstance
        .collection(_mainCollection)
        .doc('records')
        .collection('stock');
    try {
      var updateResponse = await _col
          .doc(_docId)
          .update({_arrayName: FieldValue.arrayUnion(_arrayData)});
      return updateResponse;
    } on FirebaseException catch (e) {
      print(e.code);
    }
  }
}
