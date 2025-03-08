import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoppie_well/core/utils/svgs.dart';

import '../../../../core/utils/product_card.dart';
import 'details_page.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  final CollectionReference fetchData = FirebaseFirestore.instance.collection(
    "products",
  );

  int currentIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  final List<String> imageUrls = [
    'https://i.pinimg.com/736x/fa/45/96/fa4596ad9a9d39901eeb455ed4f74e44.jpg',
    'https://img.cdnx.in/369140/_slider/slide_1718824904994-1718824905358.jpg?width=600&format=jpeg',
    'https://i.pinimg.com/736x/57/e1/e6/57e1e681dbe970538c627164b301a540.jpg',
    'https://crepdogcrew.com/cdn/shop/collections/Tab_Banners_3.png?v=1734594345&width=2048',
  ];
  final List<Map> catogory = [
    {
      'image':
          'https://images.unsplash.com/photo-1596462502278-27bfdc403348?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8YmVhdXR5JTIwcHJvZHVjdHN8ZW58MHx8MHx8fDA%3D',
      'text': 'Beauty',
    },
    {
      'image':
          'https://i0.wp.com/textilelearner.net/wp-content/uploads/2017/09/Haute-couture-fashion-dress.jpg?resize=400%2C551&ssl=1',
      'text': 'Fashion',
    },
    {
      'image':
          'https://admin.indiantelevision.com/sites/default/files/styles/smartcrop_800x800/public/images/tv-images/2019/09/23/PUMA_one8.jpg?itok=01TvYvOa',
      'text': 'Kids',
    },
    {
      'image':
          'https://img.freepik.com/free-photo/young-man-with-beard-white-t-shirt_273609-5760.jpg?semt=ais_hybrid',
      'text': 'Men',
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTg-sGL5amGqTSdkoHe1FJyjhUG5eYyvqMGcthvD3A7lWP3wl60heOzh0NyFXu2Jkf6b28&usqp=CAU',
      'text': 'Women',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: Icon(Icons.menu),
        title: Image.asset('asset/logo.png', height: 30.h),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 20.r,
              backgroundImage: NetworkImage(
                "https://cdni.iconscout.com/illustration/premium/thumb/woman-profile-illustration-download-in-svg-png-gif-file-formats--young-female-girl-avatar-portraits-pack-people-illustrations-6590622.png",
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search Any Products...",
                  hintStyle: TextStyle(fontSize: 14.sp),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: Icon(Icons.keyboard_voice_rounded),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.2, color: Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.2,
                      color: Colors.blueAccent,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.2, color: Colors.green),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "All Featured",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 1,
                        offset: Offset(0, 1),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Text("Sort"),
                      SvgPicture.string(ShoppieSvgs.sort),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 1,
                        offset: Offset(0, 1),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Text("Filter"),
                      SvgPicture.string(ShoppieSvgs.filter),
                    ],
                  ),
                ),
                SizedBox(width: 15),
              ],
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: 100.h,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 10),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 34.r,
                        backgroundImage: NetworkImage(catogory[index]['image']),
                      ),
                      SizedBox(height: 5),
                      Text(
                        catogory[index]['text'],
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(width: 5);
                },
                itemCount: catogory.length,
              ),
            ),
            CarouselSlider(
              carouselController: _controller,
              options: CarouselOptions(
                height: 170.h,
                autoPlay: false,
                enlargeCenterPage: true,
                aspectRatio: 16 / 10,
                viewportFraction: 1.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
              items:
                  imageUrls.map((url) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(url),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular Product",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: fetchData.snapshots(),
              builder: (context, streamSnapshot) {
                if (streamSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (streamSnapshot.hasError) {
                  return const Center(child: Text('Error fetching data'));
                }

                if (!streamSnapshot.hasData ||
                    streamSnapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No data available"));
                }

                return SizedBox(
                  height: 270.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => ProductDetailsPage(
                                    product: documentSnapshot,
                                  ),
                            ),
                          );
                          setState(() {});
                        },
                        child: ProductCard(product: documentSnapshot),
                      );
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }
}
