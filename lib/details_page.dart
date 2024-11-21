import 'package:flutter/material.dart';
import 'package:netflix_ui/showmodel.dart';
import 'package:netflix_ui/utils/color.dart';

class DetailsScreen extends StatelessWidget {
  final Show show;

  const DetailsScreen({Key? key, required this.show}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.navigate_before,size:30,color: Colors.white,),
        ),
        title: Text(

          show.name,
          style: TextStyle(
            color: Colors.white,fontSize: 18,
          ),
        ),

      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (show.imageUrl != null)
                Container(
                  width: double.infinity,
                  child: Image.network(
                    show.imageUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
              SizedBox(height: 16),
              Text(
                show.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: AppColors.white),
              ),
              SizedBox(height: 8),
              Text(
                show.summary.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ''),
                style: TextStyle(fontSize: 16,color: AppColors.white),
              ),
            ],
          ),
        ),
      ),

    );
  }
}

