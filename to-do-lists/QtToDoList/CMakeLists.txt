cmake_minimum_required(VERSION 3.16)

project(QtToDoList VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick REQUIRED)

qt_add_executable(appQtToDoList
    main.cpp RestApiClient.h RestApiClient.cpp TasksModel.h TasksModel.cpp
)

qt_add_qml_module(appQtToDoList
    URI QtToDoList
    VERSION 1.0
    QML_FILES main.qml Task.qml InputSection.qml
)

set_target_properties(appQtToDoList PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_compile_definitions(appQtToDoList
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(appQtToDoList
    PRIVATE Qt6::Quick)
