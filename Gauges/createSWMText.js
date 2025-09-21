
var component;
var gauge;


function createText(setX,setY,setdisplaytext,setfonttype,setfontsize,settextcolor,setbackgroundcolor,setdatasourcename,setfontbold,setdecimalpoints) {
    console.log("Qt.createComponent SWM text label ");
    component = Qt.createComponent("SWM_TextLabel.qml");
    if (component.status === Component.Ready){
        console.log("SWM text label component ready");
        finishCreation(setX,setY,setdisplaytext,setfonttype,setfontsize,settextcolor,setbackgroundcolor,setdatasourcename,setfontbold,setdecimalpoints);
    }
     else
        component.statusChanged.connect(finishCreation);
}

function finishCreation(setX,setY,setdisplaytext,setfonttype,setfontsize,settextcolor,setbackgroundcolor,setdatasourcename,setfontbold,setdecimalpoints) {
    if (component.status === Component.Ready) {
        console.log("finishCreation SWM text label ");
        gauge = component.createObject(userDash, {
                                        "x" :setX,
                                        "y" :setY,
                                        "displaytext" :setdisplaytext,
                                        "fonttype" :setfonttype,
                                        "fontsize" : setfontsize,
                                        "textcolor" :settextcolor,
                                        "resettextcolor" :settextcolor,
                                        "datasourcename": setdatasourcename,
                                        "fontbold" :setfontbold,
                                        "decimalpoints" :setdecimalpoints,
                                        "backgroundcolor": setbackgroundcolor
                                        });

        if (gauge === null) {
            // Error Handling
            console.log("Error creating object");
        }
    } else if (component.status === Component.Error) {
        // Error Handling
        console.log("Error loading component:", component.errorString());
    }
}
