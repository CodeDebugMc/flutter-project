import 'package:flutter/material.dart';
import '../widgets/newsfeed.dart';

class NewsfeedScreen extends StatelessWidget {
  const NewsfeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ClipRRect(
        //   borderRadius: BorderRadius.circular(8.0),
        //   child: Image.network(
        //     "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTnXOOZx8tElZ8KHzzfc6QiGOLbtpAhzndCRjT2g6ddLkoMaj2oF1CUofULkbBeWF3vRd_zNns0yX9H3PUMtwHbSQ",
        //     height: 50,
        //     width: 50,
        //   ),
        // ),
        ListTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage('../assets/images/mark.jpg'),
            backgroundColor: Colors.black,
          ),

          title: Text(
            "Mark Zuckerberg",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text("March 16"),
          trailing: Icon(Icons.more_horiz),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean velit mi, lobortis quis ligula vitae, venenatis pharetra libero. Praesent vitae urna placerat, tempus dolor eget, congue magna.",
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text("#highlights", style: TextStyle(color: Colors.blue)),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Image.network(
            "../assets/images/mark3.png",
            width: double.infinity,
            height: 480,
            fit: BoxFit.cover,
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.bookmark_sharp, color: Colors.red, size: 18),
                  Icon(Icons.favorite, color: Colors.red, size: 18),
                  SizedBox(width: 10),
                  Text("24"),
                ],
              ),
              Text("1001 Comments 200 Shares"),
            ],
          ),
        ),

        Divider(thickness: 2, color: Colors.grey[400]),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ActionButton(Icons.thumb_up_outlined, "Like"),
            ActionButton(Icons.mode_comment_outlined, "Comments"),
            ActionButton(Icons.share, "Share"),
          ],
        ),

        Divider(thickness: 2, color: Colors.grey[400]),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Most relevant",
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage('../assets/images/mark.jpg'),
                backgroundColor: Colors.black,
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Write a comment...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget ActionButton(IconData icon, String label) {
  return TextButton.icon(
    onPressed: () {},
    icon: Icon(icon, color: Colors.grey[800]),
    label: Text(label, style: TextStyle(color: Colors.grey[800])),
  );
}
