import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:netflix_ui/showmodel.dart';
import 'package:netflix_ui/utils/color.dart';
import 'dart:convert';
import 'details_page.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  List<Show> shows = [];
  bool isRequesting =true; // For search filtering
  @override
  void initState() {
    getUserApi();
    // TODO: implement initState
    super.initState();
  }

  Future<void> getUserApi({String query='all'}) async {
    final response =
    await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=$query'));

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      setState(() {
        shows =jsonResponse.isEmpty?[]: jsonResponse.map((json) => Show.fromJson(json)).toList();
        isRequesting = false; // Initialize filteredShows with all shows
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load data from API')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Column(
        children: [
          SizedBox(height: 40,),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, size: 20), // Adjust icon size
                  hintText: 'Search ',
                  prefixStyle: TextStyle(
                    fontSize: 16, // Adjust text size to match icon
                    color: Colors.grey,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10), // Adjust vertical alignment
                  border: InputBorder.none,
                ),
                onChanged: (content) {
                  if (content.isNotEmpty) {
                    getUserApi(query: content);
                  } else {
                    getUserApi();
                  }
                },
              ),
            ),

          ),
          Expanded(child:
          isRequesting==true
              ? Center(
              child: CircularProgressIndicator()
          )
              :
          shows.isEmpty?Center(
            child: Text("Not Found",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
              ),
            ),
          )

              : GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: shows.length,
            itemBuilder: (context, index) {
              final show = shows[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(show: show),
                    ),
                  );
                },
                child: Card(
                  color: Colors.indigo.shade50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      show.imageUrl != null
                          ? Container(
                        height: 150,
                        width: double.infinity,
                        child: Image.network(
                          show.imageUrl!,
                          fit: BoxFit.fill,
                        ),
                      )
                          : Container(height: 150),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          show.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          show.summary
                              .replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ''),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          )
        ],
      ),
    );

  }
}
