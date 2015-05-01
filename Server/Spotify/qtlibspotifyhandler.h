#ifndef QTLIBSPOTIFYHANDLER_H
#define QTLIBSPOTIFYHANDLER_H

#include <QString>
#include <QObject>
#include <QJsonArray>
#include <QThread>
#include <QDebug>
#include "../Settings/settings_storage.h"
#include <libspotify/api.h>
#include "qtlibspotify.h"

//QtLibSpotify *libSpotifyObj;
/*!
 * \brief The QtLibSpotifyWorker class
 *
 * This class is a worker which will process events for the LibSpotifyhandler
 * which must be completed in the thread which libSpotify exists in.  LibSpotify
 * must be set up this way to make sure that it does not run its infinite loop
 * in the main thread.
 */

class QtLibSpotifyWorker : public QObject
{
    Q_OBJECT

public:
    QtLibSpotifyWorker(){};
    ~QtLibSpotifyWorker(){};

    QtLibSpotify* libspotifyObj;
public slots:
    /*!
     * \brief doWork
     * This slot is what the QtLibSpotifyHandler signals to when it creates the
     * LibSpotify instance.  It will get the username and passowrd from settings
     * and use them to create a QtLibSpotify object which will be the reference
     * libSpotify.
     */
    void doWork(){
        qDebug() << "Made it inside the doWork function";
        Settings_storing *settings = new Settings_storing();
        QString spotifyusername = settings->value("spotifyUserName").toString();
        QString spotifypassword = settings->value("spotifyPassword").toString();
        QString result;
        //connect(this, &QtLibSpotifyWorker::searchSpotify, libspotifyObj, &QtLibSpotify::search);

        libspotifyObj = new QtLibSpotify( spotifyusername, spotifypassword);
        qDebug() << "after QtLibSpotify Object instantiation";
        connect(this, &QtLibSpotifyWorker::searchSpotify, libspotifyObj, &QtLibSpotify::search);

    }
    /*!
     * \brief incomingSearch
     * This function is the slot that will act as a middle man between the
     * QtLibSpotifyHandler and the QtLibSpotify object.  It exists just to pass
     * along the QString search input from the SearchBar in the main UI.
     * \param query
     *  The QString input that originiates from the SearchBar found in the Main UI.
     */
    void incomingSearch(QString query)
    {
        qDebug() << "Sending an search request signal to libspotify";
        emit searchSpotify(query);
    }

signals:
    /*!
     * \brief searchSpotify
     * A signal to QtLibSpotify to tell it to search
     * \param searchText The QString input from the SearchBar in the Main UI
     */
    void searchSpotify(QString searchText);

    /*!
     * \brief finished  The signal to emit when the spotify object is finished
     * and closing
     */
    void finished();

    /*!
     * \brief returnDataStream
     * The signal to emit when Spotify returns a song/media file
     * \param musicStream The song to send back to the Media Handler
     */
    void returnDataStream(QByteArray &musicStream);

    /*!
     * \brief returnSearchResults
     * The signal to emit when Spotify returns a search
     * \param searchResults A QJsonArray of the search results that
     * libSpotify returns
     */
    void returnSearchResults(QJsonArray &searchResults);
};

// /////////////////////////////////////////////
// This is the class to reference for all things related to Spotify
// /////////////////////////////////////////////

class QtLibSpotifyHandler : public QObject
{
    Q_OBJECT
    QThread spotifyThread;

public:
    QString uname;
    QString pword;
    QtLibSpotifyHandler(QObject *parent = 0);
    //QtLibSpotifyHandler();
    ~QtLibSpotifyHandler();

signals:
    // ///////////////////////////////////////////////
    // To mediaHandler from libspotify signals
    // ///////////////////////////////////////////////
    /*!
     * \brief playbackSignal
     * This is the signal which will be emitted when playback from Spotify is
     * returned from libSpotify.
     * \param musicalNotesThatPlayInASequence The byte array which will be the
     * media returned from Spotify
     */
    void playbackSignal(QByteArray musicalNotesThatPlayInASequence);

    /*!
     * \brief onSearchComplete
     * This is the signal which will be emitted when search results from Spotify is
     * returned from libSpotify.
     * \param searchResults A QJsonArray of a the search results from Spotify
     */
    void onSearchComplete(QJsonArray *searchResults);

    // ///////////////////////////////////////////////
    // To QtLibSpotifyWorker signals from "this" signals
    // ///////////////////////////////////////////////
    /*!
     * \brief searchForSpotify
     * This is the signal to the spotify worker that will send the search
     * text input.
     * \param searchText The QString input that originiates from the SearchBar
     * found in the Main UI.
     */
    void searchForSpotify(QString searchText);
    /*!
     * \brief startWorking
     * This is the signal to the spotify worker that will tell it to initialize
     * QtLibSpotify
     */
    void startWorking();

public slots:
    void searchResultsCB(QJsonArray searchResults);
    void dataStreamCB(QByteArray byteArray);
    void searchSlot(QString query);
};

#endif // QTLIBSPOTIFYHANDLER_H
