#include <QApplication>
#include <QQmlApplicationEngine>

#include "Server/server.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    Server *server = new Server();

    return app.exec();
}
