import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../model/text_model.dart';
import '../../../utils/colors_constant.dart';
import '../../custom_widgets/custom_searchbar.dart';
import '../../item_data/book_services_item.dart';
import '../../item_data/latest_item.dart';

class HomeScreen extends StatefulWidget {
  final ScrollController scrollController;
  const HomeScreen({Key? key, required this.scrollController}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<TextModel> tabTextData = [
    TextModel(tabText: "Latest"),
    TextModel(tabText: "Job"),
    TextModel(tabText: "Properties"),
    TextModel(tabText: "Cars"),
    TextModel(tabText: "Services"),
    TextModel(tabText: "PlanTm"),
    TextModel(tabText: "Buy & Sell"),
    TextModel(tabText: "Beauty"),
    TextModel(tabText: "Bookings"),
    TextModel(tabText: "Restaurants"),
    TextModel(tabText: "Things to do"),
  ];
  
  @override
  Widget build(BuildContext context) {
    var finalHeight = MediaQuery.of(context).size.height;
    var finalWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: widget.scrollController,
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: finalHeight/16,
            pinned: false,
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 1,
            title: Image.asset("assets/images/meui_logo.png", height: finalHeight/11,),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
                [
                  Divider(color: Colors.grey,),
                  SizedBox(
                    height: finalHeight/20,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: tabTextData.length,
                      itemBuilder: (context, index) {
                        final data = tabTextData[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Text(data.tabText, style: TextStyle(fontWeight: FontWeight.w600),),
                      );

                    },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CustomSearchBar(controller: _searchController),
                  ),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: latestData.length,
                    itemBuilder: (context, index) {
                      final dataLatest = latestData[index];

                      // Handling null values if any
                      if (dataLatest == null) {
                        return SizedBox.shrink(); // Empty widget if dataLatest is null
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FittedBox(
                                child: Text(
                                  dataLatest.title ?? "No title",
                                    style: TextStyle(color: ColorsConstant.textGreenColor, fontWeight: FontWeight.bold, fontSize: finalHeight/48)
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(dataLatest.description ?? "No description", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: finalHeight/70),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 200, // Adjust the height as needed
                                child: CachedNetworkImage(
                                  imageUrl: dataLatest.imageUrl ?? "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  Container(
                    height: finalHeight/3.5,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                    ),
                    child: ListView(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      children: [
                        Text("Book Services", style: TextStyle(color: ColorsConstant.buttonColor, fontWeight: FontWeight.w500, fontSize: finalHeight/48), ),
                        SizedBox(
                          height: finalHeight/4.5,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: bookServiceData.length,
                            itemBuilder: (context, index) {
                              final bookData = bookServiceData[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                              child: Card(
                                elevation: 5,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        child: CachedNetworkImage(
                                          imageUrl: "https://static.vecteezy.com/system/resources/thumbnails/004/141/669/small/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg",
                                          placeholder: (context, url) => const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                          fit: BoxFit.cover,
                                          width: finalWidth/3,
                                        ),
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      child: Text(bookData.serviceName),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },),
                        )
                      ],
                    ),
                  )
                ],
            ),
          ),
        ],
      ),
    );
  }
}
