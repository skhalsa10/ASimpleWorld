SimpleWorld world;
int scale = 15;
int gw;
int gh;
void setup(){
  //size(1200,1200);
  size(600,600);

  //place an upper bound on  the scale... this number came with trial and error
  if((float)scale/(width*height)>.0000555556){
    float f = .0000555556;
    println("scale will be: " + f);
    scale = (int)((width*height)*f);
  }
  gw = width/scale;
  gh = height/scale;
  //println("scale: "+scale);
  //println(gw);
  //println(gh);
  
  world = new SimpleWorld(scale,width/scale,height/scale);
  int ranW = (int)random((int)(width/scale));
  int ranH = (int)random((int)(height/scale));
  world.setCell(ranW, ranH, new Plant(108));
  ranW = (int)random((int)(width/scale));
  ranH = (int)random((int)(height/scale));
  //print(ranW);
  world.setCell(ranW, ranH , new PlantEater(108, true));
  
}

void draw(){
  //background(155);
  background(0);
  world.render();
  world.step();
  //println(frameRate);
}
