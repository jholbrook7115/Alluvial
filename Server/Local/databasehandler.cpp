#include "databasehandler.h"

DatabaseHandler::DatabaseHandler()
{

}

DatabaseHandler::~DatabaseHandler()
{

}

/*!
 * \brief ripMetaData: This function takes the QString representing a song in the file directory
 * \                    and returns a meta data struct using taglib
 * \param file We pass this function one QString representing a song in the file system
 * \return The function returns a struct containing the meta data for the song.
 */
MD DatabaseHandler::ripMetaData(QString file)
{
    MD md;

    TagLib::FileRef f(QFile::encodeName(file).constData());
    //Grab meta data and convert to QStrings and uints
    QString artist = QString::fromStdString(f.tag()->artist().to8Bit(true));
    QString album = QString::fromStdString(f.tag()->album().to8Bit(true));
    QString title = QString::fromStdString(f.tag()->title().to8Bit(true));
    QString genre = QString::fromStdString(f.tag()->genre().to8Bit(true));
    uint year = f.tag()->year();
    uint track = f.tag()->track();

    TagLib::AudioProperties *properties = f.audioProperties();

    int length_sec = properties->length() % 60;
    int length_min = (properties->length() - length_sec) / 60;
    //place data in struct
    md.album = album;
    md.artist = artist;
    md.title = title;
    md.filepath = file;
    md.length_sec = length_sec;
    md.length_min = length_min;
    md.PKID = year;
    md.track_num = track;
    md.genre = genre;

    return md;
}
/*!
 * \brief This function is passed a filePath and checks to see if it is a
 * \      legal music file.
 * \param file the param contains a QString representation of a file path
 * \return returns true is
 */
bool DatabaseHandler::isMusic(const QString file)
{
    //Check to make sure the files are legal to add to database
    QMimeDatabase *db = new QMimeDatabase();
    QMimeType Mtype = db->mimeTypeForFile(file,QMimeDatabase::MatchDefault);
    QString QType = Mtype.name();
    string SType = QType.toStdString();
    //can add supported types
    const string supportedTypes[] = {"/mpeg"};
    int STypeInt = SType.length();
    int supportedTypesInt = supportedTypes[0].length();
    //std::cout << SType << "\n" << supportedTypes[0];
    if(STypeInt >= supportedTypesInt) {
        return (0 == SType.compare(STypeInt - supportedTypesInt, supportedTypesInt, supportedTypes[0]));
    } else {
        return false;
    }
}
/*!
 * \brief D Function inits a database and populates it.
 * \return Returns true if successful, false otherwise
 */
bool DatabaseHandler::DBInit()
{
    bool openResult;
    bool tableResult;
    QDir dir("/home/moe/Desktop/pullSongs");
    openResult = openDB();
    tableResult = createTable();
    std::cout << openResult << "\n";
    std::cout << tableResult << "\n";
    DBpopulate(dir);
    return true;
}
/*!
 * \brief  Function opens the database in user home directory
 * \return returns if the database was opened successfully
 */
bool DatabaseHandler::openDB()
{
    // Find QSLite driver
    db = QSqlDatabase::addDatabase("QSQLITE");

    #ifdef Q_OS_LINUX
    // NOTE: We have to store database file into user home folder in Linux
    QString path(QDir::home().path());
    path.append(QDir::separator()).append("my.db.sqlite");
    path = QDir::toNativeSeparators(path);
    db.setDatabaseName(path);
    #else
    // NOTE: File exists in the application private folder, in Symbian Qt implementation
    db.setDatabaseName("my.db.sqlite");
    #endif
    query = QSqlQuery(db);
    // Open databasee
    return db.open();
}
/*!
 * \brief creates the table to store all metadata for songs.
 * \return returns if table was created successfully
 */
bool DatabaseHandler::createTable()
{
    bool ret = false;
    //clear previous usage of query, can cause out of memory if not done
    query.clear();
    if (db.isOpen()){
        query.exec("create table Alluvial "
                          "(id integer primary key, "
                          "title varchar(30), "
                          "artist varchar(30), "
                          "album varchar(30), "
                          "genre varchar(30), "
                          "filepath varchar(30), "
                          "tracknum integer, "
                          "year integer, "
                          "length_min integer, "
                          "length_sec integer)");
    }
    query.clear();
    if (db.isOpen()){
        query.exec("create table Playlist "
                          "(id integer primary key, "
                          "name varchar, "
                          "db_pkid varchar, "
                          "sc_urls varchar, "
                          "sp_uris varchar)");
    }
    //check to make sure tables created
    std::cout << query.lastError().text().toStdString();

    return ret;
}
/*!
 * \brief Runs iterator function to grab all the metadata from the given directory
 * \param dir allows you to pick which directory to iterate through to get songs
 */
void DatabaseHandler::DBpopulate(QDir dir)
{

    QDirIterator it(dir, QDirIterator::Subdirectories);
    bool ret = false;
    if(db.open())
        while (it.hasNext()) {
            //TODO: Check database for redundant entries[
            QString file(dir.absoluteFilePath(it.next()));
            if(isMusic(file)){
              MD md;
              //grab metadata struct and fill it with the next songs metadata
              md = ripMetaData(file);
              //place in database
              ret = query.exec(QString("insert into Alluvial values(NULL,'%1','%2','%3','%4','%5', %6, %7, %8, %9)")
              .arg(md.title).arg(md.artist).arg(md.album).arg(md.genre).arg(md.filepath).arg(md.track_num)
              .arg(md.PKID).arg(md.length_min).arg(md.length_sec));

              //qDebug() << md.title << ret << "\n";
              //qDebug() << query.lastError().text();

            }
        }
}

/*!
 * \brief DatabaseHandler::queryDB searches db and returns all relavent results for search string. Searches artist, album and title
 * \param query search query as QString
 * \return returns MD struct vector with all results
 */
std::vector <MD> DatabaseHandler::queryDB(QString query)
{
    std::vector <MD> MDresult;
    QSqlQuery sqlquery(QString("SELECT * FROM Alluvial WHERE title LIKE '%1%'"
                                                        "OR artist LIKE '%1%'"
                                                        "OR album LIKE '%1%'").arg(query));
    while(sqlquery.next())
    {
        MD md;
        md.title = sqlquery.value(1).toString();
        md.artist = sqlquery.value(2).toString();
        md.album = sqlquery.value(3).toString();
        md.genre = sqlquery.value(4).toString();
        md.track_num = sqlquery.value(6).toInt();
        md.length_min = sqlquery.value(8).toInt();
        md.length_sec = sqlquery.value(9).toInt();
        md.PKID = sqlquery.value(0).toInt();
        MDresult.insert(MDresult.end(),md);

    }


    return MDresult;
}
/*!
 * \brief DatabaseHandler::getSongFP looks through DB to get filepath of where song is
 * \param PKID int representing where the song is in the DB
 * \return file path where song is
 */
QString DatabaseHandler::getSongFP(int PKID)
{
    QString FP;
    QSqlQuery songFPQuery(QString("SELECT * FROM Alluvial WHERE ID = '%1'").arg(PKID));

    while(songFPQuery.next()){
        FP = songFPQuery.value(5).toString();
    }

    return FP;

}



