package FrontEnd;

import javax.swing.*;
import java.awt.*;

public class ViewBuilder extends JPanel {
    static final int FPS_MIN = 0;
    static final int FPS_MAX = 30;
    static final int FPS_INIT = 15;    //initial frames per second
    private MusicSheetView musicSheetView;
    private FileListView fileListView;
    public ViewBuilder() {
        super(new BorderLayout());

        JButton addButton = new JButton("Add New File");
        Header header = new Header();
        musicSheetView = new MusicSheetView();
        JPanel leftPanel = new FileListView();
        JPanel rightPanel = Utilities.createVerticalBoxPanel();

        rightPanel.add(Utilities.createPanelForComponent(musicSheetView,"Music sheet"));
        add(header, BorderLayout.PAGE_START);
        header.setPreferredSize(new Dimension(500,35));
        leftPanel.setPreferredSize(new Dimension(200,500));
        leftPanel.setMinimumSize(new Dimension(200,500));
//        add(downloadBottom, BorderLayout.CENTER);

        JSplitPane mainPanel = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT, leftPanel, rightPanel);
        add(mainPanel, BorderLayout.CENTER);
//        setMinimumSize(new Dimension(200,200));
    }

}
