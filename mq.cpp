#include "mq.h"

MQ::MQ(QObject *parent) : QSqlQueryModel(parent)
{

}

QString MQ::queryStr() const
{
    return query().lastQuery();
}

QStringList MQ::userRoleNames() const
{
    QStringList names;
    for (int i = 0; i < record().count(); i ++) {
        names << record().fieldName(i).toUtf8();
    }
    return names;
}

void MQ::setQueryStr(const QString &query)
{
    if(queryStr() == query)
        return;
    //this->setQuery(str,QSqlDatabase::database("MainDB"));
    setQuery(query,QSqlDatabase::database("MainDB"));
    emit queryStrChanged();
    // emit queryStrChanged(m_query);
}

QVariant MQ::data(const QModelIndex &index, int role) const
{
    QVariant value;
    if (index.isValid()) {
        if (role < Qt::UserRole) {
            value = QSqlQueryModel::data(index, role);
        } else {
            int columnIdx = role - Qt::UserRole - 1;
            QModelIndex modelIndex = this->index(index.row(), columnIdx);
            value = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
        }
    }
    return value;
}

QHash<int, QByteArray> MQ::roleNames() const
{
    QHash<int, QByteArray> roles;
    for (int i = 0; i < record().count(); i ++) {
        roles.insert(Qt::UserRole + i + 1, record().fieldName(i).toUtf8());
    }
    return roles;
}

bool MQ::connection(QString path)
{
    daba = QSqlDatabase::addDatabase("QSQLITE","MainDB");
    //first create a blank sqlite database with IODB name
    daba.setHostName("127.0.0.1");
    daba.setDatabaseName(path);

    if(!daba.open())
    {
        qDebug()<<"Database not open beacuse : "<<daba.lastError().text();
        return false;
    }
    else
    {
        qDebug()<<"The database open successfully";
        qDebug()<<"The databases worked finish";
        return true;
    }
}
