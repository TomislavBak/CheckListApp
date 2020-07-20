#include "checklistmodelsub.h"



// This class displays the embedded list of items that are created in the application
// you can add and remove items.
CheckListModelSub::CheckListModelSub(QObject *parent)
    : QAbstractListModel(parent)
{
}

// Override of the virtual function rowCount, it gives the model information on how
// many rows it should display, that is the lenght of the main list itself mList.size().

int CheckListModelSub::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;


    return mList.size();
}

// Override of the virtual function data, added rolenames :
// 1. DoneRole - if the item is checked returns true
// 2. DescriptionRole - returns the description of the selected item

QVariant CheckListModelSub::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() >= mList.count())
        return QVariant();

    // FIXME: Implement me!
    const ToDoCheckList todolist = mList.at(index.row());
    if (role == DoneRole)
        return todolist.getDoneCheck();
    else if (role == DescriptionRole)
        return todolist.getDescriptionCheck();

    return QVariant();
}

// Function roleNames implements the names of the roles that are used to access
// the data in the .qml files.

QHash<int, QByteArray> CheckListModelSub::roleNames() const
{
    QHash<int,QByteArray>roles;
    roles[DoneRole] = "doneCheck";
    roles[DescriptionRole] = "descriptionCheck";
    return roles;
}

// Setter function for the counter for the items that are not done.
void CheckListModelSub::setNotDoneCounter(int count)
{
    notDoneCounter = count;
}
// Function filterItem, the items of the embedded list are mapped in a MultiMap by the ID provided from the
// main list model, when a item from the main list is selected this function filters the
// values from the embedded list by the key(ID) provided by the main list item, and stores
// the values in the list that is going to be presented.
// Also every item is checked if it is done, and if true the counter is updated and the final
// value is stored in notDoneCounter with the function setNotDoneCounter().
// The model is also resseted.

void CheckListModelSub::filterItem(int row)
{
    int counter = 0;
    beginResetModel();
    QMultiMap<int,ToDoCheckList>::iterator i = mCheck.find(row);
    QList<ToDoCheckList> newList;
    while (i != mCheck.end() && i.key() == row) {
        if(i.key()==row){
            newList<<i.value();
            if(i.value().getDoneCheck()==false)
                counter ++;}
        ++i;
    }
    setNotDoneCounter(counter);

     beginInsertRows(QModelIndex(), 0, mCheck.count()-1);
    mList = newList;


    endInsertRows();
    endResetModel();
}

// Function addItemIndex, adds a new item to the embedded list and it is mapped by the
// row(ID) provided by the main list.

void CheckListModelSub::addItemIndex(int row, QString Description, bool Done)
{
    ToDoCheckList item(Description,Done);
    mCheck.insert(row,item);
}

// Funcion clearList, when a embedded list is no longer required to be viewed
// the list that is shown by the model is cleared and ready for the next embedded list.
// The model is resseted.

void CheckListModelSub::clearList()
{

    beginResetModel();

    resizeList(mList.size());
    beginRemoveRows(QModelIndex(),0,mList.size());

    mList.clear();

    endRemoveRows();
    endResetModel();
}

// Function setCheck, toggles the if the item is done .

void CheckListModelSub::setCheck(int row)
{
    beginResetModel();
    if(mList[row].getDoneCheck()){
        mList[row].setDoneCheck(false);
    }
    else{
        mList[row].setDoneCheck(true);
    }

    endResetModel();

}
// Function newDescription, replaces the old description with the new one
// after that the model is reseted to load the new name.

void CheckListModelSub::newDescription(int row,QString Description)
{
    beginResetModel();
    mList[row].setDescriptionCheck(Description);
    endResetModel();
}

// Function deleteItem, the selected item is removed from the model list
// that is shown by the model and not from the main list where all the lists are
// stored.

void CheckListModelSub::deleteItem(int row,QString description)
{
    beginRemoveRows(QModelIndex(),row,row);
    QMutableListIterator<ToDoCheckList> i(mList);
    while (i.hasNext()) {

        if(i.next().getDescriptionCheck()==description){
            i.remove();
        }
    }
    endRemoveRows();
}

// Setter function for the index value.

void CheckListModelSub::setIndex(int index)
{
    mList[index].setPlaceListIndexCheck(index);
}

// Function saveList, the model list that is shown on the frontend is saved
// in the main list of the model, saving new descriptions, checked items, deleted items etc.

void CheckListModelSub::saveList(int id)
{
    QMultiMap<int,ToDoCheckList>::iterator i = mCheck.find(id);
    int j = 0;
    while (i != mCheck.end() && i.key() == id) {
        i.value().setDoneCheck(mList[j].getDoneCheck());
        QString newDesc = mList[j].getDescriptionCheck();
        i.value().setDescriptionCheck(newDesc);


        ++i;
        ++j;}

}


// Function deleteMainList, deletes item from the main list.
void CheckListModelSub::deleteMainList(int id, QString description)
{
    QMultiMap<int,ToDoCheckList>::iterator iter = mCheck.find(id);
     while (iter != mCheck.end() && iter.key() == id)
     {
        if(iter.value().getDescriptionCheck() == description)
         mCheck.erase(iter);
         iter++;
     }
}

// Getter function for the notDoneCounter.

int CheckListModelSub::getNotDoneCoutner() const
{
    return notDoneCounter;
}

// Function get, returns the role of the accessed item based on the index(row)
// that is entered.

QVariantMap CheckListModelSub::get(int row)
{
    QHash<int,QByteArray> names = roleNames();
        QHashIterator<int, QByteArray> i(names);
        QVariantMap res;
        while (i.hasNext()) {
            i.next();
            QModelIndex idx = index(row, 0);
            QVariant data = idx.data(i.key());
            res[i.value()] = data;
        }
        return res;
}



//*************************** Containter Class ***************************************************
ToDoCheckList::ToDoCheckList(QString &Description, bool Done):mDescriptionCheck(Description),mDoneCheck(Done)
{

}

void ToDoCheckList::setDescriptionCheck(QString &Description)
{
    mDescriptionCheck = Description;
}

void ToDoCheckList::setDoneCheck(bool Done)
{
    mDoneCheck = Done;
}

void ToDoCheckList::setPlaceIndexCheck(int index)
{
    mPlaceIndexCheck = index;
}

void ToDoCheckList::setPlaceListIndexCheck(int index)
{
    mPlaceListIndexCheck = index;
}

QString ToDoCheckList::getDescriptionCheck() const
{
    return mDescriptionCheck;
}

bool ToDoCheckList::getDoneCheck() const
{
    return mDoneCheck;
}

int ToDoCheckList::getPlaceIndexCheck()
{
    return mPlaceIndexCheck;
}

int ToDoCheckList::getPlaceListIndexCheck()
{
    return mPlaceListIndexCheck;
}


void CheckListModelSub::resizeList( int newSize)
{
    int diff = newSize - mList.size();
      if (diff < 0) mList.erase(mList.end() + diff, mList.end());

}
