import http.requests.*;
import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;
//include不同的map provider
import de.fhpotsdam.unfolding.providers.ThunderforestProvider;

UnfoldingMap map;
//YouBike open data網址
String url = "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=ddb80380-f1b3-4f8e-8016-7ed9cba571d5";
PFont myFont;
InfoPanel infoPanel;
//狀態顏色
final String GREEN = "0DFA16";
final String ORANGE = "FAB105";
final String RED = "FA0404";

void setup(){
  size(1000, 800);
  smooth();
  //載入中文字體
  myFont = createFont("標楷體",15);
  textFont(myFont);
  //後面的參數放置map provider不同的型態
  map = new UnfoldingMap(this, new ThunderforestProvider.Landscape());
  //地圖聚焦的經緯度以及放大程度
  map.zoomAndPanTo(new Location(25.05f, 121.55f), 13);
  MapUtils.createDefaultEventDispatcher(this, map);
  
  //第一步驟
  GetRequest get = new GetRequest(url);
  get.send();
  JSONObject response = parseJSONObject(get.getContent());
  JSONArray bikelists = response.getJSONObject("result").getJSONArray("results");
  for(int l=0;l<bikelists.size();l++){
    JSONObject bikelist = bikelists.getJSONObject(l);
    println("地點:" + bikelist.getString("sna") + "經度:" + bikelist.getString("lat") + "緯度:" + bikelist.getString("lng") + " 總車位:" +bikelist.getString("tot") + " 剩餘車位" + bikelist.getString("sbi"));
    Location _location = new Location(Float.parseFloat(bikelist.getString("lat")),Float.parseFloat(bikelist.getString("lng")));
    Station _station = new Station(_location,bikelist.getString("sna"), Integer.parseInt(bikelist.getString("tot")),Integer.parseInt(bikelist.getString("sbi")));
    //在地圖上增加標記
    map.addMarkers(_station);
  }
  
  infoPanel = new InfoPanel();
}

void draw(){
  //先顯示每個Marker
  for (Marker marker : map.getMarkers()) {
    marker.setHidden(false);
  }
  //依據按鈕狀態判斷是否隱藏Marker
  for (Marker marker : map.getMarkers()) {
    if(infoPanel.gBtnStat==true){
      if(marker.getProperty("color").toString().equals(GREEN)){
        marker.setHidden(true);
      }
    }
    if(infoPanel.oBtnStat==true){
      if(marker.getProperty("color").toString().equals(ORANGE)){
        marker.setHidden(true);
      }
    }
    if(infoPanel.rBtnStat==true){
      if(marker.getProperty("color").toString().equals(RED)){
        marker.setHidden(true);
      }
    }
  }
  map.draw();
  pushMatrix();
  translate(750,0);
  infoPanel.drawPanel();
  popMatrix();
  //座標系轉移後的調整
  infoPanel.setBtnColor(mouseX-750,mouseY);
}

void mouseMoved() {
  // Deselect all marker
  for (Marker marker : map.getMarkers()) {
    marker.setSelected(false);
  }
  // 檢查滑鼠移動位置，如果剛好移到地點上，出現設定的標籤
  Marker marker = map.getFirstHitMarker(mouseX, mouseY);
  if (marker != null) {
    //利用Key(鍵)去讀值
    infoPanel.sna = marker.getProperty("sna").toString();
    infoPanel.tot = marker.getProperty("tot").toString();
    infoPanel.sbi = marker.getProperty("sbi").toString();
    marker.setSelected(true);
  }
  infoPanel.setPressed(false);
}
//讀取Release比Pressed穩定
void mouseReleased(){
  infoPanel.setPressed(true);
}


