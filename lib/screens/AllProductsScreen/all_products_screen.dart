import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stc_health/response/all_products_response.dart';
import 'package:stc_health/screens/AllProductsScreen/AllProductsBloc/allProducts_bloc.dart';
import 'package:stc_health/screens/DetailScreen/details_screen.dart';
import 'package:stc_health/utilities/colors.dart';

class AllProductsScrren extends StatefulWidget {
  const AllProductsScrren({super.key});

  @override
  State<AllProductsScrren> createState() => _AllProductsScrrenState();
}

class _AllProductsScrrenState extends State<AllProductsScrren> {
  int _currentIndex = 0;
  late AllProductsBloc _allProductsBloc;
  AllProductsResponse? allProductsResponse;
  var getData;
  @override
  void initState() {
    super.initState();

    _allProductsBloc = BlocProvider.of<AllProductsBloc>(context);
    _allProductsBloc.add(AllProductsData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllProductsBloc, AllProductsState>(
      listener: (context, state) {
        if (state is InitialAllProductsState) {
        } else if (state is LoadingAllProductsState) {
        } else if (state is AllProductsSuccess) {
          // allProductsResponse = state.data;
          getData = state.data;
          print(getData[0]['price']);
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: SizedBox(),
              title: Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  'All Products',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              centerTitle: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                side: BorderSide(color: Colors.black, width: 0.1),
              ),
              //  backgroundColor: AppColors.mainColor,
              bottom: PreferredSize(
                preferredSize: Size(0, 40),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (value) {
                setState(() {
                  _currentIndex = value;
                });
              },
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              currentIndex: _currentIndex,
              selectedItemColor: AppColors.mainColor,
              items: [
                BottomNavigationBarItem(
                  label: '',
                  icon: _currentIndex == 0
                      ? Icon(
                          Icons.list,
                          color: AppColors.mainColor,
                        )
                      : Icon(
                          Icons.list,
                          color: Color(0xFFBFC2C8),
                        ),
                ),
                BottomNavigationBarItem(
                  label: '',
                  icon: _currentIndex == 1
                      ? Image.asset(
                          'assets/images/Cart.png',
                          color: AppColors.mainColor,
                        )
                      : Image.asset('assets/images/Cart.png'),
                ),
                BottomNavigationBarItem(
                  label: '',
                  icon: _currentIndex == 2
                      ? Image.asset('assets/images/like.png', color: AppColors.mainColor)
                      : Image.asset('assets/images/like.png'),
                ),
                BottomNavigationBarItem(
                  label: '',
                  icon: _currentIndex == 3
                      ? Image.asset('assets/images/user.png', color: AppColors.mainColor)
                      : Image.asset('assets/images/user.png'),
                ),
              ],
            ),
            body: getData == null
                ? Center(
                    child: CircularProgressIndicator(color: AppColors.mainColor),
                  )
                : Padding(
                    padding: EdgeInsets.only(right: 20, left: 20, top: 10),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            child: ListView.builder(
                              itemCount: getData.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        print('the id is ${getData[index]['id']}');
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => DetailsScreen(
                                              id: getData[index]['id'],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        // height: MediaQuery.of(context).size.height * 0.36,
                                        width: double.infinity,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Card(
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    height: MediaQuery.of(context).size.height * 0.24,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10
                                                          // topLeft: Radius.circular(20),
                                                          // topRight: Radius.circular(20),
                                                          ),
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(getData[index]['image'].toString()),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: 0,
                                                    left: 10,
                                                    child: Text(
                                                      getData[index]['price'].toString(),
                                                      style: GoogleFonts.openSans(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: 22),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    right: 10,
                                                    bottom: 0,
                                                    child: RatingBar.builder(
                                                      allowHalfRating: true,
                                                      itemSize: 25,
                                                      minRating: 1,
                                                      initialRating:
                                                          double.parse(getData[index]['rating']['rate'].toString()),
                                                      itemBuilder: (context, index) =>
                                                          Icon(Icons.star, color: Colors.yellow),
                                                      onRatingUpdate: (value) {},
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 10, top: 10),
                                              child: Text(
                                                getData[index]['title'].toString(),
                                                style: GoogleFonts.openSans(
                                                  fontSize: 12,
                                                  color: AppColors.productTextColor,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Padding(
                                              padding: EdgeInsets.only(left: 10),
                                              child: Text(
                                                getData[index]['description'].toString(),
                                                style: GoogleFonts.openSans(
                                                    fontSize: 12, color: AppColors.productTextColor),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
