import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:DrHwaida/models/user.dart';
import 'package:DrHwaida/models/utils.dart';
import 'package:DrHwaida/models/visaCard.dart';
import 'package:DrHwaida/screens/settings/settings.dart';
import 'package:DrHwaida/screens/wrapper/authenticate/signUp/singUpUserInfo/components/age.dart';
import 'package:DrHwaida/screens/wrapper/authenticate/signUp/singUpUserInfo/components/gender.dart';
import 'package:DrHwaida/screens/wrapper/authenticate/signUp/singUpUserInfo/components/status.dart';
import 'package:DrHwaida/screens/wrapper/home/home.dart';
import 'package:DrHwaida/services/dataBase.dart';
import 'package:DrHwaida/services/network_sensitive.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../CustomBottomNavigationBar.dart';

class UserProfile extends StatefulWidget {
  final String userName;
  static bool loading = false;

  final String userimgUrl;

  UserProfile({@required this.userName, @required this.userimgUrl});
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  // final _formKey = GlobalKey<FormState>();

  String name;
  String userPhone;
  String userEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: (Text(
          getTranslated(context, 'profile'),
          style: AppTheme.heading.copyWith(
            color: Colors.white,
          ),
        )),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => Settings(),
                ),
              );
            },
            icon: Icon(Icons.settings),
          ),
        ],
        leading: (IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              Helper.tappedBottomShet = 0;
            });
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => Home(),
              ),
            );
          },
        )),
      ),
      body: StreamBuilder<Users>(
        stream: DatabaseServices(userToken: User.userToken, context: context)
            .userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Users userData = snapshot.data;

            return NetworkSensitive(
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height - 150,
                    child: ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 40,
                      ),
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            UserPorfileImage(
                              userimgUrl: userData.userImageUrl,
                              gender: userData.userGender,
                            ),
                            SizedBox(height: 20),
                            Text(
                              (name) ?? userData.name,
                              style: AppTheme.heading.copyWith(
                                fontSize: 20,
                                color: customColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Form(
                          child: Column(
                            children: [
                              TextFormField(
                                initialValue: userData.name,
                                onChanged: (val) {
                                  setState(
                                    () {
                                      name = val;
                                    },
                                  );
                                },
                                decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.edit,
                                  ),
                                  prefixIcon: Container(
                                    margin: EdgeInsets.all(8),
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      gradient: AppTheme.containerBackground,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                initialValue: userData.phoneNumber,
                                keyboardType: TextInputType.phone,
                                onChanged: (val) {
                                  setState(
                                    () {
                                      userPhone = val;
                                    },
                                  );
                                },
                                decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.edit,
                                  ),
                                  prefixIcon: Container(
                                    margin: EdgeInsets.all(8),
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      gradient: AppTheme.containerBackground,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.phone,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                initialValue: userData.email,
                                onChanged: (val) {
                                  setState(
                                    () {
                                      userEmail = val;
                                    },
                                  );
                                },
                                decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.edit,
                                  ),
                                  prefixIcon: Container(
                                    margin: EdgeInsets.all(8),
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      gradient: AppTheme.containerBackground,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.email,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Status(
                                      stauts: userData.userStutes,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Expanded(
                                    flex: 1,
                                    child: Age(
                                      age: userData.userBrDate,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Gender(
                                gender: userData.userGender,
                              ),
                              SizedBox(height: 20),
                              // ignore: deprecated_member_use
                              RaisedButton(
                                color: customColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                onPressed: () {
                                  setState(() {
                                    UserProfile.loading = !UserProfile.loading;
                                  });
                                  DatabaseServices(
                                          userToken: User.userToken,
                                          context: context)
                                      .upDateUserData(
                                    age: (Age.resAge) ?? userData.userBrDate,
                                    userEmail: (userEmail) ?? userData.email,
                                    name: (name) ?? userData.name,
                                    status: (Status.resStautes) ??
                                        userData.userStutes,
                                    gender: (Gender.resGender) ??
                                        userData.userGender,
                                    phoneNummber:
                                        (userPhone) ?? userData.phoneNumber,
                                    userImage: (UserPorfileImage.image) ?? null,
                                    context: context,
                                  );
                                },
                                child: Text(
                                  (UserProfile.loading == true)
                                      ? getTranslated(context, 'saving')
                                      : getTranslated(context, 'save'),
                                  style: AppTheme.heading.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomBottomNavigationBar(),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  String userImages({String fileImage, String userDateimg}) {
    String imageUrl;
    if (fileImage != null) {
      imageUrl = fileImage;
    } else if (userDateimg != null || userDateimg != '') {
      imageUrl = userDateimg;
    } else {
      imageUrl = '';
    }
    return imageUrl;
  }
}

class UserPorfileImage extends StatefulWidget {
  static File image;
  const UserPorfileImage({
    Key key,
    // @required this.onTap,
    @required this.userimgUrl,
    @required this.gender,
  }) : super(key: key);

  // final Function onTap;
  final String userimgUrl;
  final String gender;

  @override
  _UserPorfileImageState createState() => _UserPorfileImageState();
}

class _UserPorfileImageState extends State<UserPorfileImage> {
  final picker = ImagePicker();
  File _imageFile;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 190 * 3.14 / 97,
      child: Hero(
        tag: 'userImg${widget.userimgUrl}',
        child: Center(
          child: Stack(
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: customColor,
                    width: 1,
                  ),
                ),
                padding: EdgeInsets.all(2),
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipOval(
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: (_imageFile != null)
                          ? Image.file(
                              _imageFile,
                              fit: BoxFit.cover,
                            )
                          : (widget.userimgUrl != '')
                              ? Image(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(widget.userimgUrl),
                                )
                              : Image(
                                  image: AssetImage(
                                    Utils.userImageURL(gender: widget.gender),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    _showPickOptionsDialog(context);
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      shape: BoxShape.circle,
                      gradient: AppTheme.containerBackground,
                    ),
                    child: Center(
                      child: Icon(
                        FontAwesomeIcons.edit,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _loadPicker(ImageSource source, BuildContext context) async {
    ImagePicker imagePicker = ImagePicker();
    // ignore: deprecated_member_use
    PickedFile picked = await imagePicker.getImage(source: source);
    if (picked != null) {
      _cropImage(picked, context);
    }
    Navigator.of(context).pop();
  }

  _cropImage(PickedFile picked, BuildContext context) async {
    try {
      File cropped = await ImageCropper.cropImage(
        androidUiSettings: AndroidUiSettings(
          statusBarColor: Colors.red,
          toolbarColor: Colors.red,
          toolbarTitle: "Crop Image",
          toolbarWidgetColor: Colors.white,
        ),
        sourcePath: picked.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio16x9,
          CropAspectRatioPreset.ratio4x3,
        ],
        maxWidth: 800,
      );
      if (cropped != null) {
        setState(() {
          _imageFile = cropped;
          UserPorfileImage.image = _imageFile;
        });
      }
    } catch (e) {
      print('piker error:' + e.toString());
    }
  }

  void _showPickOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(getTranslated(context, "Gallery")),
              onTap: () {
                _loadPicker(ImageSource.gallery, context);
              },
            ),
            ListTile(
              title: Text(getTranslated(context, "takepictuer")),
              onTap: () {
                _loadPicker(ImageSource.camera, context);
              },
            )
          ],
        ),
      ),
    );
  }
}
