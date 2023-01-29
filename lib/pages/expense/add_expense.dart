import 'package:flutter/material.dart';
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
import 'dart:developer';

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
                      log('Tapped save button!');
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
}
