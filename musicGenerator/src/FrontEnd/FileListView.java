package FrontEnd;

import javax.swing.*;
import javax.swing.text.View;
import java.awt.*;

public class FileListView extends JPanel {
    private JList list;
    private JButton addButton = new JButton("Add New File");
    public FileListView() {
        super();
        JPanel viewBuilder = Utilities.createVerticalBoxPanel();

        //List Set Up
        list = new JList( new DefaultListModel());
        list.setPreferredSize(new Dimension(200,200));
//        JScrollPane listScrollPanel = new JScrollPane();
//        listScrollPanel.add(list);
//        listScrollPanel.setMinimumSize(new Dimension(200,200));
//        listScrollPanel.setMinimumSize(new Dimension(200,200));
//        JPanel decoratedListPanel = Utilities.createPanelForComponent(listScrollPanel, "Files");
        //assemble all together
        viewBuilder.add(list);
//        viewBuilder.add(addButton);
        add(viewBuilder);
    }
}
