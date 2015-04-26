#include "queryhandler.h"

queryhandler::queryhandler(QObject *parent)
{

}

queryhandler::~queryhandler()
{

}
/*!
 * \brief queryhandler::getResults gets the result QJsonArray
 * \param query query in a QString
 * \return QJsonArray result
 */
QJsonArray queryhandler::getResults(QString query)
{
    QJsonArray result;
    JSONHandler *mediaObject = new JSONHandler;

    result = mediaObject->generateResults(query);
    emit onSearchComplete(&result);
}

