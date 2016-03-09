import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Web 0.2
import Ubuntu.Components.Popups 1.0

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "webviewdialog.liu-xiao-guo"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    // Removes the old toolbar and enables new features of the new header.
    useDeprecatedToolbar: false

    width: units.gu(60)
    height: units.gu(85)

    Page {
        title: i18n.tr("webviewdialog")

        Component {
            id: confirmDlg

            Dialog {
                title: i18n.tr("JavaScript Confirmation")

                Button {
                    text: i18n.tr("OK")
                    onClicked: model.accept()
                }

                Button {
                    text: i18n.tr("Cancel")
                    onClicked: model.reject()
                }

                Component.onCompleted: show()
            }
        }

        Component {
            id: alertDlg

            Dialog {
                title: model.message

                Button {
                    text: i18n.tr("OK")
                    onClicked: model.accept()
                }

                Component.onCompleted: show()
            }
        }

        Component {
            id: promptDlg

            Dialog {
                TextField {
                    id: input
                    text: model.defaultValue
                    onAccepted: model.accept(input.text)
                }

                Button {
                    text: i18n.tr("OK")
                    color: "green"
                    onClicked: model.accept(input.text)
                }

                Button {
                    text: i18n.tr("Cancel")
                    color: UbuntuColors.coolGrey
                    onClicked: model.reject()
                }

                Binding {
                    target: model
                    property: "currentValue"
                    value: input.text
                }

                Component.onCompleted: show()
            }
        }

        WebView {
            anchors.fill: parent
            url: "www/index.html"
            confirmDialog: confirmDlg
            alertDialog: alertDlg
            promptDialog: promptDlg
        }
    }
}

