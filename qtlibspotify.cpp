
/******************************************************

  STOP HERE!  NO SERIOUSLY FUCKING STOP RIGHT NOW!
  IN ORDER FOR THIS CODE TO WORK YOU MUST GET A LIBSPOTIFY
  APPLICATION KEY FROM: https://devaccount.spotify.com/my-account/keys/

  GOT IT, YET?????????? PROBABLY NOT BUT FUCK IT!!!
  OK SO NOW WHEN YOU HAVE YOUR APPLICATION KEY, TAKE IT AND PLACE
  IT IN THE PARENT DIRECTORY OF THE FOLDER WHICH THIS FILE
  (fyi: this file is called qtlibspotify.cpp) IS CURRENTLY!

  DO NOT PUT IT ANYWHERE ELSE!! IF YOU DO A BAD PERSON WILL FIND YOU
  EAT ALL OF YOUR NUTELLA AND PEANUT BUTTER AND ICE CREAM. HE WILL
  ALSO CLOG YOUR TOILETS WITH YOU FAVORITE PAIR OF SOCKS!

  *****************************************************/

#define USER_AGENT "AlluvialMusicPlayer1"

#include "qtlibspotify.h"
//#include "../appkey.c"
#include <QDebug>
#include <thread>
#include <chrono>

#include "../appkey.h"

static int notify_events;
static pthread_mutex_t notify_mutex;
static pthread_cond_t notify_cond;
bool FLAG_SPOTIFY_STATUS;
sp_session *session;
sp_search *res;

static void  connection_error(sp_session *session, sp_error error){
    qDebug() << "Spotify:  Connection Error - " << sp_error_message(error);
}

static void logged_in(sp_session *session, sp_error error){
    qDebug() << "Spotify: Logged_in Reached";
    if(SP_ERROR_OK != error){
        FLAG_SPOTIFY_STATUS=false;
        qDebug() << "Spotify:  Log in failed: " << sp_error_message(error);
    }
    else{
        qDebug() << "Spotify: Log in successful";
        FLAG_SPOTIFY_STATUS=true;
    }

}

static void logged_out(sp_session *session){
    qDebug() << "Spotify: Logged Out";
}

static void log_message(sp_session *session, const char *data){
    qDebug() << "Spotify: log_message - "<< data;
}

static void notify_main_thread(sp_session *session){
    pthread_mutex_lock(&notify_mutex);
    notify_events = 1;
    pthread_cond_signal(&notify_cond);
    pthread_mutex_unlock(&notify_mutex);
}

static sp_session_callbacks callbacks = {
    &logged_in,
    &logged_out,
    NULL,
    &connection_error,
    NULL,
    &notify_main_thread,
    NULL,
    NULL,
    &log_message
};

static const char* convertToString(QString strInput){
    QByteArray byteForm = strInput.toLatin1();

    const char* charPtrForm = byteForm.data();
    qDebug() << "Converted [" << strInput <<"] to [" << charPtrForm <<
                "]";
    return charPtrForm;
}

static void search_complete(sp_search* search, void* userdata){
    qDebug() << "Spotify: search_complete callback called";
    if(sp_search_error(search) == SP_ERROR_OK){
        //format and return the search results?????
        /*
         * options:
         *  1) return three result type for albums, artist, and tracks
         *
         *  2) return tracks with info about album/artist/etc
         * */
    }
    else{
        qDebug() << "Spotify: search result error - " << sp_search_error(search);
    }
    sp_search_release(search);
}
/*
static getDevice_ID(){
    FILE file;
}
*/

sp_connectionstate QtLibSpotify::GetConnectionState(){
    if(session)
    {
        sp_connectionstate connectState = sp_session_connectionstate(session);
        return connectState;
    }
    else
    {
        return SP_CONNECTION_STATE_LOGGED_OUT;
    }
}

QtLibSpotify::QtLibSpotify()
{
    //emit spotifyLogin(username, password);


}

QtLibSpotify::~QtLibSpotify()
{

}

int QtLibSpotify::initSpotify(QString username, QString password){

    sp_session_config config;
    memset(&config, 0, sizeof(config));
    sp_error error;
    sp_error login_error;
    //sp_session *session;
    sp_search *res;

    qDebug() << "AppKey:" << g_appkey;

    config.api_version=SPOTIFY_API_VERSION;

    config.cache_location= "tmp";
    config.settings_location="tmp";
    //config.proxy="193.235.32.164";
    config.application_key = g_appkey;
    qDebug() << g_appkey;
    config.application_key_size = sizeof(g_appkey);
    qDebug() << sizeof(g_appkey);

    config.user_agent = USER_AGENT;
    config.callbacks = &callbacks;

    //FUCK PROXIES
    config.proxy = 0x0;
    config.proxy_password=0x0;
    config.proxy_username=0x0;
   // config.device_id= getDevice_ID();


    qDebug()<< "initSpotify: Session_create result: " << (error = sp_session_create(&config, &session));
    if(SP_ERROR_OK != error) {
        qDebug() << "Spotify: failed to create session" << sp_error_message(error);
        return 2;
    } else {
        login_error = spotifyLogin(username, password);
        if(SP_ERROR_OK != login_error){
            qDebug() << "Spotify: Login Error - " << sp_error_message(login_error);
        } else {
            qDebug() <<"Spotify: Login Message - " << sp_error_message(login_error);
            //res = searchSpotify(session, "Bruno Mars");
            //qDebug() << "number of search results " << sp_search_total_tracks(res);

        }


    }

}

sp_search *QtLibSpotify::searchSpotify(sp_session *session, QString searchQuery){
    qDebug() << "Spotify: searchSpotify request";

    const char* strQuery = convertToString(searchQuery);
    qDebug() << "searching for - " << strQuery;
    return sp_search_create(session, strQuery, 0, 10, 0, 10, 0, 10, 0, 10, SP_SEARCH_STANDARD, &search_complete, NULL);
}

void QtLibSpotify::playSongSpotify(sp_session *session, sp_track* track){
    sp_error error = sp_session_player_load(session, track);
    if(SP_ERROR_OK != error){
        qDebug() << "Spotify: Loading " <<sp_error_message(error);
    }
    else{
        sp_session_player_play(session, 1);
    }
}

bool QtLibSpotify::isLoggedIn(){
    bool isloggedin = (NULL != session) && (GetConnectionState());
}


/*
 * Public Slots
 *
 */
sp_error QtLibSpotify::spotifyLogin(QString username, QString password){
    qDebug() << "spotifyLogin Signal was picked up";
    sp_error spotifyLoginError;
    const char* strUsername = convertToString(username);
    const char* strPassword = convertToString(password);
    //qDebug() << "Spotify: try relogin - " << sp_session_relogin(user_session);
    spotifyLoginError = sp_session_login(session, strUsername, strPassword, 1, NULL);
    qDebug() <<"Spotify: try login - " << sp_error_message(spotifyLoginError);
    return spotifyLoginError;
}

sp_error QtLibSpotify::spotifyLogout(sp_session *user_session){
    qDebug() << "spotifyLogout Signal was picked up";
    return sp_session_logout(user_session);
}

void QtLibSpotify::search(QString searchString){
    res = searchSpotify(session, searchString);
    qDebug() << "Spotify search: Number of search results - " << sp_search_total_tracks(res);
    //return res;

}

sp_error QtLibSpotify::releaseSpotifySession(sp_session *user_session){
    sp_error release_error;
    release_error = sp_session_release(user_session);
    qDebug() << "Spotify: TRY releasing session - " << sp_error_message(release_error);
}

sp_error QtLibSpotify::closing(){
    emit releaseSpotifySession(session);
}

