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

public enum GameState {WELCOME, GAME};  // Different states of the game
GameState game_state = GameState.WELCOME;

Bird bird;

int score = 0;
int high_score = 0;

int max_pipes = 3;
Pipe [] pipes = new Pipe [max_pipes];
int initial_pipe_x = 600; 
  
void setup() {
  size(800,600);
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


void draw(){
  if(game_state == GameState.WELCOME){
    imageMode(CORNER);
    image(startImg, 0, 0);
    textAlign(CENTER);
    text("WELCOME!" + high_score, width/2, height/2 - 50);    
    text("High Score: " + high_score, width/2, height/2);    
    text("Press ENTER to start " + high_score, width/2, height/2 + 50);
    
  }else{
    //game_state = GAME
    
    //Background stuff and movement
    imageMode(CORNER);    
    image(bkg_img, pos_background, 0);    
    image(bkg_img, pos_background + bkg_img.width, 0);   
    pos_background -= vel_background;
    if(pos_background <= - bkg_img.width){
      pos_background = 0;
    }
    
    imageMode(CENTER);
    
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
          restart();
        }        
      }
    }//end pipes loop
    
    bird.draw();
    
    text(score, 50, 50);    
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

void keyPressed(){   
 
    if(key == ENTER){
      game_state = GameState.GAME;
    }
    
    if(key == ' '){
       bird.jump();
    }  
    if(key == 'r' || key == 'R'){
       game_state = GameState.WELCOME;
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
