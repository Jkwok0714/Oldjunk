
import java.awt.*;
import javax.swing.*;
import java.awt.event.*;

class AddingMachine {
   public static void main(String[] args) {
      MachineState myState = new MachineState();

      JFrame frame = new JFrame("AddingMachine");
      frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

      Container pane = frame.getContentPane();
      Font bigger = pane.getFont().deriveFont((float)40);

      JPanel displayPanel = new JPanel();
      JPanel buttonPanel = new JPanel();
      pane.setLayout(new BorderLayout());
      pane.add(displayPanel, BorderLayout.NORTH);
      pane.add(buttonPanel, BorderLayout.SOUTH);

      JLabel display = new JLabel("0");
      display.setFont(bigger);
      displayPanel.add(display);

      JButton button0 = new JButton("0");
      button0.setFont(bigger);
      JButton button1 = new JButton("1");
      button1.setFont(bigger);
      JButton button2 = new JButton("2");
      button2.setFont(bigger);
      JButton button3 = new JButton("3");
      button3.setFont(bigger);
      JButton button4 = new JButton("4");
      button4.setFont(bigger);
      JButton button5 = new JButton("5");
      button5.setFont(bigger);
      JButton button6 = new JButton("6");
      button6.setFont(bigger);
      JButton button7 = new JButton("7");
      button7.setFont(bigger);
      JButton button8 = new JButton("8");
      button8.setFont(bigger);
      JButton button9 = new JButton("9");
      button9.setFont(bigger);
      JButton buttonClear = new JButton("C");
      buttonClear.setFont(bigger);
      JButton buttonPlus = new JButton("+");
      buttonPlus.setFont(bigger);
      JButton buttonEquals = new JButton("=");
      buttonEquals.setFont(bigger);

      buttonPanel.setLayout(new GridLayout(5, 3));
      buttonPanel.add(button7);
      buttonPanel.add(button8);     
      buttonPanel.add(button9);     
      buttonPanel.add(button4);     
      buttonPanel.add(button5);     
      buttonPanel.add(button6);     
      buttonPanel.add(button1);     
      buttonPanel.add(button2);     
      buttonPanel.add(button3);     
      buttonPanel.add(button0);     
      buttonPanel.add(buttonPlus);     
      buttonPanel.add(buttonEquals);     
      buttonPanel.add(buttonClear);     

      NumberButtonListener listener0 = new NumberButtonListener(myState, display, 0);
      button0.addActionListener(listener0);
      NumberButtonListener listener1 = new NumberButtonListener(myState, display, 1);
      button1.addActionListener(listener1);
      NumberButtonListener listener2 = new NumberButtonListener(myState, display, 2);
      button2.addActionListener(listener2);
      NumberButtonListener listener3 = new NumberButtonListener(myState, display, 3);
      button3.addActionListener(listener3);
      NumberButtonListener listener4 = new NumberButtonListener(myState, display, 4);
      button4.addActionListener(listener4);
      NumberButtonListener listener5 = new NumberButtonListener(myState, display, 5);
      button5.addActionListener(listener5);
      NumberButtonListener listener6 = new NumberButtonListener(myState, display, 6);
      button6.addActionListener(listener6);
      NumberButtonListener listener7 = new NumberButtonListener(myState, display, 7);
      button7.addActionListener(listener7);
      NumberButtonListener listener8 = new NumberButtonListener(myState, display, 8);
      button8.addActionListener(listener8);
      NumberButtonListener listener9 = new NumberButtonListener(myState, display, 9);
      button9.addActionListener(listener9);

      PlusButtonListener listenerPlus = new PlusButtonListener(myState, display);
      buttonPlus.addActionListener(listenerPlus);

      EqualsButtonListener listenerEquals = new EqualsButtonListener(myState, display);
      buttonEquals.addActionListener(listenerEquals);

      ClearButtonListener listenerClear = new ClearButtonListener(myState, display);
      buttonClear.addActionListener(listenerClear);

      frame.pack();
      frame.setVisible(true);
   }  // end of main()

}  // end of class AddingMachine

class MachineState {
   int register = 0;
   int display = 0;
}  // end of class MachineState

class NumberButtonListener implements ActionListener {
   MachineState state;
   int keyValue;
   JLabel display;

   // constructor
   NumberButtonListener(MachineState myState, JLabel display, int keyValue) { 
      this.state = myState;
      this.display = display;
      this.keyValue = keyValue;
   }  

   public void actionPerformed(ActionEvent e) {
      state.display = state.display * 10 + keyValue;
      display.setText(String.valueOf(state.display));
   }

}  // end of class NumberButtonListener

class PlusButtonListener implements ActionListener {
   MachineState state;
   JLabel display;

   // constructor
   PlusButtonListener(MachineState myState, JLabel display) {
      this.state = myState;
      this.display = display;
   }

   public void actionPerformed(ActionEvent e) {
      state.register = state.display;
      state.display = 0;
      display.setText(String.valueOf(state.display));
   }

}  // end of class PlusButtonListener

class EqualsButtonListener implements ActionListener {
   MachineState state;
   JLabel display;

   // constructor
   EqualsButtonListener(MachineState myState, JLabel display) {
      this.state = myState;
      this.display = display;
   }

   public void actionPerformed(ActionEvent e) {
      state.display = state.display + state.register;
      display.setText(String.valueOf(state.display));
   }

}  // end of class EqualsButtonListener


class ClearButtonListener implements ActionListener {
   MachineState state;
   JLabel display;

   // constructor
   ClearButtonListener(MachineState myState, JLabel display) {
      this.state = myState;
      this.display = display;
   }

   public void actionPerformed(ActionEvent e) {
      state.register = 0;
      state.display = 0;
      display.setText(String.valueOf(state.display));
   }

}  // end of class ClearButtonListener
