import QtQuick 2.8
import QtQuick.Controls 2.1
import "qrc:/Translator.js" as Translator

Item {
    id:swmtextlabel
    height: mytext.height
    width:  mytext.width
    property string information: "SWM Text label gauge"
    property string displaytext
    property string fonttype
    property int fontsize
    property string textcolor
    property string backgroundcolor
    property string datasourcename
    property bool fontbold
    property int decimalpoints
    Drag.active: false

    Component.onCompleted: {
        checkdatasource();
    }

    DatasourcesList{id: powertunedatasource}

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
        onTextChanged: warningindication.warn();
        }

    function checkdatasource()
    {
        if (datasourcename != ""){
            if (decimalpoints < 4)
            {
                changetext.text  = Qt.binding(function(){return Dashboard[datasourcename].toFixed(decimalpoints)});
            }
            else
                changetext.text  = Qt.binding(function(){return Dashboard[datasourcename]});
        }
    }
}
