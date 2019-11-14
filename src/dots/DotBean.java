package dots;

import java.io.Serializable;
import java.util.ArrayList;

public class DotBean implements Serializable {
    private ArrayList<Dot> dotArray;

    public DotBean() {
        this.dotArray = new ArrayList<>();
    }

    public ArrayList getDotArray() {
        return this.dotArray;
    }

    public void setDotArray(ArrayList<Dot> dotArray) {
        this.dotArray = dotArray;
    }

    public void addDot(float x, float y, float r, boolean hit) {
        this.dotArray.add(new Dot(x, y, r, hit));
        while (this.dotArray.size() > 5) {
            this.dotArray.remove(0);
        }
    }

    public Dot getDot(int number) {
        return this.dotArray.get(number);
    }

    public void clearDotArray() {
        this.dotArray.clear();
    }

    public float getDotX(int number) {
        return this.dotArray.get(number).getX();
    }

    public float getDotY(int number) {
        return this.dotArray.get(number).getY();
    }

    public float getDotR(int number) {
        return this.dotArray.get(number).getR();
    }

    public boolean getDotHit(int number) {
        return this.dotArray.get(number).getHit();
    }

    public void setDotHit(int number, boolean hit) {
        this.getDot(number).setHit(hit);
    }
}
