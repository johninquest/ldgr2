import 'package:flutter/material.dart';
import '../firebase/auth.dart';
import '../styles/colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 3.0,
            )),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _loginFormKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  margin: EdgeInsets.only(bottom: 8.0, top: 34.0),
                  padding: EdgeInsets.only(left: 13.0, right: 13.0),
                  child: TextFormField(
                    controller: _email,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.0, color: primaryColor))),
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Email required';
                      }
                      return null;
                    },
                  )),
              Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  margin: EdgeInsets.only(bottom: 13.0),
                  padding: EdgeInsets.only(left: 13.0, right: 13.0),
                  child: TextFormField(
                    controller: _password,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.0, color: primaryColor))),
                    keyboardType: TextInputType.text,
                    enabled: true,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Password required!';
                      }
                    },
                  )),
              Container(
                width: MediaQuery.of(context).size.width * 0.55,
                margin: EdgeInsets.only(bottom: 5.0),
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  children: [
                    Checkbox(
                      /* checkColor: Colors.white, 
                       fillColor: MaterialStateProperty.resolveWith(getColor), */
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value as bool;
                        });
                      },
                    ),
                    Text('Remember me'),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.50,
                margin: EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 5.0, bottom: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    String emailCleanedUp = _email.text.trim().toLowerCase();
                    String passwordCleanedUp =
                        _password.text.trim().toLowerCase();
                    if (_loginFormKey.currentState!.validate()) {
                      // _authenticateUser(emailCleanedUp, passwordCleanedUp);
                      FirebaseAuthService().emailSignIn(
                          emailCleanedUp, passwordCleanedUp, context);
                      // log('User => $fbAuthResponse');
                    }
                  },
                  /*  onPressed: (() =>
                      PageRouter().navigateToPage(HomePage(), context)), */
                  child: Text(
                    'Log in',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      wordSpacing: 3.0,
                      letterSpacing: 0.3,
                    ),
                  ),
                  /* style: ElevatedButton.styleFrom(
                    backgroundColor: myBlue,
                  ), */
                ),
              ),
              /*     Divider(
                thickness: 0.5,
                indent: 50.0,
                endIndent: 50.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                margin: EdgeInsets.only(top: 10.0),
                child: OutlinedButton.icon(
                  onPressed: () => SnackBarMessage().underConstruction(context),
                  label: Text(
                    'Continue with Google',
                    style: TextStyle(
                      wordSpacing: 3.0,
                      letterSpacing: 0.1,
                      color: blackColor,
                    ),
                  ),
                  /* icon: Icon(Icons.save), */
                  icon: Image.asset(
                    'assets/logos/google.png',
                    height: 24.0,
                    width: 24.0,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                margin: EdgeInsets.only(top: 10.0),
                child: OutlinedButton.icon(
                  onPressed: () => SnackBarMessage().underConstruction(context),
                  label: Text(
                    'Continue with Facebook',
                    style: TextStyle(
                      wordSpacing: 3.0,
                      letterSpacing: 0.1,
                      color: blackColor,
                    ),
                  ),
                  /* icon: Icon(Icons.save), */
                  icon: Image.asset(
                    'assets/logos/facebook.png',
                    height: 24.0,
                    width: 24.0,
                  ),
                ),
              ), */
            ],
          ),
        ),
      ),
    );
  }

/*   _authenticateUser(String email, String password) {
    print('Tapped login button!');
    var fbAuth = FirebaseAuthService();
    var authResp = fbAuth.emailSignIn(email, password, context);
    print('Res 2 => $authResp');
  } */
}

/* storeCurrentUser(
    String userName, String userRole, String bName, String bLocation) {
  Map _toMap = {
    'name': userName,
    'role': userRole,
    'businessName': bName,
    'businessLocation': bLocation
  };
  String _currentUserData = jsonEncode(_toMap);
  SharedPreferencesHelper().storeData('currentUserData', _currentUserData);
}

storeRememberMeUser(bool rmState, String? userId) {
  if (rmState == true) {
    final _spHelper = SharedPreferencesHelper();
    _spHelper.storeData('loginId', userId ?? '');
  }
}
 */