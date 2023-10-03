  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:firebase_core/firebase_core.dart';
  import 'package:firebase_database/firebase_database.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter/services.dart';
  import 'package:myapp/Pages/User_infor.dart';
  import 'Login_page.dart';

  String text = '                          ';
  String value = '  ';

  class HomePage extends StatefulWidget {
    const HomePage({super.key});

    @override
    // ignore: library_private_types_in_public_api
    _HomePage createState() => _HomePage();
  }

  class _HomePage extends State<HomePage> {
    final Future<FirebaseApp> _future = Firebase.initializeApp();


    @override
    Widget build(BuildContext context) {
      getdata();
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              appBar: AppBar(
                title: const Text("Demo"),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.calendar_month),
                    tooltip: 'Calendar Icon',
                    onPressed: () {
                      Navigator.pushNamed(context, 'Lich');
                    },
                  ), //IconButton
                  IconButton(
                    icon: const Icon(Icons.search),
                    tooltip: 'Search Icon',
                    onPressed: () {
                      showSearch(
                          context: context,
                          // delegate to customize the search bar
                          delegate: SearchPage());
                    },
                  ), //IconButton
                ], //<Widget>[]
                backgroundColor: Colors.greenAccent[400],
                elevation: 50.0,
                systemOverlayStyle: SystemUiOverlayStyle.light,
              ), //AppBar
              drawer: Drawer(
                child: ListView(
                  children: [
                    Column(
                      children: [
                         CircleAvatar(
                           maxRadius: 80,
                          child: Container(
                            decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image:  AssetImage('assets/images/1230.jpg'),
                                fit: BoxFit.cover
                            ),
                          ),
                        ),),
                         Text(value,
                          style: const TextStyle(fontSize: 20),
                        ),
                        // const Text(
                        //   'Admin - Ban Giám Đốc',
                        //   style: TextStyle(fontSize: 14),
                        // ),
                        TextButton(
                          onPressed: () {
                            //showDataAlert(context);
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(text), // <-- Text
                                const SizedBox(
                                  width: 5,
                                ),
                                const Icon(
                                  // <-- Icon
                                  Icons.arrow_drop_down,
                                  size: 24.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      leading: const Icon(Icons.format_list_bulleted_outlined),
                      title: const Text('Lịch khám đã đặt'),
                      onTap: () {
                        Navigator.pushNamed(context, 'Lich');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.add_card),
                      title: const Text('Đặt lịch khám'),
                      onTap: () {
                        Navigator.pushNamed(context, 'book');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.person_outline),
                      title: const Text('Thông tin người dùng'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserInfor()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Đăng xuất'),
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                          (Route<dynamic> route) => false,
                        );
                      },
                    ),
                     ListTile(
                        leading: const Icon(Icons.info),
                        title: const Text('Thông tin ứng dụng'),
                    onTap: () {
                      Navigator.pushNamed(context, 'Thongtin');
                    }),
                  ],
                ),
              ),
              body: FutureBuilder(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else {
                      return DefaultTabController(
                        length: 5,
                        child: Scaffold(
                            appBar: const TabBar(
                              indicatorColor: Colors.amber,
                              labelColor: Colors.greenAccent,
                              tabs: [
                                Tab(
                                  icon: Icon(Icons.people_alt,
                                      color: Colors.greenAccent),
                                ),
                                Tab(
                                    icon: Icon(Icons.people_alt_outlined,
                                        color: Colors.green)),
                                Tab(
                                    icon: Icon(
                                  Icons.notifications,
                                  color: Colors.redAccent,
                                )),
                                Tab(
                                    icon: Icon(
                                  Icons.warning,
                                  color: Colors.amber,
                                )),
                                Tab(
                                    icon: Icon(
                                  Icons.numbers,
                                  color: Colors.lightBlueAccent,
                                )),
                              ],
                            ),
                            body: Padding(
                              padding: const EdgeInsets.only(),
                              child: TabBarView(
                                children: [
                                  const Notification(),
                                  Text(
                                    'Tổng số bệnh nhân: $value',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 23,
                                    ),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image:  AssetImage('assets/images/1230.jpg'),
                                          fit: BoxFit.fill
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.warning,
                                    size: 100,
                                  ),
                                  const Icon(Icons.numbers),
                                ],
                              ),
                            )),
                      );
                    }
                  })));
    }

    void getdata() async {
      FirebaseAuth auth = FirebaseAuth.instance;
      String? uid = auth.currentUser?.uid;
      DatabaseReference ref = FirebaseDatabase.instance.ref('User/$uid');
      ref.onValue.listen((DatabaseEvent event) {
        final data = event.snapshot.value;
        if (data != null && data is Map) {
          // Kiểm tra xem dữ liệu có tồn tại và có đúng định dạng không
          if (data.containsKey("name")) {
            String name = data["name"];
            setState(() {
              value = name;
            });
          }
        }
      });
    }
  }

  class Notification extends StatefulWidget {
    const Notification({super.key});

    @override
    State<Notification> createState() => _NotificationState();
  }

  class _NotificationState extends State<Notification> {
    List<String> images = [
      "assets/images/3345.jpg",
      "assets/images/3344.jpg",
      "assets/images/2310.jpg",
    ];
    final PageController _pageController = PageController(viewportFraction: 0.8,initialPage: 1);
    int activePage = 2;
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            SizedBox(
              height: 200,
              child: PageView.builder(
                  itemCount: images.length,
                  pageSnapping: true,
                  controller: _pageController,
                  onPageChanged: (page) {
                    setState(() {
                      activePage = page;
                    });
                  },
                  itemBuilder: (context, pagePosition) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      child: Image.asset(images[pagePosition]),
                    );
                  }),
            ),
            menubutton,
            const SizedBox(height: 30,),
            image,
            const SizedBox(height: 30,),
            image,
            const SizedBox(height: 30,),
            image,
          ],
        ),
      );
    }

    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
              child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: const Text(
                  'abcdef',
                  style: TextStyle(fontSize: 30),
                ),
              ),
                const Icon(
                Icons.star_rate,
                size: 20,
                color: Colors.red,
              )
            ],
          ))
        ],
      ),
    );
    Widget menubutton =  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 10,),
      FloatingActionButton(
        onPressed: () {
          print('hehehehe');
        },
        backgroundColor: Colors.black12,
        child: const Icon(Icons.people_alt)),
        const FloatingActionButton(
            onPressed: null,
            backgroundColor: Colors.black12,
            child: Icon(Icons.people_alt)),
        const FloatingActionButton(
            onPressed: null,
            backgroundColor: Colors.black12,
            child: Icon(Icons.people_alt)),
        const FloatingActionButton(
            onPressed: null,
            backgroundColor: Colors.black12,
            child: Icon(Icons.people_alt)),
        const SizedBox(width: 10,),
      ],
    );
    Widget image = const Image(image: AssetImage("assets/images/3345.jpg"),);
  }

  class SearchPage extends SearchDelegate {
    // Demo list to show querying
    List<String> searchTerms = [
      "Apple",
      "Banana",
      "Mango",
      "Pear",
      "Watermelons",
      "Blueberries",
      "Pineapples",
      "Strawberries"
    ];

    // first overwrite to
    // clear the search text
    @override
    List<Widget>? buildActions(BuildContext context) {
      return [
        IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear),
        ),
      ];
    }

    // second overwrite to pop out of search menu
    @override
    Widget? buildLeading(BuildContext context) {
      return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back),
      );
    }

    // third overwrite to show query result
    @override
    Widget buildResults(BuildContext context) {
      List<String> matchQuery = [];
      for (var fruit in searchTerms) {
        if (fruit.toLowerCase().contains(query.toLowerCase())) {
          matchQuery.add(fruit);
        }
      }
      return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        },
      );
    }

    @override
    Widget buildSuggestions(BuildContext context) {
      List<String> matchQuery = [];
      for (var fruit in searchTerms) {
        if (fruit.toLowerCase().contains(query.toLowerCase())) {
          matchQuery.add(fruit);
        }
      }
      return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        },
      );
    }
  }

  // showDataAlert(BuildContext context) {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return const AlertDialog(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.all(
  //               Radius.circular(
  //                 20.0,
  //               ),
  //             ),
  //           ),
  //           content: RadioListTileExample(),
  //           contentPadding: EdgeInsets.only(
  //             top: 10.0,
  //           ),
  //         );
  //       });
  // }
  //
  // enum Groceries { pickles, tomato, lettuce }

  // class RadioListTileExample extends StatefulWidget {
  //   const RadioListTileExample({super.key});
  //
  //   @override
  //   State<RadioListTileExample> createState() => _RadioListTileExampleState();
  // }
  //
  // class _RadioListTileExampleState extends State<RadioListTileExample> {
  //   Groceries? _groceryItem = Groceries.pickles;
  //
  //   @override
  //   Widget build(BuildContext context) {
  //     return Scaffold(
  //       appBar: AppBar(title: const Text('')),
  //       body: Column(
  //         children: <Widget>[
  //           RadioListTile<Groceries>(
  //             value: Groceries.pickles,
  //             groupValue: _groceryItem,
  //             onChanged: (Groceries? value) {
  //               setState(() {
  //                 _groceryItem = value;
  //                 //Navigator.pop(context, false);
  //               });
  //             },
  //             title: const Text('Pickles'),
  //           ),
  //           RadioListTile<Groceries>(
  //             value: Groceries.tomato,
  //             groupValue: _groceryItem,
  //             onChanged: (Groceries? value) {
  //               setState(() {
  //                 _groceryItem = value;
  //                 // Navigator.pop(context, false);
  //               });
  //             },
  //             title: const Text('Tomato'),
  //           ),
  //           RadioListTile<Groceries>(
  //             value: Groceries.lettuce,
  //             groupValue: _groceryItem,
  //             onChanged: (Groceries? value) {
  //               setState(() {
  //                 _groceryItem = value;
  //                 //Navigator.pop(context, false);
  //               });
  //             },
  //             title: const Text('Lettuce'),
  //           ),
  //           ElevatedButton(
  //             onPressed: () {
  //               text = _groceryItem.toString();
  //               Navigator.of(context).pop(
  //                   MaterialPageRoute(builder: (context) => const HomePage()));
  //             },
  //             child: const Text('Đóng'),
  //           )
  //         ],
  //       ),
  //     );
  //   }
  // }
