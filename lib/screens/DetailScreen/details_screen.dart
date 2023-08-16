import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stc_health/Widgets/custom_button.dart';
import 'package:stc_health/response/detail_product_response.dart';
import 'package:stc_health/screens/DetailScreen/DetailBloc/detail_bloc.dart';
import 'package:stc_health/utilities/colors.dart';

import '../../Widgets/appIcon_button.dart';

class DetailsScreen extends StatefulWidget {
  final int id;
  DetailsScreen({required this.id});
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late DetailProductBloc _detailProductBloc;
  DetailProductResponse? detailProductResponse;

  bool isExpand = false;

  @override
  void initState() {
    super.initState();
    _detailProductBloc = BlocProvider.of<DetailProductBloc>(context);
    _detailProductBloc.add(DetailProductsData(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailProductBloc, DetailProductsState>(
      listener: (context, state) {
        if (state is InitialDetailProductsState) {
        } else if (state is LoadingDetailProductsState) {
        } else if (state is DetailProductsSuccess) {
          detailProductResponse = state.data;
        }
      },
      builder: (context, state) {
        var height = MediaQuery.of(context).size.height;

        return SafeArea(
          child: Scaffold(
            body: detailProductResponse == null
                ? Center(
                    child: CircularProgressIndicator(color: AppColors.mainColor),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height,
                    //color: Colors.blueAccent,
                    child: Stack(
                      children: [
                        Container(
                          height: isExpand ? height * 0.7 : height * 0.59,
                          // width: MediaQuery.of(context).size.width,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(detailProductResponse!.image!),
                            ),
                          ),
                          child: Align(
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  '${detailProductResponse!.price!.toString()} AED',
                                  style: GoogleFonts.openSans(
                                    color: AppColors.detailPriceColor,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              alignment: Alignment.bottomLeft),
                        ),
                        Positioned(
                          top: 100,
                          left: 10,
                          child: Text(
                            'Details',
                            style: GoogleFonts.openSans(
                              fontSize: 28,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: AppIconButton(
                                  icon: Icon(Icons.arrow_back, size: 25),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 2,
                                      color: Colors.grey.withOpacity(0.4),
                                      // offset: Offset(4, 3),
                                      spreadRadius: 0.2,
                                      blurStyle: BlurStyle.outer,
                                    ),
                                  ],
                                ),
                              ),
                              AppIconButton(
                                icon: Icon(Icons.more_vert, size: 25),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2,
                                    color: Colors.grey.withOpacity(0.4),
                                    // offset: Offset(4, 3),
                                    spreadRadius: 0.2,
                                    blurStyle: BlurStyle.outer,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            height: isExpand ? height * 0.29 : height * 0.4,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(left: 15, right: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isExpand = !isExpand;
                                    });
                                  },
                                  child: Center(
                                    child: Icon(
                                      isExpand ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                      size: 30,
                                      color: AppColors.mainColor,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    AppIconButton(
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 2,
                                          color: Colors.grey.withOpacity(0.4),
                                          // offset: Offset(4, 3),
                                          spreadRadius: 0.2,
                                          blurStyle: BlurStyle.outer,
                                        ),
                                      ],
                                      height: 60,
                                      width: 60,
                                      icon: Image.asset(
                                        'assets/images/share.png',
                                        scale: 4,
                                      ),
                                    ),
                                    SizedBox(width: 30),
                                    Container(
                                      height: 60,
                                      width: 270,
                                      child: CustomButton(
                                        buttonText: 'Order now',
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(
                                  detailProductResponse!.title!,
                                  style: GoogleFonts.openSans(
                                    color: AppColors.descriptionTextColor,
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  detailProductResponse!.description!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                  style: GoogleFonts.openSans(
                                    color: AppColors.descriptionColor,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 10),
                                isExpand
                                    ? SizedBox()
                                    : Container(
                                        height: 80,
                                        decoration: BoxDecoration(color: AppColors.ratingContainer),
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              Text(
                                                'Reviews (100)',
                                                style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w600),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    detailProductResponse!.rating!.rate!.toString(),
                                                    style:
                                                        GoogleFonts.openSans(fontWeight: FontWeight.w600, fontSize: 30),
                                                  ),
                                                  SizedBox(width: 30),
                                                  RatingBar.builder(
                                                    allowHalfRating: true,
                                                    itemSize: 25,
                                                    minRating: 1,
                                                    initialRating:
                                                        double.parse(detailProductResponse!.rating!.rate!.toString()),
                                                    itemBuilder: (context, index) =>
                                                        Icon(Icons.star, color: Colors.yellow),
                                                    onRatingUpdate: (value) {},
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
