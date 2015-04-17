#ifndef QTSPOTIFYTHREAD_H
#define QTSPOTIFYTHREAD_H

#include <QThread>
#include "qtlibspotify.h"


class QtSpotifyThread:public QThread
{
public:
    QtSpotifyThread();
    ~QtSpotifyThread();

    void run(){

    };
};

#endif // QTSPOTIFYTHREAD_H
