#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    
    //load our image
    /*
     img.load("circles.png");
     img.setImageType(OF_IMAGE_GRAYSCALE);
     
     //allocate our matrix
     ofxCv::allocate(cvMat, img.getWidth(), img.getHeight(), OF_IMAGE_GRAYSCALE);
     
     cvMat = ofxCv::toCv(img);
     */
    
    
    //work with video grabber
    grabber.initGrabber(ofGetWidth(), ofGetHeight());
    gray.allocate(ofGetWidth(), ofGetHeight(), OF_IMAGE_GRAYSCALE);
    ofxCv::allocate(cvMat, ofGetWidth(), ofGetHeight(), OF_IMAGE_GRAYSCALE);
    
    //setup gui
    gui.setup(); // most of the time you don't need a name
    gui.add(dp_param.setup("dp param", 1, 0, 10));
    gui.add(mindist_param.setup("min dist param", 200, 1, 1000));
    gui.add(param1_param.setup("param1 param", 130, 0, 500));
    gui.add(param2_param.setup("param2 param", 30, 0, 100));
    gui.add(minradius_param.setup("min. radius param", 0, 0, 500));
    gui.add(maxradius_param.setup("max. radius param", 400, 0, 500));
    gui.add(numCircles.setup("# of circles size", ofToString((int)circles.size())));
    
    //sound
    vocals.load("Violet.mp3");
    vocals.setVolume(0.5f);
    //vocals.setMultiPlay(true);
    
    numPlayers = 0;

}

//--------------------------------------------------------------
void ofApp::update(){
    
    //ofSoundUpdate();
    
    
    for (int i=0; i<players.size(); i++){
        cout << "playing player #: " << i << endl;
        players[i]->play();
        
    }
    players.clear();
    
    
    
    grabber.update();
    if (grabber.isFrameNew()){
        circles.clear();

        ofxCv::convertColor(grabber, gray, CV_RGB2GRAY);
        gray.update();
        
        cvMat = ofxCv::toCv(gray);
        cv::GaussianBlur( cvMat, cvMat, cv::Size(9, 9), 2, 2 );
        
        cv::HoughCircles( cvMat,
                         circles,
                         CV_HOUGH_GRADIENT,
                         dp_param,
                         mindist_param,
                         param1_param,
                         param2_param,
                         minradius_param,
                         maxradius_param );
        std::cout << "num circles " << circles.size() << endl;
        for (int i=0; i<circles.size(); i++){
            
            numPlayers++; // count number of players we're making
            cout << "num players: " << numPlayers << endl;
            
            ofSoundPlayer * player = new ofSoundPlayer();
            player->load("synth.mp3");
            //player->setVolume(ofMap(circles[i][2], 0, 100, 0.1, 1.0));
            //player->setSpeed( 0.1f + ((float)(ofGetHeight() - circles[i][1]) / (float)ofGetHeight()));
            players.push_back(player);
            
            /*
            if(player->isLoaded()){
                player->play();
            }
            */
            //players.clear();
            /*
            if(!player->isPlaying()){
                delete player;
            }
             */
        }
    }

}

//--------------------------------------------------------------
void ofApp::draw(){
    gray.draw(0, 0);
    
    ofPushStyle();
    ofSetColor(255, 0, 0);
    ofNoFill();
    for (int i=0; i<circles.size(); i++) {
        ofDrawCircle(circles[i][0], circles[i][1], circles[i][2]);
    }
    ofPopStyle();
    
    gui.draw();
}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::lostFocus(){

}

//--------------------------------------------------------------
void ofApp::gotFocus(){

}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){

}
