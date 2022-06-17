#ifndef NOTIFICATIONWORKER_H
#define NOTIFICATIONWORKER_H

#include <QObject>
#include <QSslSocket>
#include <QTcpServer>

class NotificationWorker : public QTcpServer
{
    Q_OBJECT
    QSslSocket* socket =0;
public:
    explicit NotificationWorker(QObject *parent = nullptr);

signals:

};

#endif // NOTIFICATIONWORKER_H
