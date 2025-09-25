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
    border.width: 2

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

 
    Drag.active: false
    DatasourcesList{id: powertunedatasource}

    Connections{
        target: Dashboard

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
        value: parent.mainvalue 
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
        value: parent.mainvalue 
        maximumValue: parent.maxvalue

        style: GaugeStyle {
            valueBar: Rectangle {
                implicitWidth: horizgauge.height
                color: barcolor
            }
        }
    }
}
