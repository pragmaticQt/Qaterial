
set(QT_BIN ${CMAKE_PREFIX_PATH}/bin CACHE STRING "Qt installation bin path")

message(STATUS "------ plugin Configuration ------")

message(STATUS "QATERIAL_ROOT_DIR        : ${QATERIAL_ROOT_DIR}")
message(STATUS "QATERIAL_HEADER_DIR      : ${QATERIAL_HEADER_DIR}")
message(STATUS "QATERIAL_SOURCE_DIR      : ${QATERIAL_SOURCE_DIR}")
message(STATUS "QT_BIN                   : ${QT_BIN}")

message(STATUS "------ plugin End Configuration ------")


add_library( qaterialplugin SHARED
    ${QATERIAL_SOURCE_DIR}/Logger.hpp
    ${QATERIAL_SOURCE_DIR}/Logger.cpp
    ${QATERIAL_SOURCE_DIR}/IconDescription.hpp
    ${QATERIAL_SOURCE_DIR}/IconDescription.cpp
    ${QATERIAL_SOURCE_DIR}/IconLabelImpl.hpp
    ${QATERIAL_SOURCE_DIR}/IconLabelImpl.cpp
    ${QATERIAL_SOURCE_DIR}/IconLabelPositionner.hpp
    ${QATERIAL_SOURCE_DIR}/IconLabelPositionner.cpp
    ${QATERIAL_SOURCE_DIR}/Clipboard.hpp
    ${QATERIAL_SOURCE_DIR}/Clipboard.cpp
    ${QATERIAL_SOURCE_DIR}/Version.hpp
    ${QATERIAL_SOURCE_DIR}/Version.cpp
    ${QATERIAL_SOURCE_DIR}/TextFile.hpp
    ${QATERIAL_SOURCE_DIR}/TextFile.cpp

    ${CMAKE_CURRENT_LIST_DIR}/qaterialplugin.h
    ${CMAKE_CURRENT_LIST_DIR}/qaterialplugin.cpp

)
set_property(TARGET qaterialplugin PROPERTY CXX_STANDARD 17)
set_property(TARGET qaterialplugin PROPERTY AUTOMOC ON)
# Version
target_compile_definitions(qaterialplugin
  PRIVATE -DQATERIAL_VERSION_MAJOR=${QATERIAL_VERSION_MAJOR}
  PRIVATE -DQATERIAL_VERSION_MINOR=${QATERIAL_VERSION_MINOR}
  PRIVATE -DQATERIAL_VERSION_PATCH=${QATERIAL_VERSION_PATCH}
  PRIVATE -DQATERIAL_VERSION_TAG=${QATERIAL_VERSION_TAG}
  PRIVATE -DQATERIAL_VERSION_TAG_HEX=${QATERIAL_VERSION_TAG_HEX}
)
#target_compile_definitions(qaterialplugin PRIVATE -DQATERIAL_STATIC) #-DNDEBUG
target_compile_definitions(qaterialplugin PRIVATE -DQATERIAL_SHARED) #-DNDEBUG
target_include_directories(qaterialplugin PUBLIC ${CMAKE_CURRENT_LIST_DIR} ${QATERIAL_HEADER_DIR})
target_compile_features(
    qaterialplugin
    PRIVATE
        cxx_auto_type
        cxx_generic_lambdas
)

target_link_libraries( qaterialplugin PUBLIC
  Qt::Core
  Qt::Gui
  Qt::Svg
  Qt::Xml
  Qt::Qml
  Qt::Quick
  Qt::QuickControls2  
)

# During plugin searching Qt will be looking for 'qmldir' file
# So we should place it next to our plugin lib.
add_custom_command(
    TARGET qaterialplugin
    POST_BUILD
    COMMAND
        ${CMAKE_COMMAND} -E copy
        ${CMAKE_CURRENT_LIST_DIR}/qmldir
        $<TARGET_FILE_DIR:qaterialplugin>/qmldir
    COMMAND
        cd $<TARGET_FILE_DIR:qaterialplugin>/.. &&
        ${QT_BIN}/qmlplugindump -nonrelocatable Qaterial 1.0 . > Qaterial/plugin.qmltypes

)

