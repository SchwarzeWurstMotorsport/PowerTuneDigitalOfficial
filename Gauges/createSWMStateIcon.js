
var component;
var gauge;


function createText(setX,setY,setdisplaytext,setfonttype,setfontsize,settextcolor,setbackgroundcolor,setdatasourcename,setfontbold,setdecimalpoints,setthreshold1,setthreshold2,setthreshold3,setregion1color,setregion2color,setregion3color,setregion4color) {
    component = Qt.createComponent("SWM_TextLabel.qml");
    if (component.status === Component.Ready){
       // console.log("text component ready");
        finishCreation(setX,setY,setdisplaytext,setfonttype,setfontsize,settextcolor,setbackgroundcolor,setdatasourcename,setfontbold,setdecimalpoints,setthreshold1,setthreshold2,setthreshold3,setregion1color,setregion2color,setregion3color,setregion4color);
    }
     else
        component.statusChanged.connect(finishCreation);
}

function finishCreation(setX,setY,setdisplaytext,setfonttype,setfontsize,settextcolor,setbackgroundcolor,setdatasourcename,setfontbold,setdecimalpoints,setthreshold1,setthreshold2,setthreshold3,setregion1color,setregion2color,setregion3color,setregion4color) {
    if (component.status === Component.Ready) {
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
                                        "threshold_1": setthreshold1,
                                        "threshold_2": setthreshold2,
                                        "threshold_3": setthreshold3,
                                        "region_1_color": setregion1color,
                                        "region_2_color": setregion2color,
                                        "region_3_color": setregion3color,
                                        "region_4_color": setregion4color
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
