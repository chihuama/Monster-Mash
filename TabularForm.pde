
void drawForm() {
  
  float formX1 = scaleFactor*25;
  //float formX2 = graphPlotX11 - (scaleFactor*100);
  float formY1 = (graphPlotY2+graphPlotY1)/2 + (scaleFactor*30);
  float formY2 = graphPlotY2 + (scaleFactor*50);
  
  strokeWeight(int(scaleFactor * 2));
  stroke(350);
  
  float textHeight = scaleFactor * 16;
  float yearWidth = scaleFactor * 40;
  textSize(scaleFactor * 12);
  textAlign(LEFT, TOP);
  
  line(formX1, formY1, formX1, formY1+textHeight+scaleFactor*2);
  line(formX1+(scaleFactor*80), formY1, formX1+(scaleFactor*80), formY1+textHeight+scaleFactor*2);
  
  for (int i=0; i<5; i++) {
    if (i>YearEnd) {
      break;
    }
    fill(0);
    String yearstart = ""+(i+YearMin);
    text(yearstart, formX1+(scaleFactor*85)+yearWidth*i, formY1);
    line(formX1+(scaleFactor*80)+yearWidth*(i+1), formY1, formX1+(scaleFactor*80)+yearWidth*(i+1), formY1+textHeight+scaleFactor*2);
  }

  float formX2 = formX1+(scaleFactor*80)+yearWidth*5;
  line(formX1, formY1, formX2, formY1);  
  line(formX1, formY1+(textHeight+scaleFactor*2), formX2, formY1+(textHeight+scaleFactor*2));
  
  for (int m=0; m<MonsterID; m++) {
    fill(colors[m%5]);
    textAlign(LEFT, TOP);
    text(MonsterName[m], formX1+scaleFactor*5, formY1+textHeight*(m+1));
    line(formX1, formY1+textHeight*(m+2)+scaleFactor*2, formX2, formY1+textHeight*(m+2)+scaleFactor*2);
    
    line(formX1, formY1+textHeight*(m+1), formX1, formY1+textHeight*(m+2)+scaleFactor*2);
    line(formX1+(scaleFactor*80), formY1+textHeight*(m+1), formX1+(scaleFactor*80), formY1+textHeight*(m+2)+scaleFactor*2);
    for (int i=0; i<5; i++) {
      if (i>YearEnd) {
        break;
      }
      line(formX1+(scaleFactor*80)+yearWidth*(i+1), formY1+textHeight*(m+1), formX1+(scaleFactor*80)+yearWidth*(i+1), formY1+textHeight*(m+2)+scaleFactor*2);
      textAlign(RIGHT, TOP);
      text(MonsterNum[i+(YearMin-YearStart)][graphs[m]], formX1+(scaleFactor*75)+yearWidth*(i+1), formY1+textHeight*(m+1));         
    }   
  }
}

void formSlider() {
  controlP5.addSlider("yearRange", YearStart, YearEnd, YearMin, scaleFactor*30, int(graphPlotY2 + (scaleFactor*15)), scaleFactor*150, scaleFactor*20);
  Slider formyear = (Slider)controlP5.controller("yearRange");
  //formyear.captionLabel().set(" "); 
}

public void yearRange(int theValue) {
  VotesMin = theValue;
}
