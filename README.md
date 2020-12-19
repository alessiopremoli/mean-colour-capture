# mean-colour-capture

## DESCRIPTION: 
This processing tool will connect to your webcam and analyze its the mean color.  It generates three values (r, g, b) that will be displayed on the box below and can be sent to Wekinator via OSC clicking on the start button.  The three values are remapped to 0 and 1 for simplicity.
This feature extractor will map different frames to different colors and can be used to control synthesizers or similar sound generators when parameters should be controlled by a value that can describe an image in its wholeness.

## HOW TO COMPILE / RUN IT:
This processing is developed using processing 3.5.4 and should run easily on every 3.x version. You'll need to install the two libraries `processing.video` and `oscP5` by clicking `Tools > Add Tool... > Libraries` and searching for them. Once everything is set up you can run it. If you don't have processing installed you can download the biaries included in the release page on github. Well, you'll need a webcam, that goes without saying.

## HOW TO RUN / USE IT:
Open it, your webcam will start capturing images and the corresponding block will be filled with the mean color. Click on START OSC and the osc messages stream
will start. STOP OSC will end it.