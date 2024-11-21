import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:netflix_ui/showmodel.dart';
import 'package:netflix_ui/utils/color.dart';
import 'dart:convert';

import 'details_page.dart';
class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<Show> shows = [];
  List<Show> filteredShows = []; // For search filtering

  List<String>filterTabs=[
    'Movie',
    'TV Serial',
    'Shows',
    'Bollywood',
    'Hollywood',
    'Tamil'
  ];
  @override
  void initState() {
    getUserApi();
    // TODO: implement initState
    super.initState();
  }

  Future<void> getUserApi() async {
    final response =
    await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=all'));

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      setState(() {
        shows = jsonResponse.map((json) => Show.fromJson(json)).toList();
        filteredShows = shows; // Initialize filteredShows with all shows
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
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width/1,
                child:ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: filterTabs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child:Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20), // Add border radius
                            border: Border.all(color: Colors.white, width: 2), // Add white outline border
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5), // Shadow color with opacity
                                spreadRadius: 1, // Spread radius
                                blurRadius: 2, // Blur radius
                                offset: Offset(2, 3), // Offset in x and y directions
                              ),
                            ],
                          ),
                          alignment: Alignment.center, // Align the text at the center
                          child: Text(
                            filterTabs[index],
                            style: TextStyle(color: Colors.white),
                          ),
                        )


                    );
                  },
                )

            ),
          ),
          Expanded(child:
          filteredShows.isEmpty
              ? Center(
              child: CircularProgressIndicator()
          )
              : GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: filteredShows.length,
            itemBuilder: (context, index) {
              final show = filteredShows[index];
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
