#pragma once

#include "ofxiOS.h"
#include "ofxCv.h"
#include "ofxGui.h"
#import "AVSoundPlayer.h"

class ofApp : public ofxiOSApp {
	
    public:
        void setup();
        void update();
        void draw();
        void exit();
	
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);

        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);
    
    ofImage img;
    
    //for video grabber
    ofVideoGrabber grabber;
    ofImage gray;
    
    cv::Mat cvMat;
    
    vector<cv::Vec3f> circles;
    
    ofxPanel gui;
    
    ofxIntSlider dp_param;
    ofxIntSlider mindist_param;
    ofxIntSlider param1_param;
    ofxIntSlider param2_param;
    ofxIntSlider minradius_param;
    ofxIntSlider maxradius_param;
    ofxLabel numCircles;
    
    
    //sound
    ofSoundPlayer  vocals;
    vector<ofSoundPlayer*> players;
    
    int numPlayers;
};


