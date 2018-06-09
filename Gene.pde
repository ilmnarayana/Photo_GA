class Gene {
  Triangle[] tris;
  int len=100;
  PGraphics pg;
  float score;

  Gene() {
    tris=new Triangle[len];
    for (int i=0; i<len; ++i) {
      tris[i]=new Triangle();
    }
    pg=createGraphics(imgWidth, imgHeight);
  }

  int getPixInd(int x, int y) {
    return (y*imgWidth)+x;
  }

  float colDist(color x, color y) {
    return dist(red(x), green(x), blue(x), red(y), green(y), blue(y))/255;
  }

  Gene(Triangle[] t) {
    tris=t;
    pg=createGraphics(imgWidth, imgHeight);
  }

  void createImg() {
    pg.beginDraw();
    pg.background(0, 0, 255);
    pg.noStroke();
    for (int i=0; i<len; ++i) {
      tris[i].display(pg);
    }
    pg.endDraw();
  }

  float imgDist() {
    pg.loadPixels();
    score=0;
    for (int x=0; x<imgWidth; ++x) {
      for (int y=0; y<imgHeight; ++y) {
        score+=colDist(img.pixels[getPixInd(x, y)], pg.pixels[getPixInd(x, y)]);
      }
    }
    score=map(score, 0, sqrt(3)*imgWidth*imgHeight, 1, 0);
    return score;
  }

  void display() {
    image(pg, 300, 0);
  }
}
