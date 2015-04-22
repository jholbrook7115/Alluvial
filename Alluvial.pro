TEMPLATE = app

QT += qml quick widgets multimedia websockets

SOURCES += main.cpp \
    jsonformatter.cpp \
    settings_storage.cpp \
    qtlibspotify.cpp \
    mediaplayer.cpp \
    playlist_item.cpp \
    playlist.cpp \
    playlist_handler.cpp \
    dataobject.cpp \
    communicationhandler.cpp \
    qtlibspotifyhandler.cpp

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
    ../appkey.h \
    mediaplayer.h \
    playlist_item.h \
    playlist.h \
    playlist_handler.h \
    dataobject.h \
    communicationhandler.h \
    qtlibspotifyhandler.h
DISTFILES += \
    qmldir.txt \
    Doxyfile
    qmldir.txt

#unix:!macx: LIBS += -lspotify

unix:!macx: LIBS += -L$$PWD/../../../../../usr/local/lib/ -lspotify

INCLUDEPATH += $$PWD/../../../../../usr/local/include
DEPENDPATH += $$PWD/../../../../../usr/local/include
