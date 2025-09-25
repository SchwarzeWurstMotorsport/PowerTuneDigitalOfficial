import QtQuick 2.8
import QtQuick.Controls 2.1
import "qrc:/Translator.js" as Translator

Item {
    id:swmtextlabel
    property string information: "SWM Text label gauge"
    property string displaytext
    property string fonttype
    property int fontsize
    property string textcolor
    property string backgroundcolor
    property string datasourcename: "Analog1"
    property bool fontbold
    property int decimalpoints
    property double threshold_1: 10.0
    property double threshold_2: 20.0
    property double threshold_3: 30.0
    property string region_1_color: "magenta"
    property string region_2_color: "purple"
    property string region_3_color: "darkviolet"
    property string region_4_color: "indigo"
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
        color: backgroundcolor
        clip: false
        visible: true
        anchors.topMargin: 0
        anchors.leftMargin: 0

    }

    Text {
        id: mytext
        text: displaytext
        font.family: fonttype
        font.pointSize: fontsize
        font.bold: fontbold
        color: textcolor
        anchors.centerIn: parent
        onTextChanged: updateTextColor();
        }

    function updateTextColor()
    {
        //console.log("SWM_TextLabel: updateTextColor");
        if (mytext.text < threshold_1)
            mytext.color = region_1_color;
        else if (mytext.text >= threshold_1 && mytext.text < threshold_2)
            mytext.color = region_2_color;
        else if (mytext.text >= threshold_2 && mytext.text < threshold_3)
            mytext.color = region_3_color;
        else if (mytext.text >= threshold_3)
            mytext.color = region_4_color;
        else
        mytext.color = textcolor;
    }

    function checkdatasource()
    {
        //console.log("SWM_TextLabel: checkdatasource");
        if (datasourcename != ""){
            if (decimalpoints < 4)
            {
                mytext.text  = Qt.binding(function(){return Dashboard[datasourcename].toFixed(decimalpoints)});
            }
            else
                mytext.text  = Qt.binding(function(){return Dashboard[datasourcename]});
        }
    }
}
