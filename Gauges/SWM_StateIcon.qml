import QtQuick 2.8
import QtQuick.Controls 2.1
import "qrc:/Translator.js" as Translator

Item {
    id:swmtextlabel
    height: 64
    width:  64
    property string information: "SWM State Icon gauge"
    property string datasourcename: "Analog1"
    property string iconimage: "qrc:/graphics/pause.png"
    property double threshold_1: 10.0
    property double threshold_2: 20.0
    property double threshold_3: 30.0
    property string region_1_color: "blue"
    property string region_2_color: "green"
    property string region_3_color: "yellow"
    property string region_4_color: "red"
    Drag.active: false

    Component.onCompleted: {
        checkdatasource();
    }

    DatasourcesList{id: powertunedatasource}
    Connections{
        target: Dashboard
    }

    Rectangle {
        id: backgroundrect
        width: parent.width
        height: parent.height
        anchors.top : parent.top
        anchors.left: parent.left
        color: region_1_color
        clip: false
        visible: true
        anchors.topMargin: 0
        anchors.leftMargin: 0

    }
    
    Image {
        anchors.fill: parent
        id: icon
        fillMode: Image.PreserveAspectFit
        source:  iconimage
        visible: true
    }

    Text {
        id: mainvaluetextfield
        visible: false
        onTextChanged: {
            updateIconColor();
        }
    }

    function updateIconColor()
    {
        //console.log("SWM_TextLabel: updateIconColor");
        if (mainvaluetextfield.text < threshold_1)
            backgroundrect.color = region_1_color;
        else if (mainvaluetextfield.text >= threshold_1 && mainvaluetextfield.text < threshold_2)
            backgroundrect.color = region_2_color;
        else if (mainvaluetextfield.text >= threshold_2 && mainvaluetextfield.text < threshold_3)
            backgroundrect.color = region_3_color;
        else if (mainvaluetextfield.text >= threshold_3)
            backgroundrect.color = region_4_color;
        else
            backgroundrect.color = "magenta";
    }

    function checkdatasource()
    {
        //console.log("SWM_TextLabel: checkdatasource");
        if (datasourcename != ""){
                mainvaluetextfield.text  = Qt.binding(function(){return Dashboard[datasourcename]});
        }
    }
}