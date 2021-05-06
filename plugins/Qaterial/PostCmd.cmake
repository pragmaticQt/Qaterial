# merge 2 qmldirs
#message(${SRC_DIR})
#message(${DST_DIR})
#message(${QML_DIR})

# copy all qml files
set(GLOB_EXPRESSION "${QML_DIR}/*.qml")
file(GLOB QML_FILES ${GLOB_EXPRESSION})

foreach(QML_FILE ${QML_FILES})
    file(COPY ${QML_FILE} DESTINATION ${DST_DIR})
endforeach()

file(READ ${QML_DIR}/qmldir body)
string(REPLACE "module Qaterial" "" body "${body}")
file(APPEND ${DST_DIR}/qmldir ${body})

# copy Fonts.qml and append it to qmldir
file(COPY ${SRC_DIR}/Fonts.qml DESTINATION ${DST_DIR})
file(APPEND ${DST_DIR}/qmldir "singleton Fonts 1.0 Fonts.qml")


