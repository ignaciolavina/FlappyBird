import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Flappy_Bird extends PApplet {

/* FLAPPY BIRD GAME
  please, don't be so critical with the graphs, it's just a game! ;)
  ENJOY!
  
  BY Ignacio Laviña (Uco)
*/


PImage bkg_img;
PImage startImg;

//static int WIDTH = 800;
//static int HEIGHT = 600;
static int SPACE = 230; //Space inside pipes to pass

int pos_background = 0;
int vel_background = 2;

public enum GameState {WELCOME, GAME, GAMEOVER};  // Different states of the game
GameState game_state = GameState.WELCOME;

Bird bird;

int score = 0;
int high_score = 0;

int max_pipes = 3;
Pipe [] pipes = new Pipe [max_pipes];
int initial_pipe_x = 600; 
  
public void setup() {
  
  fill(0);
  textSize(40);
  imageMode(CORNER);
  startImg=loadImage("./assets/Start_bkg.png");
  startImg.resize(width, height);
  bkg_img=loadImage("./assets/background.png");
  bkg_img.resize(width, height);
  
  bird = new Bird();
  //Pipes creation
  for (int i = 0; i<max_pipes; i++){
    pipes[i] = new Pipe(initial_pipe_x);
    initial_pipe_x += (width+40)/max_pipes;
  }
}


public void draw(){
  switch(game_state){
    case WELCOME:
      imageMode(CORNER);
      image(startImg, 0, 0);
      textSize(15);
      textAlign(CORNER);
      text("Made with love by Uco", width-200, height-50);
      
      textAlign(CENTER);
      textSize(40);
      text("WELCOME TO UKKI BIRD!", width/2, height/2 - 50);    
      text("High Score: " + high_score, width/2, height/2);    
      text("Press ENTER to start ", width/2, height/2 + 50);

    break;
    case GAME:
      //Background stuff and movement
      imageMode(CORNER);    
      image(bkg_img, pos_background, 0);    
      image(bkg_img, pos_background + bkg_img.width, 0);   
      pos_background -= vel_background;
      if(pos_background <= - bkg_img.width){
        pos_background = 0;
      }
      
      imageMode(CENTER);
      
      //Pipes iteration
      for (int i = 0; i<max_pipes; i++){
        Pipe pipe = pipes[i];
        pipe.draw();
        
        //SCORE
        if(bird.x == pipe.x){
          score++;
        }
        
        //CRASH WITH ROOF OR FLOOR
        if ((bird.y < 0) || (bird.y > width)){
          restart();
        }
        
        //CRASH WITH PIPES
        if(bird.x >=pipe.x - pipe.pipe_img.width/2 && bird.x <= pipe.x + pipe.pipe_img.width/2){
          if(abs(bird.y - pipes[i].y) > SPACE/2 - bird.birdImg.height/2){            
            bird.crash(); 
            game_state = GameState.GAMEOVER;
          }        
        }
      }//end pipes loop
      bird.draw();
      text("Score: " + score, 130, 50);
     break;
     case GAMEOVER:
      
      text("GAMEOVER", width/2, height/2 - 50);      
      text("score: " + score, width/2, height/2);
      text("Press ENTER to restart ", width/2, height/2 + 50);
     
     break;
  }
}
//works upper pipe crash
//if((bird.y <= (pipes[i].y - pipes[i].SPACE/2)) ){

public void restart(){
    println("RESET: " + bird.y);
    bird.reset();
    resetPipes();
    high_score = max(high_score, score);
    score = 0;
    game_state = GameState.WELCOME;  
}

public void resetPipes(){
  initial_pipe_x = 600;
  for (int i = 0; i<max_pipes; i++){
    pipes[i] = new Pipe(initial_pipe_x);
    initial_pipe_x += (width+40)/max_pipes;
  }
}

public void keyPressed(){   
 
    if(key == ENTER){
      
         restart(); 
      game_state = GameState.GAME;
      if(game_state == GameState.WELCOME){
         
        
      }else{
      }
    }
    
    if(key == ' '){
       bird.jump();
    }  
    if(key == 'r' || key == 'R'){
        restart();    
    }
    /* TEST CODE
    if ( key == CODED){
      switch(keyCode){
       case LEFT:
          break;
       case RIGHT:
          break;
       case UP:
       bird.y -=5;
          break;
       case DOWN:
       bird.y +=5;
          break; 
      }
    }*/
  }
class Bird{
  
   PImage birdImg;
   PImage crashed_bird_img; 
   int x, y;
   int velocity = 0;
   boolean crashed = false;
  
  public Bird(){   
      birdImg =loadImage("./assets/birdo.png");
      birdImg.resize(50,50);
      crashed_bird_img =loadImage("./assets/crashed_bird.png");
      crashed_bird_img.resize(50,50);
      x = 200;
      y = 200; 
  }
  
  public void draw(){
    if (crashed){      
      imageMode(CENTER);
      image(crashed_bird_img, x, y);
    }else{
      update();
      imageMode(CENTER);
      image(birdImg, x, y);
    }
  }
  
  public void update(){
      y += velocity;
      velocity ++;
  }
  
  public void jump(){
    velocity = -17;
  }
  
  public void crash(){
    crashed = true;  
  }
  
  public void reset(){
     crashed = false;
     this.y = 200; 
     this.velocity = 0;
  }
  
}
class Pipe{
  
  PImage pipe_img;
  int x, y;
  int VEL = 4;
  
  public Pipe(int x){
    pipe_img =loadImage("assets/pipe.png");
    this.x = x;
    y = (int) random(200, height-200);
  }
  
  public void draw(){
      imageMode(CENTER);
      image(pipe_img, x, y - (pipe_img.height/2+SPACE/2));
      image(pipe_img, x, y + (pipe_img.height/2+SPACE/2));
       update();
  }
  
  public void update(){
    x -= VEL;
    if(x < -40){
        x = width;
        y = (int) random(200, height-200);
    }
  }

}
  public void settings() {  size(800,600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#FCFEFF", "--stop-color=#EA1313", "Flappy_Bird" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
