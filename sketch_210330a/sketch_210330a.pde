import java.util.Collections;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;


PImage head, test;
List<ImagePart> results = new ArrayList<ImagePart>();
ImagePart minorDiff;

void setup(){
  head = loadImage("C:\\Users\\cryst\\Downloads\\Caso_1.jpg");
  test = loadImage("C:\\Users\\cryst\\Downloads\\Caso_1_o.png");
  int maxY = head.height - test.height;
  int maxX = head.width - test.width;
  
  for(int y=0; y< maxY; y+=5){
    for(int x = 0; x< maxX; x+=5){
      ImagePart result = new ImagePart();
      result.x = x;
      result.y = y;
      
      PImage croppedHead = head.get(x,y, test.width, test.height);
      result.diferenca = 0d;
      
      
      for(int compareY = 0; compareY < test.height; compareY+=5){
        for(int compareX = 0; compareX < test.width; compareX+=5){
          int pixelPosition = compareX + compareY * test.width;
          int testGray = test.pixels[pixelPosition] & 0xFF;
          int headGray = croppedHead.pixels[pixelPosition] & 0xFF;
          result.diferenca += Math.abs(testGray - headGray);
        }
      }
      results.add(result);
    }
  }
  Collections.sort(results, new DiffComparator());
  minorDiff = results.get(0);
  surface.setSize(head.width, head.height);
}

void draw(){
  pushMatrix();
  image(head,0,0);
  noFill();
  strokeWeight(2);
  stroke(0,255,0);
  rect(minorDiff.x, minorDiff.y, test.width, test.height);
  popMatrix();
}

public class ImagePart{
  Double diferenca;
  int x;
  int y;
}

public class DiffComparator implements Comparator<ImagePart>{
  public int compare(ImagePart o1, ImagePart o2){
    return Double.compare(o1.diferenca,o2.diferenca);
  }
}
  


  
