TEMPLATE = app

QT += qml quick widgets websockets sql

SOURCES += main.cpp \
    Server/server.cpp \
    Server/activesockets.cpp \
    Server/mediahandler.cpp \
    Server/searchresult.cpp \
    Server/simplecrypt.cpp \
    Server/clientconnection.cpp

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    Server/activesockets.h \
    Server/mediahandler.h \
    Server/searchresult.h \
    Server/server.h \
    Server/simplecrypt.h \
    Server/clientconnection.h
