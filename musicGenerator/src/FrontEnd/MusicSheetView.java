package FrontEnd;

import javax.swing.*;
import javax.swing.table.*;
import java.awt.*;

public class MusicSheetView extends JPanel {
    private GridBagLayout layout;
    private final int defaultRowNumber = 10;
    private final int defaultColNumber = 10;

    private JScrollPane tableView;
    public MusicSheetView() {
        super(new BorderLayout());
        JTable table = new JTable(new TableModel());
        for (int i = 0; i < defaultColNumber; i++) {
            TableColumn col = table.getColumnModel().getColumn(i);
            col.setCellEditor(new SelectAllTableCellEditor());
        }
        tableView = new JScrollPane(table);

        table.setFillsViewportHeight(true);
        TableColumn column = null;
        for (int i = 0; i < 10; i++) {
            column = table.getColumnModel().getColumn(i);
            column.setPreferredWidth(50);
        }
        add(tableView, BorderLayout.CENTER);
    }


    private void setUpLayout(){
        layout = new GridBagLayout();

    }

    private class SelectAllTableCellEditor extends AbstractCellEditor implements TableCellEditor {

        JTextField component = new JTextField();

        public Component getTableCellEditorComponent(JTable table, Object value, boolean isSelected,
                                                     int rowIndex, int vColIndex) {

            component.setText((String) value);
            component.selectAll();
            return component;
        }

        public Object getCellEditorValue() {
            return ((JTextField) component).getText();
        }
    }

    private static void createAndShowGUI() {
        //Create and set up the window.
        JFrame frame = new JFrame("HelloWorldSwing");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        //Add the ubiquitous "Hello World" label.
        MusicSheetView label = new MusicSheetView();
        frame.getContentPane().add(label);
        frame.setMinimumSize(new Dimension(460,200));
        frame.setPreferredSize(new Dimension(1010,510));
        //Display the window.
        frame.pack();
        frame.setVisible(true);
    }
    private class TableModel extends AbstractTableModel{
        private String[] columnNames = new String[defaultColNumber];
        private String[][] data = new String[defaultRowNumber][defaultColNumber];


        public TableModel(){
            super();
            for (int row = 0; row < 10; row++) {
                for (int col = 0; col < 10; col++) {
                    int index = 1 + col/2 + row/2 * 5;
                    if (row % 2 == 0) {
                        if (col % 2 == 0) {
                            data[row][col] = "B." + index;
                        } else {
                            data[row][col] = "N." + index;
                        }
                    } else {
                        data[row][col] = "";
                    }
                }
            }
            for (int i = 0; i < 10; i++) {
                if (i % 2 == 0) {
                    columnNames[i] = "Beat";
                } else {
                    columnNames[i] = "Note";
                }
            }
        }
        public int getRowCount() {
            return data.length;
        }

        public int getColumnCount() {
            return columnNames.length;
        }

        public Object getValueAt(int rowIndex, int columnIndex) {
            if (data[rowIndex][columnIndex] == null) {
                return (Object)"Illegal input";
            }
            return data[rowIndex][columnIndex];
        }

        public boolean isCellEditable(int row, int col) {
            //Note that the data/cell address is constant,
            //no matter where the cell appears onscreen.
            if (row % 2 == 1) {
                return true;
            } else {
                return false;
            }
        }
        public void setValueAt(Object value, int row, int col) {
            String new_val = "";
            if (value instanceof String ) {
                if (row % 2 == 1) {
                    if (col % 2 == 0) {
                        int val = 0;
                        try {
                            val = Integer.parseInt((String) value);
                            if (val >= 1 && val <= 6) {
                                new_val = Integer.toString(val);
                            }
                        }
                        catch (NumberFormatException e)
                        {
//                            new_val = null ;
                        }

                    } else {
                        if (((String) value).length() == 1) {
                            char temp = ((String) value).charAt(0);
                            int asciiTemp = (int) temp;
                            if (asciiTemp >= 97 && asciiTemp <= 121) {
                                new_val = (String)value;
                            }
                        } else {

//                            new_val = null;
                        }
                    }
                }
                data[row][col] = new_val;
                fireTableCellUpdated(row, col);
            }

        }
        public String getColumnName(int column) {
            return columnNames[column];
        }

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
