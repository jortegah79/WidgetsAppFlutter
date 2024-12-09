import 'dart:ffi';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets_app/config/router/app_router.dart';

class InfiniteScrollScreen extends StatefulWidget {
  static const String name = "infinite_scroll_screen";

  const InfiniteScrollScreen({super.key});

  @override
  State<InfiniteScrollScreen> createState() => _InfiniteScrollScreenState();
}

class _InfiniteScrollScreenState extends State<InfiniteScrollScreen> {
  List<int> imagesIds = [1, 2, 3, 4, 5];
  final ScrollController scrollController = ScrollController();
  bool isLoading = false;
  bool isMounted = true;

  void addFiveImages() {
    final lastId = imagesIds.last;
    imagesIds.addAll([1, 2, 3, 4, 5].map((elemento) => elemento + lastId));
    setState(() { });
    moveScrollToBottom();
    
    
  }

  Future loadNextPage() async {
    if (isLoading) return;

    isLoading = true;
    setState(() {});
    await Future.delayed(const Duration(seconds: 2));
    addFiveImages();
    isLoading = false;
    if (!isMounted) return;
    setState(() {});
  }

  Future<void> onRefresh() async {
    isLoading=true;
    setState(() {
      
    });
    await Future.delayed(const Duration(seconds: 3));
    if (!isMounted) return;
    isLoading = false;
    final lastId = imagesIds.last;
    imagesIds.clear();
    imagesIds.add(lastId + 1);
    addFiveImages();
    setState(() {});
   
  }

  void moveScrollToBottom(){
    if(scrollController.position.pixels + 100 <=scrollController.position.maxScrollExtent){

      scrollController.animateTo(
        scrollController.position.pixels + 120, 
        duration: const Duration(milliseconds: 300), 
        curve: Curves.fastOutSlowIn);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if ((scrollController.position.pixels + 500) >=
          scrollController.position.maxScrollExtent) {
        loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.dispose();
    isMounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: RefreshIndicator(
          edgeOffset: 10,
          strokeWidth: 2,
          color: const Color.fromARGB(255, 255, 255, 255),
          backgroundColor: Colors.black12,
          onRefresh: onRefresh,
          child: ListView.builder(
            controller: scrollController,
            itemCount: imagesIds.length,
            itemBuilder: (context, index) {
              return FadeInImage(
                  width: double.infinity,
                  fit: BoxFit.cover,
                  height: 300,
                  placeholder:
                      const AssetImage("assets/images/jar-loading.gif"),
                  image: NetworkImage(
                      "https://picsum.photos/id/${imagesIds[index]}/500/300"));
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(

          //child: const Icon(Icons.arrow_back_ios_new_outlined),
          child: isLoading
              ? FadeInUp(
                  child: const CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Color.fromARGB(255, 170, 21, 120),
                  backgroundColor: Color.fromARGB(255, 126, 207, 180),
                ))
              : FadeInRight(
                  duration: Duration(milliseconds: 500),
                  child: const Icon(Icons.arrow_back_ios_new_outlined)),
          /*child:SpinPerfect(
            child: const Icon(Icons.refresh_outlined),
            infinite: true),*/
          onPressed: () => context.pop()),
    );
  }
}
