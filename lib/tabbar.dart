// import 'package:flutter/material.dart';
// class Categoriessssss extends StatelessWidget {
//   const Categoriessssss({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
//
// class CategorySubcategoryProductExample extends StatefulWidget {
//   @override
//   _CategorySubcategoryProductExampleState createState() => _CategorySubcategoryProductExampleState();
// }
//
// class _CategorySubcategoryProductExampleState extends State<CategorySubcategoryProductExample> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Category Subcategory Product Example'),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           // Category TabBar
//           Container(
//             height: 50,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: categories.length,
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _selectedCategoryIndex = index;
//                       _selectedSubcategoryIndex = 0; // Reset subcategory index
//                     });
//                   },
//                   child: Container(
//                     padding: EdgeInsets.symmetric(horizontal: 16),
//                     alignment: Alignment.center,
//                     color: _selectedCategoryIndex == index
//                         ? Colors.blue
//                         : Colors.grey[300],
//                     child: Text(
//                       categories[index]['categoryName'],
//                       style: TextStyle(
//                         color: _selectedCategoryIndex == index
//                             ? Colors.white
//                             : Colors.black,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           SizedBox(height: 16),
//
//           // Subcategory List
//           Container(
//             height: 100,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: categories[_selectedCategoryIndex]['subcategories']
//                   .length,
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _selectedSubcategoryIndex = index;
//                     });
//                   },
//                   child: Container(
//                     margin: EdgeInsets.symmetric(horizontal: 8),
//                     padding: EdgeInsets.all(8),
//                     alignment: Alignment.center,
//                     color: _selectedSubcategoryIndex == index
//                         ? Colors.blue
//                         : Colors.grey[300],
//                     child: Text(
//                       categories[_selectedCategoryIndex]['subcategories'][index]
//                       ['subcategoryName'],
//                       style: TextStyle(
//                         color: _selectedSubcategoryIndex == index
//                             ? Colors.white
//                             : Colors.black,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           SizedBox(height: 16),
//
//           // Product Section
//           Expanded(
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               color: Colors.grey[200],
//               child: Center(
//                 child: Text(
//                   'Products for Subcategory ID: ${categories[_selectedCategoryIndex]['subcategories'][_selectedSubcategoryIndex]['subcategoryId']}',
//                   style: TextStyle(fontSize: 18),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
