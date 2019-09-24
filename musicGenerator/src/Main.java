import javax.swing.*;
import FrontEnd.*;

import java.awt.*;

public class Main {
    private static void createAndShowGUI() {
    //Create and set up the window.
        JFrame frame = new JFrame("HelloWorldSwing");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        //Add the ubiquitous "Hello World" label.
        ViewBuilder label = new ViewBuilder();
        frame.getContentPane().add(label);
        frame.setMinimumSize(new Dimension(800,400));
        frame.setPreferredSize(new Dimension(800,500));
        //Display the window.
         frame.pack();
         frame.setVisible(true);
    }

    public static void main(String[] args) {
        //Schedule a job for the event-dispatching thread:
        //creating and showing this application's GUI.
        javax.swing.SwingUtilities.invokeLater(new Runnable() {
            public void run() {
                createAndShowGUI();
            }
        });
    }


}
