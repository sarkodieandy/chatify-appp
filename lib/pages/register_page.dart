import 'package:flutter/material.dart';
import 'package:gee/services/media_services.dart';
import 'package:get_it/get_it.dart';
import 'package:gee/services/navigation_services.dart';
import 'package:gee/services/cloud_storage_service.dart';
import 'package:gee/services/database_services.dart';
import 'package:gee/widgets/rounded_button.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import '../widgets/custom_input_fields.dart';
import '../widgets/rounded_image.dart';
import '../providers/authentication_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  late AuthenticationProvider _auth;
  late DatabaseServices _db;
  late CloudStorageService _cloudStorage;
  late NavigationServices _navigation;

  String? _email;
  String? _password;
  String? _name;
  PlatformFile? _profileImage;

  final _registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<AuthenticationProvider>(context);
    _db = GetIt.instance.get<DatabaseServices>();
    _cloudStorage = GetIt.instance.get<CloudStorageService>();
    _navigation = GetIt.instance.get<NavigationServices>();
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth * 0.03,
          vertical: _deviceHeight * 0.02,
        ),
        height: _deviceHeight * 0.98,
        width: _deviceWidth * 0.97,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _profileImageField(),
            SizedBox(
              height: _deviceHeight * 0.05,
            ),
            _registerForm(),
            SizedBox(
              height: _deviceHeight * 0.05,
            ),
            _registerButton(),
            SizedBox(
              height: _deviceHeight * 0.02,
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileImageField() {
    return GestureDetector(
      onTap: () {
        GetIt.instance.get<MediaService>().pickImageFromLibrary().then(
          (file) {
            setState(
              () {
                _profileImage = file;
              },
            );
          },
        );
      },
      child: () {
        if (_profileImage != null) {
          return RoundedImageFile(
            key: UniqueKey(),
            image: _profileImage!,
            size: _deviceHeight * 0.15,
          );
        } else {
          return RoundedImageNetwork(
            key: UniqueKey(),
            imagePath: "https://i.pravatar.cc/150?img=65",
            size: _deviceHeight * 0.15,
          );
        }
      }(),
    );
  }

  Widget _registerForm() {
    return SizedBox(
      height: _deviceHeight * 0.35,
      child: Form(
        key: _registerFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextFormField(
              onSaved: (value) {
                setState(() {
                  _name = value;
                });
              },
              regEx: r'.{3,}',
              hintText: "Name",
              obscureText: false,
            ),
            CustomTextFormField(
              onSaved: (value) {
                setState(() {
                  _email = value!.trim();
                });
              },
              regEx: r'^[^@]+@[^@]+\.[^@]+',
              hintText: "Email",
              obscureText: false,
            ),
            CustomTextFormField(
              onSaved: (value) {
                setState(() {
                  _password = value;
                });
              },
              regEx: r'.{6,}',
              hintText: "Password",
              obscureText: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _registerButton() {
    return RoundedButton(
      name: "Register",
      height: _deviceHeight * 0.065,
      width: _deviceWidth * 0.65,
      onPressed: () async {
        if (_registerFormKey.currentState!.validate()) {
          _registerFormKey.currentState!.save();
          String? uid = await _auth.registerUserUsingEmailAndPassword(
              _email!, _password!);
          if (uid != null) {
            String? imageURL;
            if (_profileImage != null) {
              imageURL = await _cloudStorage.saveUserImageToStorage(
                  uid, _profileImage!);
            }
            await _db.createUser(uid, _email!, _name!, imageURL ?? '');
            _navigation.NavigateToRoute('/home');
          } else {
            print("Registration failed");
          }
        }
      },
    );
  }
}
