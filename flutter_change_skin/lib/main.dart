import 'package:flutter/material.dart';
import 'MoiveListPage.dart';
import 'MusicListPage.dart';
import 'BookListPage.dart';
import 'SettingPage.dart';
import 'package:provide/provide.dart';
import 'provide/change_skin_provider.dart';
void main(){
  var changeSkinProvider =  ChangeSkinProvider();
  var provider = Providers() ..provide(Provider<ChangeSkinProvider>.value(changeSkinProvider));

  runApp(ProviderNode(child: MyApp(), providers: provider));
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Provide(builder: ( BuildContext context, Widget child, ChangeSkinProvider value){
       return MaterialApp(
         title: '换肤测试',
         theme: ThemeData(
           primarySwatch: Colors.blue,
         ),
         home: MainPage('换肤测试',value.getColor??Colors.blue),
       );
    });
  }
}

class MainPage extends StatefulWidget{
  String title;
  ColorSwatch _colorSwatch;
  MainPage(this.title,this._colorSwatch);
  @override
  State<StatefulWidget> createState() =>MainPageState(title,_colorSwatch);
}


class MainPageState extends State<MainPage>{
  ColorSwatch _colorSwatch;
  String title ;
  MainPageState(this.title,this._colorSwatch);
  List<Widget>   _pageList = [
    MoiveListPage(  ),
    BookListPage( ),
    MusicListPage( ),
    SettingPage( ),
     ];
  IndexedWidgetBuilder  _itemBuilder( )=>(BuildContext context,int index){
    return _pageList[index];
  };



  Color _defaultColor = Colors.black;
  List<BottomNavigationBarItem> _buildBottomBarItems(int index,ColorSwatch colorSwatch){
    List<BottomNavigationBarItem> _bottomBarItems = [
      BottomNavigationBarItem(title: Text("Moive",style: TextStyle(fontSize:20,color:(index==0?colorSwatch:_defaultColor))),icon: Icon(Icons.missed_video_call),activeIcon: Icon(Icons.missed_video_call,color: colorSwatch)),
      BottomNavigationBarItem(title: Text("Book",style: TextStyle(fontSize:20,color: (index==1?colorSwatch:_defaultColor))),icon: Icon(Icons.book),activeIcon: Icon(Icons.book,color: colorSwatch)),
      BottomNavigationBarItem(title: Text("Music",style: TextStyle(fontSize:20,color: (index==2?colorSwatch:_defaultColor))),icon: Icon(Icons.music_note),activeIcon: Icon(Icons.music_note,color: colorSwatch)),
      BottomNavigationBarItem(title: Text("Setting",style: TextStyle(fontSize:20,color: (index==3?colorSwatch:_defaultColor))),icon: Icon(Icons.settings),activeIcon: Icon(Icons.music_note,color: colorSwatch)),
    ];
    return _bottomBarItems;
  }




  int _currentIndex = 0;
  Widget  _buildBottomNavigationBar(ColorSwatch colorSwatch){
    return BottomNavigationBar(backgroundColor:Colors.white,
        unselectedItemColor:Colors.black,unselectedLabelStyle:TextStyle(color: Colors.black),
        selectedItemColor:colorSwatch,selectedLabelStyle:TextStyle(color:colorSwatch),
        type:BottomNavigationBarType.fixed,items: _buildBottomBarItems(_currentIndex,colorSwatch),currentIndex: _currentIndex,onTap: (int index){
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(index,  duration: const Duration(milliseconds: 100), curve: Curves.ease);
          });
        });
  }



  PageController  _pageController = PageController(initialPage:0);

  Widget _buildBody( ){
    return PageView.builder(itemCount:4,itemBuilder: _itemBuilder(),
        onPageChanged: (int index){
          setState(() {
            _currentIndex = index;
          });
        },
        controller:_pageController
    );
  }


  @override
  Widget build(BuildContext context) {
    print("=============main build=====================");
    // TODO: implement build
    return Provide(builder: (BuildContext context,
        Widget child,
       ChangeSkinProvider value,){
        return  Scaffold(
          body: _buildBody( ),
          bottomNavigationBar: _buildBottomNavigationBar(value.getColor),
        );
    });
  }
}
