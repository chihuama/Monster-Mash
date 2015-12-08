int numFrames = 6;
PImage[] images = new PImage[numFrames];


int img1 = 1;
int img2 = 1;
int img3 = 1;
int img4 = 1;
int img5 = 1;
int img6 = 1;

void animateSetup() {
  //particleSetup();
  //frameRate(100);
//  img1 = 1;
//  img2 = 1;
//  img3 = 1;
//  img4 = 1;
//  img5 = 1;
//  img6 = 1;
  initWordCram(1890,2012);
  images[0] = loadImage("/comic/1.gif");
  images[1] = loadImage("/comic/2.gif");  
  images[2] = loadImage("/comic/3.gif");
  images[3] = loadImage("/comic/4.gif");
  images[4] = loadImage("/comic/5.gif");
  images[5] = loadImage("/comic/6.gif");
  //background(255);
  
}

void animateDraw() {
  
//background(255);
//    if(mousePressed) {
//      if (img6 > images[5].width/3 && !showCloud) {
//      showComic = false;
//      showCloud = true;
//      background(0);
//    }
//   else if (showCloud && !showMain) {
//      println("bingg");
//      background(255);
//      showCloud = false;
//      showMain = true;
//    }
//  }
  
  
  if (showCloud) {
    //background(0);
     drawMe(1890,2012);
//     if (mousePressed) {
//       if (!showMain && showCloud) {
//         showMain = true;
//         showCloud = false;
//         background(200);
//       }
//     }
  }
  
  
  if (showComic) {
  background(255);
  //particleDraw();
  int xpos , ypos;
  xpos = 0;
  
  imageMode(CENTER);
  int x = images[0].width * scaleFactor;
  int y = images[0].height * scaleFactor;
  
    if (img1 <= x/3) {
       img1 +=4*scaleFactor;
    }
 image(images[0],x/6,y/4,img1,img1);
  xpos += x/6;
  
  
  x = images[1].width * scaleFactor;;
  y = images[1].height * scaleFactor;
  if (img1 > (int)images[0].width/3){
    if (img2 <= x/4) {
      img2 +=4 * scaleFactor;
    }
    image(images[1],xpos+x/3.5 - (40 * scaleFactor),height - y/8 + 5 * scaleFactor,img2,img2);
  }
  xpos += x/3.5 - (40 * scaleFactor);
  x = images[2].width * scaleFactor;
  y = images[2].height * scaleFactor;
  if (img2 > (int)images[1].width/4) {
    if (img3 <= x/5) {
      img3+=4 * scaleFactor;
    }
    image(images[2],xpos+x/5 - 70 * scaleFactor,y/8 + 30 * scaleFactor,img3,img3);
  }
 
  
  xpos += x/5 - 70 * scaleFactor ;
  x = images[3].width * scaleFactor;
  y = images[3].height * scaleFactor;
  if (img3 > (int)images[2].width/5) {
    if (img4 <= x/4) {
      img4 += 4 * scaleFactor;
    }
    image(images[3],xpos + x/4,height - y/6 - 10 * scaleFactor,img4,img4);
    
  } 
  
  xpos += x/4;
  x = images[4].width * scaleFactor;
  y = images[4].height * scaleFactor;
  if (img4 > (int)(images[3].width/8)) {
    if (img5 <= x/4) {
      img5+=4 * scaleFactor;
    }
      image(images[4],width-x/2 - 60 * scaleFactor,y/6 + 20 * scaleFactor,img5,img5);
   
  }
   
  x = images[5].width * scaleFactor;
  y = images[5].height * scaleFactor;
  if (img5 > images[4].height/4) {
    if (img6 <= x/3) {
      img6 += 4 * scaleFactor;
    }
    image(images[5],width-x/2 - 60 * scaleFactor,height - y/4 + 30 * scaleFactor,img6 + 20 * scaleFactor,img6 + 20 * scaleFactor);
  }
  }
  
  
  

  
}

