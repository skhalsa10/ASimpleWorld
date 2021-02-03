public class PlantEater implements Cell {
  private final int replicateMagic = 100;//(int)(0.111111111*gw*gh);//100
  private final int deathMagic = 50;//(int)(0.027777778*gw*gh);//50
  private int hue;
  private int tillReplicate;
  private int tillDeath;
  private boolean foodFound = false;
  private boolean isFirst = false;

  public PlantEater(int hue, boolean isFirst) {
    this.isFirst = isFirst;
    this.hue = (hue%360);
    tillReplicate = replicateMagic;
    println(replicateMagic);
    tillDeath = deathMagic;
  }

  public void step(SimpleWorld world, int x, int y) {
    foodFound = false;
    //see if food is around should I randomize this?
    checkForFoodRand(x, y);
    if (foodFound) {
      isFirst = false;
      //tillDeath = (int)(0.027777778*gw*gh);
      tillDeath=deathMagic;
      if (tillReplicate ==0) {
        tillReplicate = replicateMagic;
        world.setCell(x, y, new PlantEater(hue+10, false));
      }
      return;
    }
    if (!isFirst) {
      tillDeath--;
    }
    if (tillDeath == 0) {
      world.clearCell(x, y);
      return;
    }
    moveRandom(x, y);
  }

  private void checkForFoodRand(int x, int y) {
    boolean[] allDir = new boolean[4];
    for (int i =0; i<4; i++) {
      allDir[i]=false;
    }
    int dir=-1;
    while (!(allDir[0]&&allDir[1]&&allDir[2]&&allDir[3])) {

      dir = (int)random(4);
      //north
      if (dir ==0 && !allDir[0]) {
        allDir[0] = true;
        checkForFood(x, y, x, y-1);
      }
      //east
      if (dir==1 && !allDir[1]) {
        allDir[1] = true;
        checkForFood(x, y, x+1, y);
      }
      //south
      if (dir==2 && !allDir[2]) {
        allDir[2] = true;
        checkForFood(x, y, x, y+1);
      }
      //west
      if (dir==3 && !allDir[3]) {
        allDir[3] = true;
        checkForFood(x, y, x-1, y);
      }
    }
  }

  private void moveRandom(int x, int y) {
    int direction = (int)random(4);
    if (direction == 0) {
      move(x, y, x, y-1);
    }
    if (direction == 1) {
      move(x, y, x+1, y);
    }
    if (direction == 2) {
      move(x, y, x, y+1);
    }
    if (direction == 3) {
      move(x, y, x-1, y);
    }
  }

  private void move(int x, int y, int a, int b) {
    if (world.exists(a, b) && world.getCell(a, b)==null) {
      world.setCell(a, b, world.clearCell(x, y));
    }
  }

  private void checkForFood(int x, int y, int a, int b) {
    if (!foodFound && world.exists(a, b)) {
      if (world.getCell(a, b) instanceof Plant) {
        foodFound = true;
        world.clearCell(a, b);
        world.setCell(a, b, world.clearCell(x, y));
        tillReplicate--;
      }
    }
  }

  public void render(float x, float y, float l) {
    colorMode(HSB, 360, 100, 100, 100);
    fill(hue, 100, 100);
    ellipseMode(CORNER);
    circle(x*l, y*l, scale);
  }
}
