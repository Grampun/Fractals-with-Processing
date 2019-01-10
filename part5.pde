import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

PeasyCam cam;
String state = "F"; //state of the current L-System (initial state)
String ruleF = "H-[F]-H"; //rule F
String ruleH = "F-[H]+F"; //rule H
float ang = PI/3; //the angle at which the next line will be drawn
float ang2 = map(mouseX,0,width,0,PI/2); //used to generate the second type of angle within the sketch
float d  = 50; //the dize of the line
int r = (int)random(255); //generates a random value for red within rgb
int g = (int)random(255); //generates a random value for green within rgb
int b = (int)random(255); //generates a random value for blue within rgb
int saveID = 0; //used for iterating each name, a naming convention used to avoid over-writing
  
  //canvas set to 800x800 pixels
  void setup(){
    size(800,800);
    // cam = new PeasyCam(this, 400);
   
    menu();
  }

   void draw(){
    background(-r,-g,-b); //background is set to -ve values of rgb in order to always have contrast between the sketch 
                          //and the background
    stroke(r,g,b);  //sets the stroke colour to the random rgb values generated
    translate (width/2,height/2); //will set the line at the centre of the screen
    turtle(state); //the turtle method will be given the current value of the state

    //translate (0,0); //will set the line at the beginning of the previous line
    //turtle(state);  //the turtle method will be given the current value of the state
    
      if(key == ' ' || key == ENTER){
       state = substitute(state);//when the spacebar or ENTER-key are pressed, the state will be updated by the
                                // substitute method eventually producing the new rule upon pressing any respective key once       
       //saveFrame("sketchSequence"+saveID+".jpg"); was used to save each step of the sketch animation for pdf submission
       //saveID++; was used to increment the name of each file, to avoid over-writing
       
        }else if(key == 's' || key == 'S'){
           saveFrame("savedSketch.jpg"); //saves the current frame of the sketch
         }
    
   delay(500); //delays each movement of the sketch by 1000 milliseconds
    

 }

String substitute(String s){
  
  String result = "";  //result is empty, it will be incremented and returned as the new rule to be drawn

      for (int i =0; i<s.length();i++) //will go to the given rule and will iterate through all of it
      {
          char c = s.charAt(i); 
          switch(c)
          {
              case 'F': result += ruleF; break; //if the current position of the rule string is F, rule F will be added to it
              case 'H': result += ruleH; break; //if the current position of the rule string is H, rule H will be added to it
              default : result += c; // result is incremented by the added rules collectively
          }
      }
      
      return result; //result is returned
}  

//the turtle method will go through the entire rule string and will draw specific things depending on the current
//rule character it is on
void turtle(String s){
    for(int i=0; i<s.length(); i++)
    { 
        char c = s.charAt(i);
        switch(c)
        {
            case 'H': //goes to rule F
            case 'F': //draws a line
                  rect(0,0,d,0);
                  translate(d,0);
                  break;
            case '-': //rotates the current position for the next line to be drawn by ang2's value
                  rotate(ang2);
                  break; 
            case '+': //rotates the current position for the next line to be drawn by -ang value
                  rotate(-ang);
                  break;   
            case '[': //saves current position
                  pushMatrix();
                  break;
            case ']': //goes to last saved position
                  popMatrix();
                  break;
        }
    }
}

 void keyPressed(){   
  
  if(key == 'e' || key == 'E'){ //if e or E is pressed, the sketch will exit
     exit();   
  }else if(key == 'r' || key == 'R'){ //if r or R is pressed:
      clear(); // the sketch will clear
      state = "F"; //the state will return the its natural, initial position
      r = (int)random(255); //the r value is reset to another generated position
      g = (int)random(255); //the g value is reset to another generated position
      b = (int)random(255); //the b value is reset to another generated position
  }
  
 }
  void menu(){
    
    System.out.println("Press ENTER or The SPACE-BAR: To Start The Animation");
    System.out.println("Press S: To Save");
    System.out.println("Press R: To Reset");
    System.out.println("Press E: To Exit");
    
  }
  