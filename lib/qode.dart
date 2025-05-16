import 'package:flutter/material.dart';
import 'globals.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  final List<Map<String, dynamic>> _collections = [
    {"title": "My Favorite", "itemCount": 8},
    {"title": "Daily", "itemCount": 5},
  ];

  void _addNewCollection() {
    TextEditingController _textController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Add New Collection",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          content: TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: "Enter collection name",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel", style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () {
                if (_textController.text.isNotEmpty) {
                  setState(() {
                    _collections.add({
                      "title": _textController.text,
                      "itemCount": 0,
                    });
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _deleteCollection(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Delete Collection",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          content: Text(
            "Are you sure you want to delete '${_collections[index]["title"]}'?",
            style: GoogleFonts.poppins(fontSize: 14),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel", style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _collections.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      bottomNavigationBar: _bottomNavigationBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            GestureDetector(
              onTap: _addNewCollection,
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/svgs/addnewcollect-icon.svg",
                    width: 20,
                    height: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Add new collection",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: dasar,
                    ),
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    "assets/svgs/menu2-icon.svg",
                    width: 19.01,
                    height: 12,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // List koleksi
            Expanded(
              child: ListView.builder(
                itemCount: _collections.length,
                itemBuilder: (context, index) {
                  final collection = _collections[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: _collectionItem(
                      iconPath: "assets/svgs/myfav-icon.svg",
                      title: collection["title"],
                      itemCount: collection["itemCount"],
                      actionIconPath: "assets/svgs/aksi-icon.svg",
                      onDelete: () => _deleteCollection(index),
                      onTap: () {
                        // Navigasi ke halaman tertentu (bisa dikustomisasi)
                        Navigator.pushNamed(context, '/myfavorite');
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() => AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(children: [
          IconButton(
            onPressed: (() {}),
            icon: SvgPicture.asset('assets/svgs/menu-icon.svg'),
          ),
          const SizedBox(width: 24),
          Text(
            'Bookmark',
            style: GoogleFonts.poppins(
                fontSize: 20, fontWeight: FontWeight.bold, color: dasar),
          ),
          const Spacer(),
          IconButton(
            onPressed: (() {}),
            icon: SvgPicture.asset('assets/svgs/search-icon.svg'),
          ),
        ]),
      );

  BottomNavigationBar _bottomNavigationBar(BuildContext context) =>
      BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: 4,
        items: [
          _bottomBarItem(icon: "assets/svgs/quran-icon.svg", label: "Quran"),
          _bottomBarItem(icon: "assets/svgs/lamp-icon.svg", label: "Lamp"),
          _bottomBarItem(icon: "assets/svgs/pray-icon.svg", label: "Pray"),
          _bottomBarItem(icon: "assets/svgs/doa-icon.svg", label: "Doa"),
          _bottomBarItem(
              icon: "assets/svgs/bookmark-icon.svg", label: "Bookmark")
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/quran');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/lamp');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/pray');
          } else if (index == 3) {
            Navigator.pushNamed(context, '/doa');
          }
        },
      );

  BottomNavigationBarItem _bottomBarItem(
          {required String icon, required String label}) =>
      BottomNavigationBarItem(
          icon: SvgPicture.asset(
            icon,
            color: text,
          ),
          activeIcon: SvgPicture.asset(
            icon,
            color: birutua,
          ),
          label: label);

  Widget _collectionItem({
    required String iconPath,
    required String title,
    required int itemCount,
    required String actionIconPath,
    required VoidCallback onTap,
    required VoidCallback onDelete,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "$itemCount items",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: text,
                  ),
                ),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: onDelete,
              child: SvgPicture.asset(
                actionIconPath,
                width: 20,
                height: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
