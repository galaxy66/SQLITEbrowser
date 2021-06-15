import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.VirtualKeyboard 2.3
import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import Foo 1.0
import Schmdl 1.0
import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.2
import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.VirtualKeyboard 2.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import Foo 1.0
import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

Window {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    signal callquerys(string tn)

    onCallquerys: {console.log(tn);rec.makerow(tn)
    }

    SqlQueryModel{
        id: sqlmodel
        //query: "select * from COMPANY"
    }
    Schmdl{
        id:schmdl
    }

    InputPanel {
        id: inputPanel
        z: 99
        x: 0
        y: window.height
        width: window.width

        states: State {
            name: "visible"
            when: inputPanel.active
            PropertyChanges {
                target: inputPanel
                y: window.height - inputPanel.height
            }
        }
        transitions: Transition {
            from: ""
            to: "visible"
            reversible: true
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }

    Column{
        anchors.fill: parent
        spacing: 5
        TextArea {
            id: txtpath
            text: "/home/arm/IODB"
            width: parent.width
            height: 30

        }
        Button
        {
            id: btncnn
            text: "OPEN DB"
            width: parent.width
            height: 60
            onClicked: {
                if(sqlmodel.connection(txtpath.text))
                {
                    schmdl.updateModel();
                    mylistView.model=schmdl;
                    //                    sqlmodel.query="SELECT name FROM sqlite_master WHERE type='table';";
                    //                    console.log("db open and show the data");
                }
            }
        }
        Rectangle{
            width: parent.width
            height: parent.height-(txtpath.height+btncnn.height)-10
            Row{
                anchors.fill: parent
                spacing: 5

                ListView{
                    id:mylistView
                    model: 3
                    width: 200
                    height: 200//contentHeight-50
                    delegate: GridLayout{
                        anchors.margins: 2
                        height: 22
                        width: parent.width
                        // rows: 1
                        columns: 1
                        columnSpacing: 2

                        Text
                        {
                            width:  100
                            height: 10
                            id:mbtn
                            text: name
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    callquerys(name)
//                                    for(var ti=0 ; ti< tbl.columnCount;ti++)
//                                        tbl.removeColumn(ti)
//                                    var str="select * from "+ name+";";
//                                    sqlmodel.query= str;
//                                    console.log(str);
//                                    lv.model=sqlmodel

////                                    var rc = sqlmodel.rowCount()
//                                    var fc = sqlmodel.columnCount()
//                                    var roleList = sqlmodel.userRoleNames
//                                    for(var i = 0; i < fc; ++i){
//                                        var role  = roleList[i];
//                                        var col = columnComponent.createObject(myrow, {'text': role,
//                                                                                   'width': 100})
//                                        tbl.addColumn(col)
//                                    }
//                                    for(var j = 0; j < rc; ++j){
//                                        var d = {};
//                                        for(var f = 0; f < fc; ++f){
//                                            d[f] = "test"
//                                            //console.log(d)
//                                        }
//                                        lmTable.append(d)
//                                    }

                                }
                            }

                        }
                    }
                }

                Rectangle{
                    width: 600
                    height: 400
                    id:rec
                    Component{
                        id: mycomp
                        Text {
                        }
                    }

                    function makerow(name)
                    {
                        var str="select * from "+ name+";";
                        sqlmodel.query= str;
                        console.log(str);
                        lv.model=sqlmodel
                        var roleList = sqlmodel.userRoleNames
                        var fc = sqlmodel.columnCount()
                        var col={}
                        for(var i = 0; i < fc; ++i){
                            var role  = roleList[i];
                            col[i]=(mycomp.createObject(myrow, {'text': role}))

                        }
                        myrow.add(col);
                        gl.append(myrow)
                    }
                    Row{
                        width: parent.width
                        height: 30
                        id:myrow

                    }
                    ListView
                    {
                        id:lv
                        width: parent.width
                        height: parent.height

                        delegate: GridLayout{
                            width: parent.width
                            height: 30
                            id:gl

                        }

                    }
                }
            }
        }


    }
}


