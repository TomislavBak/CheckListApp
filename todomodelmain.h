#ifndef TODOMODELMAIN_H
#define TODOMODELMAIN_H

#include <QAbstractListModel>
#include<QVector>

#include"checklistmodelsub.h"





class ToDoList{
public:
    ToDoList(QString&,QString&,bool,int);
    void setName(QString&);
    void setDescription(QString&);
    QString getName()const;
    QString getDescription()const;
    int getID()const;
    bool getDone()const;
    int getIndex()const;
    void setmIndex(int);
    int notDoneLeft=0;
private:
    QString mName;
    QString mDescription;
    bool mDone;
    int mID;
    int placeIndex;

};

class ToDoModelMain : public QAbstractListModel
{
    Q_OBJECT


public:
    explicit ToDoModelMain(QObject *parent = nullptr);
    enum{
        DoneRole = Qt::UserRole+1,
        DescriptionRole,
        NameRole,
        IDRole,
        NotDoneLeftRole,
        DoneItemsRole
    };


    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    virtual QHash<int, QByteArray> roleNames() const override;

    static int counterID;


    Q_INVOKABLE void addList(QString ,QString ); // function for adding data
    Q_INVOKABLE QVariantMap get(int row);
    Q_INVOKABLE void deleteItem(int row);
    Q_INVOKABLE void newName(int row,QString);
    Q_INVOKABLE void newDescription(int row,QString);
    Q_INVOKABLE void setIndex(int);
    Q_INVOKABLE int getIndex(int)const;
    Q_INVOKABLE void setNotDone(int row,int value);
    static int setedIndex;



private:
    QList<ToDoList> mList;




};

#endif // TODOMODELMAIN_H
