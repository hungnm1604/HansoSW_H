import QtQuick
import QtQuick.Controls 2.15
import Qt.labs.settings 1.1

ApplicationWindow {
    id: win
    width: 640
    height: 480
    visible: true
    title: "HANSO SW"


    //Reading Config
    property string cfgFile: appRunDir + "/config.ini"
    Settings { id: sysinf;    category: "system"; fileName: cfgFile }
    Settings { id: paths;  category: "paths";  fileName: cfgFile}
    Settings { id: tm;     category: "timing"; fileName: cfgFile }
    Settings { id: categoryScreen;     category: "categoryScreen";     fileName: cfgFile }


    property string productName: sysinf.value("productName", "다목적 살균소독기")
    property string model:       sysinf.value("model", "HS-RPS20")
    property string website:     sysinf.value("website", "www.hansoinc.com")
    property string email:       sysinf.value("email", "info@hansoinc.com")
    property int splashMs:       Number(tm.value("splashMs", 10000))
    property int holdMs:         Number(tm.value("holdMs", 3500))
    property string logoPath:    paths.value("logoPath", "/assets/logo.png")
     property string splashImgPath:    paths.value("logoPath", "/assets/splash.png")
    property string csSSelectMsg:    categoryScreen.value("csSSelectMsg", "대상 품목을 선택하세요")
    property string csNameButton1:    categoryScreen.value("csNameButton1", "방독면")
    property string csNameButton2:    categoryScreen.value("csNameButton2", "헬 멧")
    property string csNameButton3:    categoryScreen.value("csNameButton3", "조 끼")
    property string csNameButton4:    categoryScreen.value("csNameButton4", "수 통")
    property string csNameButton5:    categoryScreen.value("csNameButton5", "전자기기")
    property string csNameButton6:    categoryScreen.value("csNameButton6", "개인화기")






     // state: "splash" | "preheat" | "admin"
     property string appState: "splash"

    Loader {
            anchors.fill: parent
            active: true
            sourceComponent: appState === "splash" ? splashC
                             : appState === "admin"  ? adminC
                             : appState === "preheat"? preheatC
                             :                         categoryC
        }

    Component {
            id: splashC
            SplashScreen {
                logoSource: "file:/" + appRunDir + logoPath
                splashImgSource: "file:/" + appRunDir + splashImgPath
                productName: win.productName
                model: win.model
                website: win.website
                email: win.email
                splashMs: win.splashMs
                holdMs: win.holdMs
                onEnterAdmin: win.appState = "admin"
                onFinished:   win.appState = "preheat"
            }
        }

    Component {
           id: preheatC
           PreheatScreen {
               logoSource: "file:/" + appRunDir + logoPath
               productName: win.productName
               holdMs: 3000
               onFinished:   win.appState = "categoryC"
           }
       }

    Component {
           id: categoryC
           CategorySelect {
              // logoSource: "file:/" + appRunDir + logoPath
               csSSelectMsg: win.csSSelectMsg
               csNameButton1: win.csNameButton1
               csNameButton2: win.csNameButton2
               csNameButton3: win.csNameButton3
               csNameButton4: win.csNameButton4
               csNameButton5: win.csNameButton5
               csNameButton6: win.csNameButton6
              // onFinished:   win.appState = "preheat"
           }
       }


}
