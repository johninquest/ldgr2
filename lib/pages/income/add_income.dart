import 'package:flutter/material.dart';

import '../../shared/lists.dart';
import '../../styles/colors.dart';
import '../../utils/formatter.dart';

class InputIncomePage extends StatelessWidget {
  const InputIncomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'enter income',
          style: TextStyle(color: primaryColorDarker),
        ),
        centerTitle: true,
        // backgroundColor: myTeal,
      ),
      body: Center(
        child: IncomeForm(),
      ),
    );
  }
}

class IncomeForm extends StatefulWidget {
  const IncomeForm({Key? key}) : super(key: key);

  @override
  _IncomeFormState createState() => _IncomeFormState();
}

class _IncomeFormState extends State<IncomeForm> {
  final _incomeFormKey = GlobalKey<FormState>();
  TextEditingController _pickedDate = TextEditingController();

/*   String? _costArea;
  String? incomeSource; */
  String? incomeAmount;
  String? _paymentMethod;
  String? _paymentStatus;

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
        _pickedDate.text = DateTimeFormatter().toDateString(picked);
        /*  print('Picked date => $_pickedDate'); */
      });
  }

  @override
  void initState() {
    super.initState();
    _pickedDate.text = DateTimeFormatter().toDateString(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _incomeFormKey,
        child: SingleChildScrollView(
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
                  )),
              Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  margin: EdgeInsets.only(bottom: 10.0),
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Description'),
                    keyboardType: TextInputType.text,
                    maxLines: 2,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter description!' : null,
                    onChanged: (val) => setState(() {
                      incomeAmount = val;
                    }),
                  )),
              Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  margin: EdgeInsets.only(bottom: 10.0),
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Reference number'),
                    keyboardType: TextInputType.text,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter description!' : null,
                    onChanged: (val) => setState(() {
                      incomeAmount = val;
                    }),
                  )),
              Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  margin: EdgeInsets.only(bottom: 10.0),
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Amount'),
                    keyboardType: TextInputType.number,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter amount!' : null,
                    onChanged: (val) => setState(() {
                      incomeAmount = val;
                    }),
                  )),
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                margin: EdgeInsets.only(bottom: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      margin: EdgeInsets.only(right: 10.0),
                      padding: EdgeInsets.only(left: 15.0),
                      child: DropdownButtonFormField(
                        decoration:
                            InputDecoration(labelText: 'Payment status'),
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
                        decoration:
                            InputDecoration(labelText: 'Payment method'),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
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
                    margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_incomeFormKey.currentState!.validate()) {
                          print('Can  now proceed to save data!');
                        }
                      },
                      child: Text(
                        'SAVE',
                        style: TextStyle(letterSpacing: 1.0),
                      ),
                      /*  style: ElevatedButton.styleFrom(backgroundColor: myTeal), */
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
