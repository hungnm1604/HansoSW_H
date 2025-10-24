cmake_minimum_required(VERSION 3.16)

project(HansoSW VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

#find_package(Qt6 6.2 COMPONENTS Quick REQUIRED QuickControls2)
find_package(Qt6 6.2 REQUIRED COMPONENTS Quick QuickControls2 QuickLayouts)

qt_add_executable(appHansoSW
    main.cpp
)

qt_add_qml_module(appHansoSW
    URI HansoSW
    VERSION 1.0
    QML_FILES
        main.qml
        components/SplashScreen.qml    
        components/AdminMode.qml
        components/PreheatScreen.qml
        components/CategorySelect.qml
        components/CommonButton.qml
    RESOURCES
        resources.qrc
)
# Copy config.ini vào thư mục build khi build app
configure_file(
    ${CMAKE_SOURCE_DIR}/config.ini
    ${CMAKE_CURRENT_BINARY_DIR}/config.ini
    COPYONLY
)
add_custom_target(copy_assets ALL
    COMMAND ${CMAKE_COMMAND} -E copy_directory
            ${CMAKE_SOURCE_DIR}/assets
            ${CMAKE_CURRENT_BINARY_DIR}/assets
)
add_dependencies(appHansoSW copy_assets)

set_target_properties(appHansoSW PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_compile_definitions(appHansoSW
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(appHansoSW
    PRIVATE Qt6::Quick Qt6::QuickControls2 Qt6::QuickLayouts)
