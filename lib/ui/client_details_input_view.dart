import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sal_patient_client/common/sal_colors.dart';
import 'package:sal_patient_client/utils/rounded_button.dart';

class ClientDetailsInputView extends StatefulWidget {
  // TODO: Ideally we should capture this through global state via provider or inherited widget
  final bool isLoggedIn;

  ClientDetailsInputView({Key key, this.isLoggedIn}) : super(key: key);

  @override
  _ClientDetailsInputViewState createState() =>
      _ClientDetailsInputViewState(isLoggedIn: isLoggedIn);
}

class _ClientDetailsInputViewState extends State<ClientDetailsInputView> {
  // TODO: Ideally we should capture this through global state via provider or inherited widget
  final bool isLoggedIn;

  bool _isAgreed = false;
  String _name;
  String _email;
  String _mobile;

  _ClientDetailsInputViewState({this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          bottomOpacity: 0.0,
          title: Text("Details", style: SalStyles.titleTextStyle),
          iconTheme: IconThemeData(
            color: SalColors.black,
          )),
      body: Center(child: body()),
      bottomNavigationBar: RoundedButton(
        title: 'Next',
        onPressed: () {},
        color: SalColors.blue,
        textColor: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        enabled: _isDataValid,
      ),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Wrap(
        spacing: 20,
        runSpacing: 10,
        alignment: WrapAlignment.start,
        children: [
          Text(
            "Please provide us the following details.",
            style: SalStyles.subTitleTextStyle,
          ),
          SizedBox(height: 50),
          _buildInputEntry("name", "Name", "Enter Name", (value) {
            this.setState(() {
              _name = _validateName(value);
            });
          }),
          _buildInputEntry("email", "Email", "Enter Email Address", (value) {
            this.setState(() {
              _email = _validateEmail(value);
            });
          }),
          if (!isLoggedIn)
            _buildInputEntry("mobile", "Mobile", "Enter Mobile Number",
                (value) {
              this.setState(() {
                _mobile = _validateMobile(value);
              });
            }),
          Row(children: [
            Checkbox(
                value: _isAgreed,
                onChanged: (val) {
                  this.setState(() {
                    _isAgreed = val;
                  });
                }),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    style: SalStyles.normalTextStyle, text: "I agree to the "),
                TextSpan(
                    text: "Terms and Conditions.",
                    style: SalStyles.hyperLinkTextStyle,
                    recognizer: TapGestureRecognizer()..onTap = () {})
              ]),
            )
          ])
        ],
      ),
    );
  }

  Widget _buildInputEntry(String key, String name, String placeHolder,
      void Function(String) onChanged) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: SalStyles.disableTextStyle,
          ),
          SizedBox(height: 5),
          Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: SalColors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: TextFormField(
                style: SalStyles.normalTextStyle,
                onChanged: onChanged,
                decoration: InputDecoration(
                    hintStyle: SalStyles.disableTextStyle,
                    hintText: placeHolder,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
              ))
        ],
      ),
    );
  }

  bool get _isDataValid {
    var result = _isAgreed && _name != null && _email != null;

    if (!isLoggedIn) {
      result = result && _mobile != null;
    }

    return result;
  }

  String _validateName(String value) {
    String cleansedValue = value.trim();

    if (cleansedValue.length < 4)
      return null;
    else
      return cleansedValue;
  }

  String _validateMobile(String value) {
    String cleansedValue = value.replaceAll(RegExp('[^0-9]'), '');

    if (cleansedValue.length != 10)
      return null;
    else
      return cleansedValue;
  }

  String _validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return null;
    else
      return value.trim();
  }
}
