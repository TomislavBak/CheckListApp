 #ifndef CHECKLISTMODELSUB_H
#define CHECKLISTMODELSUB_H

#include <QAbstractListModel>


class ToDoCheckList{
public:
    ToDoCheckList(QString&,bool);


    void setDescriptionCheck(QString&);
    void setDoneCheck(bool);
    void setPlaceIndexCheck(int);
    void setPlaceListIndexCheck(int);

    QString getDescriptionCheck()const;
    bool getDoneCheck()const;
    int getPlaceIndexCheck();
    int getPlaceListIndexCheck();


private:
    QString mDescriptionCheck;
    bool mDoneCheck;
    int mPlaceIndexCheck;
    int mPlaceListIndexCheck;
};


class CheckListModelSub : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit CheckListModelSub(QObject *parent = nullptr);
    enum{
        DoneRole = Qt::UserRole +1,
        DescriptionRole
    };
    //CheckListModelSub(const CheckListModelSub &copyofCheck);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    virtual QHash<int, QByteArray> roleNames() const override;

    void setNotDoneCounter(int count);


     Q_INVOKABLE QVariantMap get(int row);
     Q_INVOKABLE void filterItem(int row); // function for adding data
     Q_INVOKABLE void addItemIndex(int row,QString Description,bool Done);
     Q_INVOKABLE void clearList();
     Q_INVOKABLE void setCheck(int row);
     Q_INVOKABLE void newDescription(int row,QString Description);
     Q_INVOKABLE void deleteItem(int row,QString description);
     Q_INVOKABLE void setIndex(int index);
     Q_INVOKABLE void saveList(int id);
     Q_INVOKABLE void deleteMainList(int id,QString description);
     Q_INVOKABLE int getNotDoneCoutner()const;

    void resizeList( int newSize);



private:
    QList<ToDoCheckList>mList;
    QMultiMap<int,ToDoCheckList>mCheck;
    int notDoneCounter = 0;

};

#endif // CHECKLISTMODELSUB_H
