
/**
*  This is a plant cell it take totalSteps before it expands
*  After it expands it no longer grows anymore.
*
**/
public class Plant implements Cell{//expand north
  private final int maxSteps = 25;
  //the plant should grows and expand proportionally to how the plant eater replicates and dies.
  //private final int maxSteps = (int)(.1*(0.111111111*gw*gh));
    
  private boolean isExpanded;
  private int steps;
  private int hue;
  
  Plant(int hue){
    //println(maxSteps);
    isExpanded = false;
    steps = 1;
    this.hue = (hue%360);
  }
  
  public void step(SimpleWorld world, int x, int y){
    if(isExpanded){
      return;
      //expand(world, x, y);
    }
    steps++;
    if(steps == maxSteps){
      isExpanded = true;
      expand(world, x, y);
    }
    
  }
  
  private void expand(SimpleWorld world, int x, int y){
    //expand north
    if(world.exists(x,y-1)&&(world.getCell(x,y-1) == null)){
     world.setCell(x,y-1,new Plant(hue++)); 
    }
    //expand east
    if(world.exists(x+1,y)&&(world.getCell(x+1,y) == null)){
     world.setCell(x+1,y,new Plant(hue++)); 
    }
    //expand south
    if(world.exists(x,y+1)&&(world.getCell(x,y+1) == null)){
     world.setCell(x,y+1,new Plant(hue++)); 
    }
    //expand west
    if(world.exists(x-1,y)&&(world.getCell(x-1,y) == null)){
     world.setCell(x-1,y,new Plant(hue++)); 
    }
    
  }
  
  //shrink a rectangle proportionally to the steps
  public void render(float x, float y, float l){
    //print((float)(steps/maxSteps));
    colorMode(HSB,360,100,100,100);
    noStroke();
    fill(hue,100,40);
    if(!isExpanded){
      rectMode(CENTER);
      rect((x*scale)+(l/2),(y*scale)+(l/2),l*(steps/(float)maxSteps),l*(steps/(float)maxSteps));
    }else{
      rectMode(CORNER);
      rect(x*scale,y*scale,l,l);
    }
  }

}
