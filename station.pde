import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.geo.*;
import processing.core.*;
import java.util.HashMap;

public class Station extends SimplePointMarker{
  //圓點大小
  protected float SIZE = 15;
  //文字顯示間距
  protected int space = 40;
  protected String _sna;
  protected int _tot,_sbi;
  private PFont font;
  private color _stationColor;
  //各站程度顏色
  private final color GREEN = color(13,250,22);
  private final color ORANGE = color(250,177,5);
  private final color RED = color(250,4,4);
  
  private HashMap<String,Object>_properties = new HashMap();
  public Station(Location location, String sna, int tot,int sbi){
    _sna = sna;
    _tot = tot;
    _sbi = sbi;
    _stationColor = setColor(tot,sbi);
    //在HashMap中放入Key(鍵)與Value(值)
    _properties.put("sna",_sna);
    _properties.put("tot",Integer.toString(_tot));
    _properties.put("sbi",Integer.toString(_sbi));
    //properties會用String傳,先將顏色表示改成16進位比較好用
    _properties.put("color",hex(_stationColor,6));
    this.setLocation(location);
    this.setProperties(_properties);
  }
  //內建函式，定義標記格式內建函式，定義標記格式
  public void draw(PGraphics pg, float x, float y) {
    pg.pushStyle();
    pg.pushMatrix();
    //先判斷是否被隱藏
    if(!isHidden()){
      if (selected) {
        pg.translate(0, 0);
      }
      pg.strokeWeight(strokeWeight);
      if (selected) {
        pg.fill(highlightColor);
        pg.stroke(highlightStrokeColor);
      } else {
        //更改成顯示程度的顏色
        pg.fill(_stationColor);
        pg.stroke(strokeColor);
      }
      pg.ellipse(x, y, SIZE, SIZE);// TODO use radius in km and convert to px
  
      //滑鼠出現在地點上，顯示設定的標籤
      if (selected && _sna != null) {
        pg.fill(highlightColor);
        pg.stroke(highlightStrokeColor);
        pg.rect(x + strokeWeight / 2, y  + strokeWeight / 2 - space, pg.textWidth(_sna) + space * 1.5f, space);
        pg.fill(255, 255, 255);
        pg.text(_sna, Math.round(x + space * 0.75f + strokeWeight / 2),Math.round(y + strokeWeight / 2 - space * 0.4f));
      }
    }
    pg.popMatrix();
    pg.popStyle();
  }
  //分成三種程度，對應紅橘綠
  private color setColor(int _tot,int _sbi){
    float cent = (float)_sbi/_tot;
    if(cent>0.66){
      return GREEN;
    }else if(cent<0.66 && cent>0.33){
      return ORANGE;
    }else{
      return RED;
    }
  }
}
