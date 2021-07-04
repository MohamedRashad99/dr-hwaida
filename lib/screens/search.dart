// import 'package:DrHwaida/constants/themes.dart';
// import 'package:flutter/material.dart';

// class DataSearch extends SearchDelegate {
//   DataSearch()
//       : super(
//           searchFieldStyle: AppTheme.heading.copyWith(
//             color: Colors.white,
//           ),
//           keyboardType: TextInputType.text,
//           textInputAction: TextInputAction.search,
//         );
//   @override
//   ThemeData appBarTheme(BuildContext context) {
//     assert(context != null);
//     final ThemeData theme = ThemeData(
//       textTheme: TextTheme(
//         headline6: TextStyle(
//           color: Colors.white,
//           fontFamily: 'Cairo',
//           fontSize: 18,
//         ),
//       ),
//       primaryColor: Color(0xfff880e4f),
//       iconTheme: IconThemeData(
//         color: Color(0xfff880e4f),
//       ),
//     );
//     assert(theme != null);
//     return theme;
//   }

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return Container();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//     );
//   }
// }

// class UserListTile extends StatefulWidget {
//   final String userName;
//   final String userEmail;
//   final String userImage;

//   UserListTile({this.userName, this.userEmail, this.userImage});

//   @override
//   _UserListTileState createState() => _UserListTileState();
// }

// class _UserListTileState extends State<UserListTile> {
//   DatabaseServices _databaseServices = DatabaseServices();

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         createChatRooms(widget.userName, widget.userImage, widget.userImage);
//       },
//       child: Card(
//         elevation: 2,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Column(
//                 children: [
//                   Text(
//                     widget.userName,
//                     style: AppTheme.heading,
//                   ),
//                   Text(
//                     widget.userEmail,
//                     style: AppTheme.subHeading,
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 width: 8,
//               ),
//               CircleAvatar(
//                 backgroundColor: customColor,
//                 maxRadius: 30,
//                 backgroundImage: NetworkImage(
//                   widget.userImage,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   createChatRooms(String userName, String userImage, String userImageUrl) {
//     String chatRoomId = getChatRoomId(userName, UserData.name);
//     List<String> users = [userName, UserData.name];
//     Map<String, dynamic> chatMap = {
//       'users': users,
//       'chatroomId': chatRoomId,
//       'userImage': userImageUrl,
//     };
//     _databaseServices.createChatRoom(chatRoomId, chatMap);
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(
//         builder: (_) => ChatRoom(
//           title: userName,
//           chatRoomId: chatRoomId,
//           userImage: userImage,
//         ),
//       ),
//     );
//   }

//   getChatRoomId(String a, String b) {
//     if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
//       return '$a\_$b';
//     } else {
//       return '$b\_$a';
//     }
//   }
// }

// class DataSearchUsers extends SearchDelegate {
//   DataSearchUsers()
//       : super(
//           searchFieldStyle: AppTheme.heading.copyWith(
//             color: Colors.white,
//           ),
//           keyboardType: TextInputType.text,
//           textInputAction: TextInputAction.search,
//         );
//   @override
//   ThemeData appBarTheme(BuildContext context) {
//     assert(context != null);
//     final ThemeData theme = ThemeData(
//       textTheme: TextTheme(
//         headline6: TextStyle(
//           color: Colors.white,
//           fontFamily: 'Cairo',
//           fontSize: 18,
//         ),
//       ),
//       primaryColor: Color(0xfff880e4f),
//       iconTheme: IconThemeData(
//         color: Color(0xfff880e4f),
//       ),
//     );
//     assert(theme != null);
//     return theme;
//   }

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return Container();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     DatabaseServices _data = DatabaseServices();
//     return (query.isEmpty)
//         ? Scaffold(
//             backgroundColor: Colors.white,
//           )
//         : Scaffold(
//             backgroundColor: Colors.white,
//             body: FutureBuilder(
//               future: _data.getUserByUserName(query),
//               builder: (context, snapshot) {
//                 return (snapshot.hasData)
//                     ? ListView.builder(
//                         itemCount: snapshot.data.documents.length,
//                         shrinkWrap: true,
//                         itemBuilder: (context, index) {
//                           return UserListTile(
//                             userEmail:
//                                 snapshot.data.documents[index].data['email'],
//                             userName:
//                                 snapshot.data.documents[index].data['name'],
//                             userImage: snapshot
//                                 .data.documents[index].data['userImageUrl'],
//                           );
//                         },
//                       )
//                     : Container();
//               },
//             ),
//           );
//   }
// }
