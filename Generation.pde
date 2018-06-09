class Generation {
  ArrayList<Gene> g;
  int poplen, ind, gen;
  float score=0;
  PGraphics best;

  Generation(int len) {
    gen=1;
    ind=0;
    poplen=len;
    g=new ArrayList<Gene>();
    for (int i=0; i<poplen; ++i) {
      g.add(new Gene());
    }
    textAlign(CENTER);
  }

  void geneSort() {
    for (int i=0; i<poplen; ++i) {
      int t=i;
      for (int j=i+1; j<poplen; ++j) {
        if (g.get(j).score>g.get(t).score) t=j;
      }
      if (t!=i) {
        Gene temp=g.get(i);
        g.set(i, g.get(t));
        g.set(t, temp);
      }
    }
  }

  void addGene(Gene gene) {
    g.add(gene);
    poplen++;
  }

  void run() {
    Gene gene=g.get(ind);
    gene.createImg();
    gene.display();
    img.loadPixels();
    float pScore=gene.imgDist();
    if (score<pScore) {
      score=pScore;
      best=gene.pg;
    }
    textSize(20);
    text(pScore, imgWidth*1.5, imgHeight+20);
    text(score, imgWidth*2.5, imgHeight+20);
    image(best, imgWidth*2, 0);
    ind++;
    textSize(30);
    text("Generation: "+gen, imgWidth*1.5, imgHeight+60);
  }

  boolean isCompleted() {
    return ind>=poplen;
  }
}
