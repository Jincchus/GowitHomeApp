import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Gowit',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    //2초 후 웹뷰 페이지로 이동
    Future.delayed(const Duration(seconds: 2), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const WebViewPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      // body: Center(
      //   child: Image.asset(
      //     'image/gowlogo.jpg',
      //     width: 200,
      //   ),
      // ),
    );
  }
}

class WebViewPage extends StatefulWidget{
  const WebViewPage ({Key? key}) : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage>{
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url){
            // 페이지 로딩 시작
          },
          onPageFinished: (url){
            // 페이지 로딩 완료
          },
          onWebResourceError: (error){
            // 에러 발생 시
            print('WebView error: ${error.description}');
          },
        ),
      )
    ..loadRequest(Uri.parse('https://gowit.co.kr'));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: WebViewWidget(controller: controller)),
    );
  }
}