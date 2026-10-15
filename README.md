# Robot-Arm-and-Machine-Learning-Group-8

Sketches for a Wekinator and Arduino laser-cut robot arm, physical build and osc-routing based on https://github.com/IDE-GID-Cyberphysical-Systems/de-arm. Processing camera input code based on https://github.com/IDE-GID-Cyberphysical-Systems/de-arm/tree/main/wekinator-input. Created for IDE Cyber Physical Systems robot arm assignment.

Ran on Arduino Nano Every.


**Summary**

RGB based Wekinator model that controls 3 choreographed poses on the robot arm using colour input. Poses are choreographed using 4 servos controlled by an Arduino.

Processing is used for visual input to train the ML model on Wekinator and to send OSC messages between Wekinator and the Arduino.

<img width="3508" height="1084" alt="CPS-robotarm-charts_flowchart" src="https://github.com/user-attachments/assets/e39e1f16-b4fe-4298-8f78-ebd73fb28225" />


**The Arduino pins are connected as follows**

D9 - Servo 1 (Base)

D10 - Servo 2 (Claw)

D11 - Servo 3 (Right Joint)

D12 - Servo 4 (Left Joint)


**Directory of Resources**

| Folder | Filename | Descriptive |
|---|---|---|
| Arduino-poses | arduino-poses | Arduino sketch which changes the position of the robot using a machine learning model from Wekinator based on camera input from Processing. |
| osc-routing | processing-osc-to-arduino | Processing sketch which listens for OSC messages from Wekinator and converts them to serial messages for Arduino; to be run with the arduino-osc-blink Arduino sketch. https://github.com/IDE-GID-Cyberphysical-Systems/de-arm/tree/main |
| sketch-RGB | sketch_rgb | Simple Processing sketch which will sample RGB values at the centre of the camera input and send only those on in OSC messages. https://github.com/IDE-GID-Cyberphysical-Systems/de-arm/tree/main |


**Instructions**

- Assemble Robot Arm.

- Upload and run the video_input_100_pixels sketch on Processor to turn on Camera input.

- Open Wekinator, set the number of inputs to 3, number of outputs to 1, model selection to “All Classifiers (default)”, classes to 3. Then, click NEXT. 

- Train the model based on 3 colours, taking at least 50 samples per colour.

- Open a new Processing sketch and input the osc-routing sketch, do not run it. Change the Serial Port name to your Serial Port name.

- Open Arduino IDE and input the Arduino-poses sketch.

- Verify and upload the Arduino-poses sketch.

- Run the osc-routing sketch.

- The Robot Arm should strike 3 poses based on the trained RGB model.


**Debugging Decision Tree**

<img width="4931" height="4827" alt="CPS-robotarm-charts_debugging decision tree" src="https://github.com/user-attachments/assets/1405ccfd-165a-46c2-b3cc-260369db6709" />
