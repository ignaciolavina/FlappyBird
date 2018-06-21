class Bird{
  
   PImage birdImg;
   PImage crashed_bird_img; 
   int x, y;
   int velocity = 0;
  
  public Bird(){   
      birdImg =loadImage("./assets/birdo.png");
      birdImg.resize(50,50);
      x = 200;
      y = 200; 
  }
  
  public void draw(){
      update();
      imageMode(CENTER);
      image(birdImg, x, y);
  }
  
  public void update(){
      y += velocity;
      velocity ++;
  }
  
  public void jump(){
    velocity = -17;
  }
  
  public void reset(){
     this.y = 200; 
     this.velocity = 0;
  }
  
}
