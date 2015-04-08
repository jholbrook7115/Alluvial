TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp \
    jsonformatter.cpp \
    settings_storage.cpp \
    qtlibspotify.cpp

RESOURCES += qml.qrc

CONFIG += c++11

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    settings_storage.h \
    jsonformatter.h \
    qtlibspotify.h \
    ../appkey.h
DISTFILES += \
    qmldir.txt

#unix:!macx: LIBS += -lspotify

unix:!macx: LIBS += -L$$PWD/../../../../../usr/local/lib/ -lspotify

INCLUDEPATH += $$PWD/../../../../../usr/local/include
DEPENDPATH += $$PWD/../../../../../usr/local/include
