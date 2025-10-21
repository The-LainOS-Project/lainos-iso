import QtQuick 2.5

Rectangle {
    color:"black"
    width:130
    height: 32
    border.width: 1
    border.color: "#3D3B93"
    property string label: "Ｒｅｂｏｏｔ"
    Text {
        color: "#3D3B93"
	font.pixelSize : 14
        text: parent.label
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
}
