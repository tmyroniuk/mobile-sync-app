#ifndef NOTIFICATIONSERVER_H
#define NOTIFICATIONSERVER_H

#include <QTcpServer>
#include <QSslSocket>
#include <QFile>

class NotificationServer : QTcpServer
{
public:
    NotificationServer(QObject* parent =0);

    void incomingConnection(int handle);
};

#endif // NOTIFICATIONSERVER_H
