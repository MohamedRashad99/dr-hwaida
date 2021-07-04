import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:DrHwaida/models/consultantApi.dart';
import 'package:DrHwaida/models/utils.dart';
import 'package:flutter/material.dart';

class CounsultantRating extends StatefulWidget {
  final int id;

  const CounsultantRating({Key key, @required this.id}) : super(key: key);
  @override
  _CounsultantRatingState createState() => _CounsultantRatingState();
}

class _CounsultantRatingState extends State<CounsultantRating> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ConsultantRateApi.fetchAllConsultantRate(widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return (snapshot.data == null)
                ? Container(
                    child: Center(
                      child: Text(
                        getTranslated(context, 'networkError'),
                        style: AppTheme.heading,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            CircleAvatar(
                              minRadius: 30,
                              maxRadius: 30,
                              child: (snapshot.data[index].image != null &&
                                      snapshot.data[index].image != '')
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: customCachedNetworkImage(
                                          context: context,
                                          url: snapshot.data[index].image,
                                        ),
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: AssetImage(
                                              Utils.userImageURL(
                                                  gender: snapshot
                                                      .data[index].gender),
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data[index].name,
                                  style: AppTheme.heading,
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    RatingStar(
                                      isReadOnly: true,
                                      rating: double.parse(
                                          snapshot.data[index].rate),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      snapshot.data[index].created_at,
                                      style: AppTheme.subHeading,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Text(
                                  (snapshot.data[index].comment == null ||
                                          snapshot.data[index].comment ==
                                              "null" ||
                                          snapshot.data[index].comment == '')
                                      ? ""
                                      : snapshot.data[index].comment,
                                  style: AppTheme.subHeading,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
          } else {
            return Align(
              alignment: Alignment.center,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}

// class Testing extends StatefulWidget {
//   @override
//   _TestingState createState() => _TestingState();
// }

// class _TestingState extends State<Testing> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: FutureBuilder(
//             future: ConsultantRateApi.fetchAllConsultantRate(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return (snapshot.data == null)
//                     ? Container(
//                         child: Text(
//                           'EMPATY',
//                           style: AppTheme.heading,
//                         ),
//                       )
//                     : ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: snapshot.data.length,
//                         itemBuilder: (context, index) {
//                           return Text(
//                             snapshot.data[index].comment,
//                             style: AppTheme.heading,
//                           );
//                         },
//                       );
//               } else {
//                 return Align(
//                   alignment: Alignment.center,
//                   child: Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                 );
//               }
//             }),
//       ),
//     );
//   }
// }
