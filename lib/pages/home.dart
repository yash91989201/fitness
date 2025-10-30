import 'package:fitness/models/category.dart';
import 'package:fitness/models/diet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
  List<DietModel> diets = [];

  AppBar appBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xffF7F8F8),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            'assets/icons/arrow-left.svg',
            height: 24,
            width: 24,
          ),
        ),
      ),
      title: Text(
        'Breakfast',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.all(12),
            width: 36,
            decoration: BoxDecoration(
              color: Color(0xffF7F8F8),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/icons/dots.svg',
              height: 4,
              width: 4,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _searchField(),
          SizedBox(height: 24),
          _categoriesSection(),
          SizedBox(height: 24),
          _dietSection(),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _getInitialInfo();
  }

  Column _categoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            'Categories',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: SizedBox(
            height: 160,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => SizedBox(width: 16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 120,
                  decoration: BoxDecoration(
                    color: categories[index].boxColor.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(categories[index].iconPath),
                        ),
                      ),
                      Text(
                        categories[index].name,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Column _dietSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Recommendation\nfor Diet',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 240,
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                width: 210,
                decoration: BoxDecoration(
                  color: diets[index].boxColor.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(diets[index].iconPath),
                    Column(
                      children: [
                        Text(
                          diets[index].name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '${diets[index].level} | ${diets[index].duration} | ${diets[index].calorie}',
                          style: const TextStyle(
                            color: Color(0xff7B6F72),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 45,
                      width: 130,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            diets[index].viewIsSelected
                                ? const Color(0xff9DCEFF)
                                : Colors.transparent,
                            diets[index].viewIsSelected
                                ? const Color(0xff92A3FD)
                                : Colors.transparent,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          'View',
                          style: TextStyle(
                            color: diets[index].viewIsSelected
                                ? Colors.white
                                : const Color(0xffC58BF2),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 25),
            itemCount: diets.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20, right: 20),
          ),
        ),
      ],
    );
  }

  void _getInitialInfo() {
    categories = CategoryModel.getCategories();
    diets = DietModel.getDiets();
  }

  Container _searchField() {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xff1D1617).withValues(alpha: 0.11),
            blurRadius: 40,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset('assets/icons/search.svg'),
          ),
          hintText: 'Search',
          hintStyle: TextStyle(
            color: Color(0xffBDBDBD),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          suffixIcon: SizedBox(
            width: 80,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  VerticalDivider(
                    color: Color(0xffE0E0E0),
                    indent: 12,
                    endIndent: 12,
                    thickness: 0.1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset('assets/icons/filter.svg'),
                  ),
                ],
              ),
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
