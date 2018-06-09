class Triangle {
  PVector a, b, c;
  color col;

  Triangle() {
    a=new PVector(random(imgWidth), random(imgHeight));
    b=new PVector(random(imgWidth), random(imgHeight));
    c=new PVector(random(imgWidth), random(imgHeight));
    col=color(random(255), random(255), random(255));
  }

  void tremble() {
    PVector r=PVector.random2D();
    r.mult(3);
    a.add(r);
    r=PVector.random2D();
    r.mult(3);
    b.add(r);
    r=PVector.random2D();
    r.mult(3);
    c.add(r);
    float re, g, b;
    if (random(1)<0.3) re=red(col)+random(3);
    else re=red(col);
    if (random(1)<0.3) g=green(col)+random(3);
    else g=green(col);
    if (random(1)<0.3) b=blue(col)+random(3);
    else b=blue(col);
    col=color(re, g, b);
  }

  void display(PGraphics pg) {
    pg.fill(col, 100);
    pg.triangle(a.x, a.y, b.x, b.y, c.x, c.y);
  }
}
