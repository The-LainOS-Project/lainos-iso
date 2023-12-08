import QtQuick 2.5

Rectangle {
    color:"black"
    width:130
    height: 32
    border.width: 1
    border.color: "#D27486"
    property string label: "Ｓｈｕｔｄｏｗｎ"
    Text {
        color: "#D27486"
	font.pixelSize : 14
        text: parent.label
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
}
