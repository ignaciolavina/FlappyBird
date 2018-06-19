class Pipe{
  
  PImage pipe_img =loadImage("assets/pipe.png");
  int x;
  int y;
  
  int SPACE = 230;
  int VEL = 4;
  
  public Pipe(int x){
    this.x = x;
    y = (int) random(200, HEIGHT-200);
    println("y: " + y);
  }
  
  public void draw(){
      imageMode(CENTER);
      image(pipe_img, x, y - (pipe_img.height/2+SPACE/2));
      image(pipe_img, x, y + (pipe_img.height/2+SPACE/2));
    // rect(x, y - (WIDTH/2), 30, WIDTH/2);
     //rect(x, y + (WIDTH/2 + 100), 30, WIDTH/2); 
     update();
  }
  
  public void update(){
    x -= VEL;
    if(x < -40){
      x = WIDTH;
      y = (int) random(200, HEIGHT-200);
    }
  }

}
