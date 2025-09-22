
var component;
var gauge;


function createText(setX,setY,setwidth,setheight,seticonimage,setdatasourcename,setthreshold_1, setthreshold_2, setthreshold_3, setregion_1_color, setregion_2_color, setregion_3_color, setregion_4_color) {
    console.log("Qt.createComponent SWM state icon ");
    component = Qt.createComponent("SWM_StateIcon.qml");
    if (component.status === Component.Ready){
        console.log("SWM state icon component ready");
        finishCreation(setX,setY,setwidth,setheight,seticonimage,setdatasourcename,setthreshold_1, setthreshold_2, setthreshold_3, setregion_1_color, setregion_2_color, setregion_3_color, setregion_4_color);
    }
     else
        component.statusChanged.connect(finishCreation);
}

function finishCreation(setX,setY,setwidth,setheight,seticonimage,setdatasourcename,setthreshold_1, setthreshold_2, setthreshold_3, setregion_1_color, setregion_2_color, setregion_3_color, setregion_4_color) {
    if (component.status === Component.Ready) {
        console.log("finishCreation SWM state icon ");
        gauge = component.createObject(userDash, {
                                        "x":setX,
                                        "y":setY,
                                        "width":setwidth,
                                        "height":setheight,
                                        "datasourcename": setdatasourcename,
                                        "iconimage": seticonimage,
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
