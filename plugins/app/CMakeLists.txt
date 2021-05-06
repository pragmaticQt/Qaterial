find_package(Qt5 REQUIRED COMPONENTS
  Core
  Quick
  Qml
)
# Telling CMake location of our app .qrc file
qt5_add_resources(APP_RESOURCES ${CMAKE_CURRENT_SOURCE_DIR}/qml/app.qrc)

# We're using ${PROJECT_NAME} for target name but it's not necessary
add_executable( app

    src/main.cpp        # Our example project consists only of one .cpp file
    ${APP_RESOURCES}    # App resources file
)
# Directories where Qt Creator can find QML files.
# (Not needed for builds, but makes Qt Creator code completion happy.)
list(APPEND QML_IMPORT_PATH ${QATERIAL_PLUGINS_BUILD_DIR})

# Prevent adding duplicate values at each run of CMake.
list(REMOVE_DUPLICATES QML_IMPORT_PATH)
# The variable is cached in ${BUILD_DIR}/CMakeCache.txt. We need FORCE to
# change it there immediately. Also, add a comment to the cache file.
set(QML_IMPORT_PATH ${QML_IMPORT_PATH}
    CACHE STRING "Qt Creator 4.1 extra qml import paths"
    FORCE
)
#set(QML2_IMPORT_PATH ${QML_IMPORT_PATH}
#    CACHE STRING "Qt Creator 4.1 extra qml import paths"
#    FORCE
#)


target_link_libraries(
    app
    PRIVATE
        Qt5::Core
        Qt5::Quick
        Qt5::Qml
#        qaterialplugin
)

