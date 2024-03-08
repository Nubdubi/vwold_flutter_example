import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VworldMapFlutter(),
    );
  }
}

class VworldMapFlutter extends StatefulWidget {
  const VworldMapFlutter({super.key});

  @override
  State<VworldMapFlutter> createState() => _VworldMapFlutterState();
}

class _VworldMapFlutterState extends State<VworldMapFlutter> {
  // late String fileText;
  WebViewController webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);

  String kLocalExamplePage = '''
<!DOCTYPE html>
<html lang="en">
<script type="text/javascript" src="https://map.vworld.kr/js/vworldMapInit.js.do?version=2.0&apiKey=A69-3C09-A28F-37613BC53FED"></script>
<head>

<script>vw.MapControllerOption = {
   container : "vmap",
   mapMode : "2d-map",
   basemapType : vw.ol3.BasemapType.GRAPHIC,
   controlDensity : vw.ol3.DensityType.EMPTY,
   interactionDensity : vw.ol3.DensityType.BASIC,
   controlsAutoArrange : true,
   homePosition : vw.ol3.CameraPosition,
   initPosition : vw.ol3.CameraPosition,
  };
   
  mapController = new vw.MapController(vw.MapControllerOption);</script>
</head>
<body>
 <div id="vmap" style="width:100%;height:100%;left:0px;top:0px"></div>
  <select id="setMode" onchange="mapController.setMode(this.value)">
   <option value="2d-map">2d-map</option>
   <option value="3d-map">3d-map</option>
 </select>
 
''';

  final end = '''<script type="text/javascript">
  vw.MapControllerOption = {
   container : "vmap",
   mapMode : "2d-map",
   basemapType : vw.ol3.BasemapType.GRAPHIC,
   controlDensity : vw.ol3.DensityType.EMPTY,
   interactionDensity : vw.ol3.DensityType.BASIC,
   controlsAutoArrange : true,
   homePosition : vw.ol3.CameraPosition,
   initPosition : vw.ol3.CameraPosition,
  };
  
  mapController = new vw.MapController(vw.MapControllerOption);
  
 </script>

</body>
</html>''';

  @override
  void initState() {
    super.initState();
    // loadHtmlFile();
    _onLoadHtmlStringExample();
  }

  Future<void> _onLoadHtmlStringExample() {
    return webViewController.loadHtmlString(kLocalExamplePage + end);
  }
  // Future<void> loadHtmlFile() async {
  //   fileText = await rootBundle.loadString('assets/vworld_map.html');
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    final apiKey = '여기에_인증키를_입력하세요';
    // final modifiedFileText = fileText.replaceAll('{API_KEY}', apiKey);

    return Scaffold(
        appBar: AppBar(
          title: Text('VWorld Map Example'),
        ),
        body: WebViewWidget(
          controller: webViewController,
        ));
  }
}
