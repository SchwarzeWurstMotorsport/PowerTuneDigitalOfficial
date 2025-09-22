
var component;
var gauge;


function createText(setX,setY,setdisplaytext,setfonttype,setfontsize,settextcolor,setbackgroundcolor,setdatasourcename,setfontbold,setdecimalpoints, setthreshold_1, setthreshold_2, setthreshold_3, setregion_1_color, setregion_2_color, setregion_3_color, setregion_4_color) {
    console.log("Qt.createComponent SWM text label ");
    component = Qt.createComponent("SWM_TextLabel.qml");
    if (component.status === Component.Ready){
        console.log("SWM text label component ready");
        finishCreation(setX,setY,setdisplaytext,setfonttype,setfontsize,settextcolor,setbackgroundcolor,setdatasourcename,setfontbold,setdecimalpoints, setthreshold_1, setthreshold_2, setthreshold_3, setregion_1_color, setregion_2_color, setregion_3_color, setregion_4_color);
    }
     else
        component.statusChanged.connect(finishCreation);
}

function finishCreation(setX,setY,setdisplaytext,setfonttype,setfontsize,settextcolor,setbackgroundcolor,setdatasourcename,setfontbold,setdecimalpoints, setthreshold_1, setthreshold_2, setthreshold_3, setregion_1_color, setregion_2_color, setregion_3_color, setregion_4_color) {
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
                                        "backgroundcolor": setbackgroundcolor,
                                        "threshold_1": setthreshold_1,
                                        "threshold_2": setthreshold_2,
                                        "threshold_3": setthreshold_3,
                                        "region_1_color": setregion_1_color,
                                        "region_2_color": setregion_2_color,
                                        "region_3_color": setregion_3_color,
                                        "region_4_color": setregion_4_color
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
