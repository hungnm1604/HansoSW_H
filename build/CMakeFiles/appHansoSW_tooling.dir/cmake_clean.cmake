file(REMOVE_RECURSE
  "HansoSW/components/AdminMode.qml"
  "HansoSW/components/CategorySelect.qml"
  "HansoSW/components/PreheatScreen.qml"
  "HansoSW/components/SplashScreen.qml"
  "HansoSW/main.qml"
  "HansoSW/resources.qrc"
)

# Per-language clean rules from dependency scanning.
foreach(lang )
  include(CMakeFiles/appHansoSW_tooling.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
