
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Model/restaurant_model.dart';
import '../Provider/restaurant_provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<RestaurantProvider>(context,listen: false).getCurrentPosition();
    });
    super.initState();
  }
  
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body:SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              height: size.height*0.35,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0XFFFFE1E2),
                    Colors.white,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Padding(
                   padding: const EdgeInsets.only(top: 5),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.location_on,color: Colors.black),
                          Consumer<RestaurantProvider>(
                              builder: (context,value,child){
                                return Text(value.currentAddress,
                                    style: TextStyle(color: Colors.black,fontFamily: 'Poppins',fontSize: 15.0));
                              }
                          ),
                        ],
                      ),
                 ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: Text("Stories",
                        style: TextStyle(color: Colors.black,fontFamily: 'Poppins',fontSize: 14.0,fontWeight: FontWeight.w600)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 10, 2, 0),
                    child: Container(
                      width: size.width,
                      height: size.height*0.16,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: storyImages.length,
                        itemBuilder: (BuildContext context, int index) {
                          return story(size, storyImages[index]);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                    child: Container(
                      height: 50,
                      width: size.width*0.95,
                      padding: EdgeInsets.fromLTRB(20.0, 0.0,10.0,0.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0,2),
                              blurRadius: 4,
                              color: Colors.black.withOpacity(0.25),
                            ),
                          ]
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:<Widget> [
                          Icon(
                            Icons.search,
                            color: Color(0xFF000000),size: 25,
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: TextField(
                              controller: controller,
                              onChanged:(value) {
                                Provider.of<RestaurantProvider>(context,listen: false).searchRestaurants(value);
                              },
                              decoration: InputDecoration(
                                hintText: "Search Food Items",
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  color:Colors.grey.withOpacity(0.5),
                                  fontSize:14.0,
                                ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Container(
                height: size.height*0.1,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    category(size, 1, "All"),
                    Row(
                      children: [
                        Container(
                            height: 37,
                            width: size.width*0.22,
                            padding: const EdgeInsets.fromLTRB(10.0, 2.0,10.0,2.0),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(30.0),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0,2),
                                    blurRadius: 4,
                                    color: Colors.black.withOpacity(0.25),
                                  ),
                                ]
                            ),
                            child:Row(
                              children:[
                                Image.asset("assets/pizza.png",width: 20),
                                Center(
                                  child: Text(" Pizza",
                                      style: TextStyle(color: Colors.white,fontFamily: 'Poppins',fontSize: 14.0,fontWeight: FontWeight.w600)),
                                ),
                              ]
                            )
                        ),
                        SizedBox(width: 8)
                      ],
                    ),
                    category(size, 0 , "assets/chicken.png"),
                    category(size, 0 , "assets/vegan.png"),
                    category(size, 0 , "assets/burger.png"),
                  ],
                ),
              ),
            ),
            Padding(
              padding:  const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Text("Nearby Restaurants",
                  style: TextStyle(color: Colors.black,fontFamily: 'Poppins',fontSize: 14.0,fontWeight: FontWeight.w600)),
            ),


            Consumer<RestaurantProvider>(
                builder: (context,value,child){
                  if (value.isLoading)
                    {
                      return Center(child: CircularProgressIndicator(color: Colors.black,));
                    }
                  return Expanded(
                    child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: value.details.length,
                          itemBuilder: (BuildContext context, int index) {
                        return RestaurantCard(size,value.details[index]);
                      },
                    ),
                  );
                }
            )
          ],
        ),
      ),
    );
  }

  //List of image urls for story section
  List storyImages = [
    "https://image1.masterfile.com/getImage/NjU5LTA4OTAyNzI4ZW4uMDAwMDAwMDA=ABlXiR/659-08902728en_Masterfile.jpg",
    "https://www.eat-this.org/wp-content/uploads/2018/06/tofu-tikka-masala-2-740x493@2x.jpg",
    "https://img.jamieoliver.com/jamieoliver/recipe-database/46258570.jpg?tr=w-800,h-1066",
    "https://sinfullyspicy.com/wp-content/uploads/2021/11/899FA7B5-5AFA-4805-8A3C-508AFDF51115-768x1184.jpeg"
  ];

  //Code for story widget
  Widget story(Size size,String url)
  {
    return Row(
      children: [
        Container(
            height: size.height*0.16,
            width: size.width*0.25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: DecorationImage(
                  image: NetworkImage(url),
                  fit: BoxFit.cover
              ),
            ),
        ),
        SizedBox(width: 10)
      ],
    );
  }

  //Code for filter category widget
  Widget category(Size size,int check ,String content)
  {
    return Row(
      children: [
        Container(
            height: 35,
            width: size.width*0.15,
            padding: const EdgeInsets.fromLTRB(10.0, 2.0,10.0,2.0),
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
                BoxShadow(
                offset: Offset(0,2),
                blurRadius: 4,
                color: Colors.black.withOpacity(0.25),
                ),
              ]
            ),
          child: check == 1?
            Center(
              child: Text(content,
                  style: TextStyle(color: Colors.black,fontFamily: 'Poppins',fontSize: 14.0,fontWeight: FontWeight.w600)),
            ):
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(content,width: 5),
            )
        ),
        SizedBox(width: 8)
      ],
    );
  }

  //Code for each Restaurant widget
  Widget RestaurantCard(Size size,Details details) {
    return Column(
      children: [
        Container(
          height: size.height * 0.27,
          width: size.width * 0.9,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Colors.black.withOpacity(0.2)),
              boxShadow: [BoxShadow(
                color: Colors.black.withOpacity(0.25),
                offset: Offset(0, 4),
                blurRadius: 8,
              )
              ]
          ),
          child: Column(
            children: [
              Container(
                height: size.height * 0.17,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.0)),
                  image: DecorationImage(
                    image: NetworkImage(details.primaryImage),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      bottom: 15,
                      right: 15,
                      child: Container(
                        height: 25,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFF27C200),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(1, 0, 1, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(details.rating, style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFFffffff))),
                                Icon(Icons.star, color: Colors.white, size: 15)
                              ],
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 12, 18, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(details.name, style: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        fontSize: 20.0)),
                    Row(
                      children: [
                        Image.asset("assets/percentage.png",width: 25),
                        Text('  20% FLAT OFF', style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            fontSize: 14.0)),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 5, 18, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: 210,
                        child: Text(details.tags.split(",").join(" • "), style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            fontSize: 14.0))),
                    Text(details.distance, style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF000000))),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
