import 'package:flutter/material.dart';
import 'package:objectid/objectid.dart';
import '../../db/sp_helper.dart';
import '../../firebase/firestore.dart';
import '../../styles/style.dart';
import '../../utils/date_time_helper.dart';
import '../../utils/preprocessor.dart';
import '../../utils/router.dart';
import '../../shared/lists.dart';
import '../../shared/snackbar_messages.dart';
import '../../styles/colors.dart';
import 'expense_list.dart';
import 'dart:async';

class InputExpensePage extends StatelessWidget {
  const InputExpensePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'enter expense'.toUpperCase(),
            style: AppBarTitleStyle,
          ),
          centerTitle: true,
          // backgroundColor: myRed,
        ),
        body: Center(
          child: AddExpenseForm(),
        ));
  }
}

class AddExpenseForm extends StatefulWidget {
  const AddExpenseForm({Key? key}) : super(key: key);

  @override
  State<AddExpenseForm> createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  final _expenseFormKey = GlobalKey<FormState>();
  TextEditingController _itemCategory = TextEditingController();
  TextEditingController _itemName = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _pickedDate = TextEditingController();
  TextEditingController _quantity = TextEditingController();

  String? _costArea;
  String? _unit;
  String? _paymentMethod;
  String? _paymentStatus;
  String? _currentUser;

  final _fs = FirestoreService();

  DateTime currentDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1990, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != currentDate)
      setState(() {
        currentDate = picked;
        _pickedDate.text = DateTimeHelper().toIsoDateString(picked);
        /*  print('Picked date => $_pickedDate'); */
      });
  }

  @override
  void initState() {
    super.initState();
    SharedPreferencesHelper().readData('currentUserData').then((value) {
      if (value != null) {
        setState(() {
          _currentUser = DataParser().strToMap(value)['name'];
        });
      }
    });
    _pickedDate.text = DateTimeHelper().toIsoDateString(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    // final _fs = FirestoreService();
    return Form(
      key: _expenseFormKey,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.95,
                margin: EdgeInsets.only(bottom: 10.0),
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  controller: _pickedDate,
                  enabled: true,
                  readOnly: true,
                  decoration: InputDecoration(labelText: 'Date'),
                  onTap: () => _selectDate(context),
/*                   validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter item category!';
                    }
                  }, */
                )),
            Container(
                width: MediaQuery.of(context).size.width * 0.95,
                margin: EdgeInsets.only(bottom: 10.0),
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  controller: _itemCategory,
                  decoration: InputDecoration(labelText: 'Description'),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  maxLines: 2,
/*                   validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter item category!';
                    }
                  }, */
                )),
            Container(
                width: MediaQuery.of(context).size.width * 0.95,
                margin: EdgeInsets.only(bottom: 10.0),
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  controller: _itemName,
                  decoration: InputDecoration(labelText: 'Reference number'),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter item name';
                    }
                  },
                )),
            Container(
                width: MediaQuery.of(context).size.width * 0.95,
                margin: EdgeInsets.only(bottom: 10.0),
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  controller: _price,
                  decoration: InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter price';
                    }
                  },
                )),
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    margin: EdgeInsets.only(right: 10.0),
                    padding: EdgeInsets.only(left: 15.0),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(labelText: 'Payment status'),
                      items: MyItemList().paymentStatusList,
                      validator: (val) =>
                          val == null ? 'Payment status ?' : null,
                      onChanged: (val) => setState(() {
                        _paymentStatus = val as String?;
                      }),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    margin: EdgeInsets.only(left: 10.0),
                    padding: EdgeInsets.only(right: 15.0),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(labelText: 'Payment method'),
                      items: MyItemList().paymentMethodList,
                      /* validator: (val) =>
                          val == null ? 'Please select payment method' : null, */
                      onChanged: (val) => setState(() {
                        _paymentMethod = val as String?;
                      }),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('CANCEL',
                        style:
                            TextStyle(letterSpacing: 1.0, color: blackColor)),
                    /* style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ), */
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      String _timestampsString =
                          DateTimeHelper().timestampForDB(DateTime.now());
                      String _daybookItemId = ObjectId().hexString;
                      // print('Expense record id => $_daybookItemId');
                      Map<String, dynamic> _daybookEntryData = {
                        'picked_date': '$currentDate',
                        'account': 'expense',
                        'cost_area': _costArea ?? '',
                        'item_category': _itemCategory.text,
                        'item_name': _itemName.text,
                        'quantity': _quantity.text,
                        'unit': _unit ?? '',
                        'price': _price.text,
                        'payment_status': _paymentStatus ?? '',
                        'payment_method': _paymentMethod ?? '',
                        'created_at': _timestampsString,
                        'last_update_at': '',
                        'doc_id': _daybookItemId,
                        'entered_by': _currentUser ?? '',
                      };
                      if (_expenseFormKey.currentState!.validate()) {
                        _fs
                            .addItemToDaybook(_daybookItemId, _daybookEntryData)
                            .then((val) {
                          if (val == 'add-success') {
                            SnackBarMessage().saveSuccess(context);
                            if (_itemName.text != '' && _quantity.text != '') {
                              Timer(Duration(seconds: 3), () {
                                showDialog(
                                    context: context,
                                    builder: (_) =>
                                        _addToStockDialog(_daybookItemId),
                                    barrierDismissible: true);
                              });
                            } else {
                              PageRouter()
                                  .navigateToPage(ExpenseListPage(), context);
                            }
                          } else if (val == 'permission-denied') {
                            String eMessage = 'Permission denied';
                            return SnackBarMessage()
                                .customErrorMessage(eMessage, context);
                          } else {
                            return SnackBarMessage()
                                .generalErrorMessage(context);
                          }
                        });
                      }
                    },
                    child: Text(
                      'SAVE',
                      style: TextStyle(
                        letterSpacing: 1.0,
                      ),
                    ),
                    /*  style: ElevatedButton.styleFrom(backgroundColor: myRed), */
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _addToStockDialog(String _daybookDocId) {
    return AlertDialog(
      title: Icon(
        Icons.help_outline,
        color: myBlue,
        size: 40.0,
      ),
      content: Text(
        'Add to stock ?',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: myBlue, fontSize: 20.0),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                PageRouter().navigateToPage(ExpenseListPage(), context);
              },
              child: Text(
                'NO',
                style: TextStyle(
                    color: myRed,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0),
              ),
            ),
            TextButton(
                onPressed: () {
                  String _timestampString =
                      DateTimeHelper().timestampForDB(DateTime.now());
                  String _stockItemId = ObjectId().hexString;
                  Map<String, dynamic> _stockEntryData = {
                    'picked_date': '$currentDate',
                    'item_name': _itemName.text,
                    'quantity': InputHandler().commaToPeriod(_quantity.text),
                    'unit': _unit ?? '',
                    'created_at': _timestampString,
                    'last_update_at': '',
                    'doc_id': _stockItemId,
                    'daybook_item_id': _daybookDocId,
                    'entered_by': _currentUser ?? '',
                    'events': []
                  };
                  _fs.addItemToStock(_stockItemId, _stockEntryData).then((val) {
                    if (val == 'add-success') {
                      SnackBarMessage().customSuccessMessage(
                          'Added to stock successfully', context);
                      PageRouter().navigateToPage(ExpenseListPage(), context);
                    } else {
                      SnackBarMessage().generalErrorMessage(context);
                    }
                  });
                },
                child: Text(
                  'YES',
                  style: TextStyle(
                      color: myGreen,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0),
                ))
          ],
        ),
      ],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
    );
  }
}
