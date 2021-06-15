#ifndef MQ_H
#define MQ_H

#include <QObject>
#include <QSqlQueryModel>
#include <QSqlRecord>
#include <QSqlField>
#include <QSqlQuery>
#include <QDebug>
#include <QSqlError>

class MQ : public QSqlQueryModel
{
    Q_OBJECT
    QSqlDatabase daba;

public:
    using QSqlQueryModel::QSqlQueryModel;
    explicit MQ(QObject *parent = nullptr);
    Q_PROPERTY(QString query READ queryStr WRITE setQueryStr NOTIFY queryStrChanged)
    Q_PROPERTY(QStringList userRoleNames READ userRoleNames CONSTANT)

    QHash<int, QByteArray> roleNames() const;

    QVariant data(const QModelIndex &index, int role) const;

    QString queryStr() const;

    QStringList userRoleNames() const;


signals:

    void queryStrChanged();

public slots:
    void setQueryStr(const QString &query);
    bool connection(QString path);

};

#endif // MQ_H
