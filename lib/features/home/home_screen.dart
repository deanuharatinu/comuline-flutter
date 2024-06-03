import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              title: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/ic_comuline_logo.svg',
                    width: 26,
                    colorFilter: ColorFilter.mode(
                      Colors.grey.shade400,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Comuline',
                    style: TextStyle(
                      fontFamily: 'GeistMono',
                      color: Colors.grey.shade400,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.dark_mode_outlined,
                    color: Colors.grey.shade600,
                  ),
                ),
                // IconButton(
                //   onPressed: () {},
                //   icon: Icon(
                //     Icons.search,
                //     color: Colors.grey.shade600,
                //   ),
                // ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.swap_vert,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
              // child: SizedBox(
              //   height: 20,
              //   child: Center(
              //     child: Text('Scroll to see the SliverAppBar in effect.'),
              //   ),
              // ),
            ),
            SliverAppBar(
              pinned: true,
              floating: true,
              surfaceTintColor: Colors.grey.shade500,
              backgroundColor: Colors.white, // TODO pake dynamic theme
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                title: SearchBar(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        side: BorderSide(
                          color: Colors.grey.shade400,
                          width: 1,
                        )),
                  ),
                  backgroundColor: WidgetStatePropertyAll(
                      Colors.grey.shade400.withAlpha(20)), // TODO dynamic theme
                  elevation: const WidgetStatePropertyAll(0),
                  hintText: 'Cari stasiun keberangkatan',
                  hintStyle: WidgetStatePropertyAll(
                    TextStyle(color: Colors.grey.shade400),
                  ),
                  leading: const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Icon(
                      Icons.search,
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: 20,
                (context, index) {
                  return ExpansionTile(
                    iconColor: Colors.grey.shade900,
                    shape: const Border(),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Stasiun',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        Text(
                          'Bekasi $index',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Text('data'),
                      Text('data'),
                      Text('data'),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
        // appBar: AppBar(
        // backgroundColor: Colors.white,
        // title: Row(
        //   children: [
        //     SvgPicture.asset(
        //       'assets/icons/ic_comuline_logo.svg',
        //       width: 26,
        //       colorFilter: ColorFilter.mode(
        //         Colors.grey.shade400,
        //         BlendMode.srcIn,
        //       ),
        //     ),
        //     const SizedBox(width: 6),
        //     Text(
        //       'Comuline',
        //       style: TextStyle(
        //         fontFamily: 'GeistMono',
        //         color: Colors.grey.shade400,
        //         fontSize: 18,
        //       ),
        //     ),
        //   ],
        // ),
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.dark_mode_outlined,
        //       color: Colors.grey.shade600,
        //     ),
        //   ),
        //   // IconButton(
        //   //   onPressed: () {},
        //   //   icon: Icon(
        //   //     Icons.search,
        //   //     color: Colors.grey.shade600,
        //   //   ),
        //   // ),
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.swap_vert,
        //       color: Colors.grey.shade600,
        //     ),
        //   ),
        // ],
        // ),
        floatingActionButton: FloatingActionButton.small(
          onPressed: () {
            // TODO
          },
          foregroundColor: Colors.grey.shade600,
          backgroundColor: Colors.grey.shade600,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        // body: ListView.separated(
        //   separatorBuilder: (context, index) {
        //     return Padding(
        //       padding: const EdgeInsets.symmetric(
        //         horizontal: 16,
        //         vertical: 12,
        //       ),
        //       child: Container(
        //         height: 1,
        //         color: Colors.grey.shade300,
        //       ),
        //     );
        //   },
        //   itemCount: 2, // Ensure this is greater than zero
        //   itemBuilder: (context, index) {
        //     return ExpansionTile(
        //       iconColor: Colors.grey.shade900,
        //       shape: const Border(),
        //       title: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             'Stasiun',
        //             style: TextStyle(
        //               fontSize: 12,
        //               color: Colors.grey.shade700,
        //             ),
        //           ),
        //           Text(
        //             'Bekasi $index',
        //             style: const TextStyle(
        //               fontSize: 20,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //         ],
        //       ),
        //       children: [
        //         Text('data'),
        //         Text('data'),
        //         Text('data'),
        //       ],
        //     );
        //   },
        // ),
        // // body: Center(
        //   child: ListView.builder(
        //     itemBuilder: (context, index) {
        //       Text(
        //         'Title $index',
        //         style: TextStyle(
        //           color: Colors.black,
        //         ),
        //       );
        //       // // TODO
        // ExpansionTile(
        //   title: Text('Title $index'),
        //   children: [
        //     Text('data'),
        //     Text('data'),
        //     Text('data'),
        //   ],
        // );
        //     },
        //     itemCount: 10,
        //   ),
        // ),
      ),
    );
  }
}
