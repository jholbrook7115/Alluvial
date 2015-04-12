TEMPLATE = app

QT += qml quick widgets multimedia

SOURCES += main.cpp \
    mediaplayer.cpp \
    playlist_item.cpp \
    playlist.cpp \
    playlist_handler.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    settings_storage.h \
    mediaplayer.h \
    playlist_item.h \
    playlist.h \
    playlist_handler.h
DISTFILES += \
    qmldir.txt \
    Doxyfile
