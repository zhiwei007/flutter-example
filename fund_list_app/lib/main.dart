import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fund_list_app/provider/fund_model.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'net/server_api.dart';
import 'widgets/widget_builder.dart';

// part 'fund_code.g.dart';
// part 'fund_code.g.dart';
const fund_code = 'fund_code';
void main() async {
  await Hive.initFlutter();
  await Hive.openBox<String>(fund_code);

  WidgetsApp.debugAllowBannerOverride = false;
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => FundModel()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("==========MyApp==============");
    // headerBuilder: () => WaterDropHeader(),// 配置默认头部指示器,假如你每个页面的头部指示器都一样的话,你需要设置这个
    // footerBuilder:  () => ClassicFooter(),// 配置默认底部指示器
    // headerTriggerDistance: 80.0, // 头部触发刷新的越界距离
    // springDescription:SpringDescription(stiffness: 170, damping: 16, mass: 1.9), // 自定义回弹动画,三个属性值意义请查询flutter api
    // maxOverScrollExtent :100, //头部最大可以拖动的范围,如果发生冲出视图范围区域,请设置这个属性
    // maxUnderScrollExtent:0, // 底部最大可以拖动的范围
    // enableScrollWhenRefreshCompleted: true, //这个属性不兼容PageView和TabBarView,如果你特别需要TabBarView左右滑动,你需要把它设置为true
    // enableLoadingWhenFailed : true, //在加载失败的状态下,用户仍然可以通过手势上拉来触发加载更多
    // hideFooterWhenNotFull: false, // Viewport不满一屏时,禁用上拉加载更多功能
    // enableBallisticLoad: true, // 可以通过惯性滑动触发加载更多
    return RefreshConfiguration(
        footerTriggerDistance: 15,
        dragSpeedRatio: 0.91,
        headerBuilder: () => MaterialClassicHeader(),
        footerBuilder: () => ClassicFooter(),
        enableLoadingWhenNoData: false,
        enableRefreshVibrate: false,
        enableLoadMoreVibrate: false,
        shouldFooterFollowWhenNotFull: (state) {
          // If you want load more with noMoreData state ,may be you should return false
          return false;
        },
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(primaryColor: Colors.white),
          home: MyHomePage(title: 'Fund List'),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    context.read<FundModel>().getFundList();
    // final fundModel = context.watch<FundModel>();
    print("==============MyHomePage build =============================");
    return _MyHomePageState(
      title: "title",
    );
  }
}

class _MyHomePageState extends StatelessWidget {
  final String title;

  late RefreshController _refreshController;

  _MyHomePageState({required this.title}) {
    _refreshController = RefreshController(initialRefresh: false);
  }

  void launchUrl(String code) async {
    ServerApi.launchInBrowser(code);
  }

  @override
  Widget build(BuildContext context) {
    print("==============_MyHomePageState build =============================");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fund List",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 35,
          ),
          onPressed: () {},
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20),
              child: IconButton(
                icon: Icon(Icons.search_rounded, color: Colors.lightBlueAccent),
                onPressed: () {
                  context.read<FundModel>().getFundList();
                },
              ))
        ],
        backgroundColor: Colors.white,
      ),
      body: (context.watch<FundModel>().isShowIndicator)
          ? buildProgressbar()
          : SmartRefresher(
              // header: Row(children: [
              //   Text("沪指:3450"),
              //   Text("深指:11000"),
              //   Text("创业板:3550"),
              // ]),
              controller: _refreshController,
              onRefresh: () => context.read<FundModel>().getFundList(),
              child: ListView.builder(
                itemCount: (context.watch<FundModel>().fundList.length),
                itemBuilder: (BuildContext context, int index) {
                  var item = context.watch<FundModel>().fundList[index];
                  return Dismissible(
                    key: Key(item.toString()),
                    child: InkWell(
                      splashColor: Colors.purpleAccent,
                      child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Card(
                              child: Column(children: [
                            /*代号  时间*/
                            buildRowCell(
                                context
                                    .watch<FundModel>()
                                    .fundList[index]
                                    .fundcode,
                                context
                                    .watch<FundModel>()
                                    .fundList[index]
                                    .gztime),
                            //*名称 净值估算*//*
                            buildRowCell2(
                                context.watch<FundModel>().fundList[index].name,
                                context
                                    .watch<FundModel>()
                                    .fundList[index]
                                    .gszzl)
                          ]))),
                      onTap: () {
                        //错误：： launchUrl( context .watch<FundProvider>() .fundList[index] ?.fundcode);
                        /*在组件树外使用Provider中的数据 ，必须使之停止listen 否则会抛异常 */
                        launchUrl(Provider.of<FundModel>(context, listen: false)
                            .fundList[index]
                            .fundcode);
                      },
                    ),
                    onDismissed: (DismissDirection direction) {},
                  );
                },
              ),
            ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => context.read<FundModel>().getFundList(),
      //   tooltip: 'Increment',
      //   child: Icon(Icons.refresh),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
