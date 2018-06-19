PImage bkg_img;
PImage startImg;

static int WIDTH = 800;
static int HEIGHT = 600;

int pos_background = 0;
int vel_background = 2;

public enum GameState {WELCOME, GAME};  // Different states of the game
GameState game_state = GameState.GAME;

Bird bird;

int score = 0;
int high_score = 0;

int max_pipes = 3;
Pipe [] pipes = new Pipe [max_pipes];
int space = 600;
  
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
  

  for (int i = 0; i<max_pipes; i++){
    pipes[i] = new Pipe(space);
    space += (width+40)/max_pipes;
  }
  
  
}


void draw(){
  if(game_state == GameState.WELCOME){
    imageMode(CORNER);
    image(startImg, 0, 0);
    textAlign(CENTER);
    text("High Score: " + high_score, width/2, height/2);    
    text("Press ENTER to start " + high_score, width/2, height/2 + 50);
    
  }else{
    //game_state = GAME
    
    //Background stuff and movement
    image(bkg_img, pos_background, 0);
    
    image(bkg_img, pos_background + bkg_img.width, 0);   
    pos_background -= vel_background;
    if(pos_background <= - bkg_img.width)
      pos_background = 0;

    
    imageMode(CENTER);
    bird.draw();
    
    for (int i = 0; i<max_pipes; i++){
      Pipe pipe = pipes[i];
      int pipe_x = pipe.x;
      int pipe_y = pipe.y;
      pipe.draw();
      
      //SCORE
      if(bird.x == pipe.x){
        score++;
      }
      
      //CRASH WITH ROOF OR FLOOR
      if ((bird.y < 0) || (bird.y > width)){
        restart();
      }
      if(bird.x >=pipe.x - pipe.pipe_img.width/2 && bird.x <= pipe.x + pipe.pipe_img.width/2){
        imageMode(CENTER);
        int diff = abs(bird.y - pipes[i].y);
        println("DIFF: " + diff);
        //println("bird.y: " + bird.y + " pipes arriba: " + (pipes[i].y - pipes[i].SPACE/2) + ", pipes abajo" + (pipes[i].y + pipes[i].SPACE/2));
        if(abs(bird.y - pipes[i].y) > pipes[i].SPACE/2 - bird.birdImg.height/2){
          print("pipes[i].y "+ (pipes[i].y  + space/2) + ",bird.y " + bird.y);
          restart();
        }
        
      }

    }
    imageMode(CORNER);    
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
  space = 600;
  for (int i = 0; i<max_pipes; i++){
    pipes[i] = new Pipe(space);
    space += (width+40)/max_pipes;

  }
}

void keyPressed(){   
 
    if(key == ENTER){
      game_state = GameState.GAME;
      //bird.reset();
      //pipe.reset();
    }    
     if(key == ' '){
       //println("jump: " + bird.y);
       bird.jump();
    }  
    if(key == 'r' || key == 'R'){
       game_state = GameState.WELCOME;
    }
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
    }
  }
