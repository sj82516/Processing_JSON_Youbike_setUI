public class InfoPanel{
  //面板與文字參數
  private final static int PANEL_SIZE = 250;
  private final static color PANEL_COLOR = #00A4E8;
  private final static color TEXT_COLOR = #000000;
  //按鈕對應不同狀態的顏色參數
  private final static color G_DEFAULT = #09DB3B;
  private final static color G_FOCUS = #A9F1BA;
  private final static color G_CLICK = #057B21;
  private final static color O_DEFAULT = #FA9005;
  private final static color O_FOCUS = #F9D099;
  private final static color O_CLICK = #9E5C04;
  private final static color R_DEFAULT = #FA3403;
  private final static color R_FOCUS = #F9B2A0;
  private final static color R_CLICK = #922105;
  //按鈕參數
  private final static int BTN_SIZE = 50;
  private final static int X_G_BTN = 25;
  private final static int X_O_BTN = 100;
  private final static int X_R_BTN = 175;
  private final static int Y_BTN = 170;
  
  private String sna,tot,sbi;
  private boolean gBtnStat,oBtnStat,rBtnStat,pressStat;
  private color gBtnColor,oBtnColor,rBtnColor;
  
  public InfoPanel(){
    sna = "Welcome";
    tot = "";
    sbi = "";
    gBtnStat = false;
    oBtnStat = false;
    rBtnStat = false;
    gBtnColor = G_DEFAULT;
    oBtnColor = O_DEFAULT;
    rBtnColor = R_DEFAULT;
  } 
  //畫面板與文字
  public void drawPanel(){
    fill(PANEL_COLOR);
    rect(0,0,PANEL_SIZE,PANEL_SIZE);
    noStroke();
    fill(TEXT_COLOR);
    text("站名:",15,30);
    text("全部車數:",15,70);
    text("剩餘車數:",15,110);
    text("顯示特定顏色:",15,150);
    text(sna,80,30);
    text(tot,125,70);
    text(sbi,125,110);
    drawBtn();
  }
  //畫按鈕
  public void drawBtn(){
    fill(gBtnColor);
    rect(X_G_BTN,Y_BTN,BTN_SIZE,BTN_SIZE);
    fill(oBtnColor);
    rect(X_O_BTN,Y_BTN,BTN_SIZE,BTN_SIZE);
    fill(rBtnColor);
    rect(X_R_BTN,Y_BTN,BTN_SIZE,BTN_SIZE);
  }
  //判斷按鈕顏色
  public void setBtnColor(int X,int Y){
    //Green
    //如果滑鼠出現在綠色按鈕的範圍內,此時要做以下判斷
    if(X>X_G_BTN && X<(X_G_BTN+BTN_SIZE) && Y>Y_BTN && Y<(Y_BTN+BTN_SIZE)){
      //按鈕被選擇了,滑鼠按下按鈕,表示使用者取消勾選
      if(gBtnStat==true && pressStat==true){
        gBtnStat = false;
        gBtnColor = G_FOCUS;
        pressStat = false;
      }
      //項目有被勾選,使用者不想取消
      else if(gBtnStat==true && pressStat==false){
        gBtnStat = true;
        gBtnColor = G_FOCUS;
      }
      //表示使用者想要勾選原本沒勾選的選項
      else if(gBtnStat==false && pressStat==true){
        gBtnStat = true;
        gBtnColor = G_CLICK;
        pressStat = false;
      }
      //原本使用者沒勾選也不想勾選選項
      else{
        gBtnStat = false;
        gBtnColor = G_FOCUS;
      }
    }
    //滑鼠位置不在按鈕上
    else{
      if(gBtnStat==true){
        gBtnColor = G_CLICK;
      }else{
        gBtnColor = G_DEFAULT;
      }
    }
    //Orange
    if(X>X_O_BTN && X<(X_O_BTN+BTN_SIZE) && Y>Y_BTN && Y<(Y_BTN+BTN_SIZE)){
      if(oBtnStat==true && pressStat==true){
        oBtnStat = false;
        oBtnColor = O_FOCUS;
        pressStat = false;
      }else if(oBtnStat==true && pressStat==false){
        oBtnStat = true;
        oBtnColor = O_FOCUS;
      }else if(oBtnStat==false && pressStat==true){
        oBtnStat = true;
        oBtnColor = O_CLICK;
        pressStat = false;
      }else{
        oBtnStat = false;
        oBtnColor = O_FOCUS;
      }
    }else{
      if(oBtnStat==true){
        oBtnColor = O_CLICK;
      }else{
        oBtnColor = O_DEFAULT;
      }
    }
    //RED
    if(X>X_R_BTN && X<(X_R_BTN+BTN_SIZE) && Y>Y_BTN && Y<(Y_BTN+BTN_SIZE)){
      if(rBtnStat==true && pressStat==true){
        rBtnStat = false;
        rBtnColor = R_FOCUS;
        pressStat = false;
      }else if(rBtnStat==true && pressStat==false){
        rBtnStat = true;
        rBtnColor = R_FOCUS;
      }else if(rBtnStat==false && pressStat==true){
        rBtnStat = true;
        rBtnColor = R_CLICK;
        pressStat = false;
      }else{
        rBtnStat = false;
        rBtnColor = R_FOCUS;
      }
    }else{
      if(rBtnStat==true){
        rBtnColor = R_CLICK;
      }else{
        rBtnColor = R_DEFAULT;
      }
    }
  }
  //debounce用
  public void setPressed(boolean b){
    pressStat = b;
  }
}
