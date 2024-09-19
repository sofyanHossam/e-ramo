import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 2; // Start at Home (index 2)

  final pages = [
    Center(child: Text('Coupons')),
    Center(child: Text('Categories')),
    HomePageWithSearchAndSlider(), // Custom Home Page with Search and Slider
    Center(child: Text('Brands')),
    Center(child: Text('Settings')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        items: const <Widget>[
          Icon(Icons.local_offer, size: 30),
          Icon(Icons.category, size: 30),
          Icon(Icons.home, size: 50),
          Icon(Icons.store_mall_directory, size: 30),
          Icon(Icons.settings, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: pages[_page],
    );
  }
}

class HomePageWithSearchAndSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSearchBar(),
                SizedBox(height: 20),
                CustomSlider(),
                SizedBox(height: 20), // Space between slider and new content
                _buildTitleAndSeeAll(),
                SizedBox(height: 20), // Space between title and ListView
                _buildBackgroundImageWithListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Search Bar Widget
  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.black, width: 1), // Black outline
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey), // Left search icon
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search your beloved deal...',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          _buildNotificationIcon(), // Right notification icon
        ],
      ),
    );
  }

  // Notification Icon with Badge Widget
  Widget _buildNotificationIcon() {
    return Stack(
      children: [
        Icon(Icons.notifications, color: Colors.black),
        Positioned(
          right: 0,
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
            constraints: BoxConstraints(
              minWidth: 10,
              minHeight: 10,
            ),
            child: Text(
              '05', // Number on the notification
              style: TextStyle(
                color: Colors.white,
                fontSize: 8,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }

  // Title and "See All" Text
  Widget _buildTitleAndSeeAll() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'New Year Offer',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () {
            // Action for "See All" text
          },
          child: Text(
            'See All',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  // Background Image and ListView
  Widget _buildBackgroundImageWithListView() {
    return Container(
      height: 250, // Shortened height
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/your_background_image.png', // Background image
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10, // Adjust item count as needed
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 200, // Adjust width as needed
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Card(
                          elevation: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.favorite_border),
                                    onPressed: () {
                                      // Favorite action
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.share),
                                    onPressed: () {
                                      // Share action
                                    },
                                  ),
                                ],
                              ),
                              Center(
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: AssetImage('assets/images/lacost.png'), // Logo image
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'UP TO 50% OFF',
                                  textAlign: TextAlign.center, // Center text horizontally
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'assets/images/use_code.png', // Additional image
                                  height: 70, // Set fixed height
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Image Slider Widget
class CustomSlider extends StatelessWidget {
  final List<String> imageList = [
    'assets/images/img.png', // New image asset here
    'assets/images/img.png', // Additional sample images
    'assets/images/img.png',
    'assets/images/img.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.purple, width: 1), // Purple border
      ),
      child: CarouselSlider.builder(
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height * 0.4, // Adjust the height
          autoPlay: true,
          enlargeCenterPage: true,
        ),
        itemCount: imageList.length,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  imageList[index],
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 20,
                left: 20,
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/carfour.png'), // Add your logo image here
                ),
              ),
              Positioned(
                top: 100,
                left: 0,
                right: 0,
                child: Text(
                  '90% OFF', // Title text
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: MediaQuery.of(context).size.width * 0.25,
                right: MediaQuery.of(context).size.width * 0.25,
                child: ElevatedButton(
                  onPressed: () {
                    // Add action for the button
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'GET DEAL NOW',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
