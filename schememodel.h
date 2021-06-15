#ifndef SCHEMEMODEL_H
#define SCHEMEMODEL_H

#include <QObject>
#include "mq.h"
#include <QSqlQueryModel>
#include <QSqlRecord>
#include <QSqlField>

class schemeModel : public QSqlQueryModel
{
    Q_OBJECT
public:
    explicit schemeModel(QObject *parent = nullptr);

    enum Roles{
        ID=Qt::UserRole+1,
        Name
    };
signals:
    void emitUpdate();

public slots:
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const ;
    void updateModel();


protected:
     QHash<int,QByteArray> roleNames() const;
};

#endif // SCHEMEMODEL_H
