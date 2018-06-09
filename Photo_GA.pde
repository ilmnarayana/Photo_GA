PImage img;
int imgWidth=300;
int imgHeight=360;
Generation gen;

void setup() {
  size(900, 450); //size should be size(3*imgWidth,imgHeight+90);
  img=loadImage("Photo.jpg");
  gen=new Generation(600);
}

void draw() {
  background(0, 0, 255);
  image(img, 0, 0);
  gen.run();
  if (gen.isCompleted()) {
    println(gen.score);
    Generation children=reproduce();
    children.gen=gen.gen+1;
    children.score=gen.score;
    children.best=gen.best;
    gen=children;
    //noLoop();
  }
}

Gene getGene(float sum) {
  float r=random(sum);
  int i=0;
  while (i<gen.poplen && r>=0) {
    r-=gen.g.get(i).score;
    i++;
  }
  return gen.g.get(i-1);
}

Generation reproduce() {
  Generation children=new Generation(0);
  float sum=0;
  for (Gene gene : gen.g) {
    sum+=gene.score;
  }
  for (int i=0; i<250; ++i) {
    Gene parentA=getGene(sum);
    Gene parentB=getGene(sum);
    int gLen=parentA.len;
    int r1=int(random(gLen));
    int r2=int(random(gLen));
    if (r1>r2) {
      int temp=r1;
      r1=r2;
      r2=temp;
    }
    Triangle[] tA=new Triangle[gLen];
    Triangle[] tB=new Triangle[gLen];
    for (int j=0; j<gLen; ++j) {
      if (j<r1) {
        tA[j]=parentA.tris[j];
        tB[j]=parentB.tris[j];
      } else if (j>=r1 && j<=r2) {
        tA[j]=parentB.tris[j];
        tB[j]=parentA.tris[j];
      } else {
        tA[j]=parentA.tris[j];
        tB[j]=parentB.tris[j];
      }
      if (random(1)<0.1) tA[j].tremble();
      if (random(1)<0.1) tB[j].tremble();
      if (random(1)<0.05) tA[j]=new Triangle();
      if (random(1)<0.05) tB[j]=new Triangle();
    }
    children.addGene(new Gene(tA));
    children.addGene(new Gene(tB));
  }
  gen.geneSort();
  for (int i=0; i<100; ++i) {
    children.addGene(gen.g.get(i));
  }
  return children;
}
