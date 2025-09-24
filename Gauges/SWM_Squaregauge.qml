import QtQuick 2.8
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.1
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import "qrc:/Translator.js" as Translator
import Qt.labs.settings 1.0
Rectangle {

    id: gauge
    width: parent.width * 0.3125
    height: parent.height * (200 / parent.height)
    property string information: "Square gauge"
    border.color: "#9f9f9f"
    border.width: 0
    Component.onCompleted: {set();        
    }

    property string mainvaluename
    property string secvaluename
    property alias title: gaugetextfield.text
    property alias mainunit: mainvalueunittextfield.text
    property alias vertgaugevisible: vertgauge.visible
    property alias horigaugevisible: horizgauge.visible
    property alias secvaluevisible: secondaryvaluetextfield.visible
    property alias secvalue  : placeholder2.text
    property alias mainvalue : placeholder.text
    property double maxvalue: vertgauge.maximumValue
    property alias titlecolor: titlebar.color
    property alias titlefontsize :gaugetextfield.font.pixelSize
    property alias mainfontsize :mainvaluetextfield.font.pixelSize
    property string resettitlecolor
    property string resetbackroundcolor
    property string framecolor
    property string titletextcolor
    property string textcolor
    property string barcolor
    property int decimalpoints
    property int decimalpoints2
    property double warnvaluehigh: 20000
    property double warnvaluelow : -20000
    property string textFonttype
    property string valueFonttype :"Verdana"
    property real peakval: 0

    //Variables for Offset and Scales
    property double gaugeScaleOffset
    property double scaleValue: gaugeSettings.scaleValueStored
    property double offsetValueMultiply: gaugeSettings.offsetValueMultiplyStored
    property double offsetValueDivide: gaugeSettings.offsetValueDivideStored

    //Settings to store the scales and offsets and keep them persistent through reboots
    Settings{
        id: gaugeSettings
        property double scaleValueStored
        property double offsetValueMultiplyStored
        property double offsetValueDivideStored
    }

    Drag.active: true
    DatasourcesList{id: powertunedatasource}

    Connections{
        target: Dashboard
        onDraggableChanged:togglemousearea()
    }

    Text {
        id : placeholder
        //onTextChanged: { toggledecimal();}
        //Component.onCompleted: {toggledecimal();}
        visible: false
    }
    Text {
        id : placeholder2
        //onTextChanged: { toggledecimal();}
        //Component.onCompleted: {toggledecimal();}
        visible: false
    }

    Rectangle {
        id: titlebar
        width: parent.width
        height: parent.height
        anchors.top : parent.top
        anchors.left: parent.left
        color: titlecolor
        clip: false
        visible: false
        anchors.topMargin: 0
        anchors.leftMargin: 0

    }

    Text {
        id: gaugetextfield
        anchors.verticalCenter: titlebar.verticalCenter
        anchors.horizontalCenter: titlebar.horizontalCenter
        font.pixelSize: 23
        font.bold: true
        font.family: textFonttype
        color: titletextcolor
    }

    Text {
        id: mainvaluetextfield
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: parent.width * (50 / parent.width)
        font.family: valueFonttype
        color: "white"
        //text: gaugeScaleOffset
        onTextChanged: {
            warningindication.warn();
        }
    }

    Text {
        id: mainvalueunittextfield
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: mainvaluetextfield.font.pixelSize / 1.8 //28
        font.family: textFonttype
        font.bold: true
        color: textcolor
    }


    Gauge {
        id: vertgauge
        height: parent.setHeight
        width: parent.width
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        orientation: Qt.Vertical
        minorTickmarkCount: 0
        tickmarkAlignment: Qt.AlignRight
        value: parent.mainvalue //gaugeScaleOffset
        maximumValue: parent.maxvalue

        style: GaugeStyle {
            valueBar: Rectangle {
                id: vertbar
                implicitWidth: vertgauge.width
                color: barcolor
            }
        }
    }

    Gauge {
        id: horizgauge
        height: parent.height
        width: parent.width
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        orientation: Qt.Horizontal
        minorTickmarkCount: 0
        tickmarkAlignment: Qt.AlignRight
        value: parent.mainvalue //gaugeScaleOffset
        maximumValue: parent.maxvalue

        style: GaugeStyle {
            valueBar: Rectangle {
                implicitWidth: horizgauge.height
                color: barcolor
            }
        }
    }
    Item {
        id: warningindication
        function warn()
        {

            if (mainvaluetextfield.text > warnvaluehigh || mainvaluetextfield.text < warnvaluelow )anim.running = true,anim2.running = true;
            else anim.running = false,anim2.running = false,titlebar.color = resettitlecolor ,gauge.color = resetbackroundcolor;
            if (mainvaluetextfield.text > peakval)peakval = mainvaluetextfield.text;
            //console.log (peakval);

        }
    }

    function set()
    {
        gauge.color = resetbackroundcolor;
        gauge.border.color = framecolor;
        gauge.titlecolor = resettitlecolor;
        gaugetextfield.color =  titletextcolor;
        secondaryvaluetextfield.color =  textcolor;
        mainvaluetextfield.color =  textcolor;
        mainvalueunittextfield.color =  textcolor;
        //vertgauge.valueBar.color = "green"
    }
    function togglemousearea()
    {
        if (Dashboard.draggable === 1)
        {
            touchArea.enabled = true;
            //    console.log ("Enable square touch");
        }
        else
            touchArea.enabled = false;
        //    console.log ("Disable square touch");
    }
    //
    function toggledecimal()
    {
        //console.log("Decimalpints loaded " + decimalpoints);
        if (decimalpoints < 4)
        {
             mainvaluetextfield.text = Qt.binding(function(){return Dashboard[mainvaluename].toFixed(decimalpoints)});
        }
        else
        {
            mainvaluetextfield.text = Qt.binding(function(){return Dashboard[mainvaluename]});
        vertgauge.value = 0;
        horizgauge.value = 0;
        }
    }
    function toggledecimal2()
    {
        //console.log("toggle sec decimal "+decimalpoints2)
        if (decimalpoints2 < 4)
        {
            secondaryvaluetextfield.text =  Qt.binding(function(){return Dashboard[secvaluename].toFixed(decimalpoints2)});
        }
        else
        {
            secondaryvaluetextfield.text = Qt.binding(function(){return Dashboard[secvaluename]});
        vertgauge.value = 0;
        horizgauge.value = 0;
        }

    }
}
