public class SimpleWorld {
  private float scale;
  private int gridWidth;
  private int gridHeight;
  private Cell[][] grid;


  public SimpleWorld(float scale, int gridWidth, int gridHeight) {
    //println("width: " + gridWidth);
    //println("height: " + gridHeight);
    this.scale = scale;
    this.gridWidth = gridWidth;
    this.gridHeight = gridHeight;
    this.grid = new Cell[gridWidth][gridHeight];
  }

  public void step() {
    //println((int)((gridWidth*gridHeight)/15));
    int loop = (int)(1*(gridWidth*gridHeight)/1);
    if(loop ==0) loop=1;
    while (loop >0) {
      int xr =(int) random(gridWidth);
      int yr =(int) random(gridHeight);
      if (grid[xr][yr] != null) {
        grid[xr][yr].step(this, xr, yr);
      }
      loop--;
    }
  }

  public int getGridWidth() {
    return gridWidth;
  }

  public int getGridHeight() {
    return gridHeight;
  }

  public Cell getCell(int x, int y) {
    if (!exists(x, y)) {
      return null;
    }
    return  grid[x][y];
  }

  public boolean exists(int x, int y) {
    if ((x>=0 && x< gridWidth)&&(y>=0 && y< gridHeight)) {
      return true;
    } else {
      return false;
    }
  }

  public Cell clearCell(int x, int y) {
    if (!exists(x, y)) {
      return null;
    }
    Cell temp = grid[x][y];
    grid[x][y] = null;
    return temp;
  }

  public void setCell(int x, int y, Cell c) {
    if (!exists(x, y)) {
      println("error in setcell");
      return;
    }
    grid[x][y] = c;
  }

  public void render() {
    for (int i = 0; i<gridWidth; i++) {
      for (int j = 0; j < gridHeight; j++) {
        if (grid[i][j] != null) {
          grid[i][j].render(i, j, scale);
        }
      }
    }
  }
}
