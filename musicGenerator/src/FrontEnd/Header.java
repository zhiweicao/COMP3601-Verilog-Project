package FrontEnd;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;

public class Header extends JPanel implements ActionListener {
    private JButton button;
    private JLabel address;
    private JLabel note;
    private JFileChooser chooser;
    private SpringLayout layout;
    private JTextArea log;

    public Header() {
        super();
        button = new JButton("Load To Board");
        note = new JLabel("Loading Progress:");
        address = new JLabel("0%");
        chooser = new JFileChooser();

        setUpLayoutDetails();
        setUpComponent();



        add(note);
        add(address);
        add(button);
    }

    private void setUpComponent () {
        note.setPreferredSize(new Dimension(120,25));

        address.setBackground(Color.white);
        address.setOpaque(true);
        address.setBorder(BorderFactory.createLoweredBevelBorder());
        address.setMinimumSize(new Dimension(300,30));
        address.setPreferredSize(new Dimension(500,25));


        button.setPreferredSize(new Dimension(120,30));
        button.addActionListener(this::actionPerformed);

    }
    private void setUpLayoutDetails() {
        layout = new SpringLayout();

        // North Distance
        layout.putConstraint(SpringLayout.NORTH, note,
                5,
                SpringLayout.NORTH, this);

        layout.putConstraint(SpringLayout.NORTH, address,
                5,
                SpringLayout.NORTH, this);
        layout.putConstraint(SpringLayout.NORTH, button,
                3,
                SpringLayout.NORTH, this);

        //Component relative distance
        layout.putConstraint(SpringLayout.WEST, note,
                5,
                SpringLayout.WEST, this);
        layout.putConstraint(SpringLayout.WEST, address,
                5,
                SpringLayout.EAST, note);
        layout.putConstraint(SpringLayout.WEST, button,
                10,
                SpringLayout.EAST, address);
        setLayout(layout);
    }
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == button) {
            int returnVal = chooser.showOpenDialog(Header.this);

            if (returnVal == JFileChooser.APPROVE_OPTION) {
                File file = chooser.getSelectedFile();
                //This is where a real application would open the file.
                address.setText(file.getAbsolutePath());
//                log.append("Opening: " + file.getName() + "." + newline);
            } else {
                address.setText("I'm waiting for a file:)");
            }
//            log.setCaretPosition(log.getDocument().getLength());
        }
    }
}
