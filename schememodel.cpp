#include "schememodel.h"

schemeModel::schemeModel(QObject *parent) : QSqlQueryModel(parent)
{

}

QVariant schemeModel::data(const QModelIndex &index, int role) const
{
    int columnId = role - Qt::UserRole - 1;
    QModelIndex modelIndex = this->index(index.row(), columnId);
    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);

}

void schemeModel::updateModel()
{
    QString str;
    str.append("SELECT type,name FROM sqlite_master WHERE type='table';");
    this->setQuery(str,QSqlDatabase::database("MainDB"));
    qDebug()<<query().lastQuery();
    qDebug()<<query().lastError();
    qDebug()<<this->rowCount();
}

QHash<int, QByteArray> schemeModel::roleNames() const
{
    QHash<int,QByteArray> roles;
    roles[ID] = "type";
    roles[Name] = "name";
    return roles;
}
