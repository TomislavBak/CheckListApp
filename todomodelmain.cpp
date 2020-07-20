#include "todomodelmain.h"
// This class displays the main list of items that are created in the application
// you can add and remove items.

ToDoModelMain::ToDoModelMain(QObject *parent)
    : QAbstractListModel(parent)
{
}
int ToDoModelMain::setedIndex = 0;
int ToDoModelMain::counterID = 0;

// Override of the virtual function rowCount, it gives the model information on how
// many rows it should display, that is the lenght of the main list itself mList.count().

int ToDoModelMain::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;


    return mList.count();
}

// Override of the virtual function data, added rolenames :
// 1. NameRole - the name of the list element
// 2. DescriptionRole - description for the list element
// 3. DoneRole - if all the elements in the embedded list are done reutrns true
// 4. IDRole - unique ID for each element, on which all the items in the embedded list are mapped
// 5. NotDoneLeftRole - returns how many items are not done in the embedded list
// 6. DoneItemsRole - returns the name of the main list item if it is done

QVariant ToDoModelMain::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() >= mList.count())
        return QVariant();


    const ToDoList &todolist = mList[index.row()];
    if (role == NameRole)
        return todolist.getName();
    else if (role == DescriptionRole)
        return todolist.getDescription();
    else if (role == DoneRole)
        return todolist.getDone();
    else if(role == IDRole)
        return todolist.getID();
    else if(role== NotDoneLeftRole)
        return todolist.notDoneLeft;
    else if(role == DoneItemsRole && todolist.notDoneLeft == 0)
        return todolist.getName();
    return QVariant();
}

// Function roleNames implements the names of the roles that are used to access
// the data in the .qml files.

QHash<int, QByteArray> ToDoModelMain::roleNames() const
{
    QHash<int,QByteArray>roles;
    roles[DoneRole] = "done";
    roles[DescriptionRole] = "description";
    roles[NameRole] = "name";
    roles[IDRole] = "id";
    roles[NotDoneLeftRole] = "notdone";
    roles[DoneItemsRole] = "doneitems";
    return roles;
}

// Function addList , adds a new item to the list with Name,Description
// the counter for the ID is updated for the next element, the done is set
// to false.

void ToDoModelMain::addList(QString Name,QString Description)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    counterID++;
    ToDoList newItem(Name,Description,false,counterID);
    mList << newItem;
    endInsertRows();
}

// Function get, returns the role of the accessed item based on the index(row)
// that is entered.

QVariantMap ToDoModelMain::get(int row)
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
// Function deleteItem , deletes the item of the seleceted row.
void ToDoModelMain::deleteItem(int row)
{
    beginRemoveRows(QModelIndex(),row,row);
    QMutableListIterator<ToDoList> i(mList);
    while (i.hasNext()) {
        if(i.next().getIndex()==row)
            i.remove();
    }
    endRemoveRows();

}
// Function newName, replaces the old name with the new name
// after that the model is reseted to load the new name.
void ToDoModelMain::newName(int row,QString newname)
{
    beginResetModel();
        mList[row].setName(newname);
    endResetModel();
}

// Function newDescription, replaces the old description with the new one
// after that the model is reseted to load the new name.
void ToDoModelMain::newDescription(int row, QString newdescription)
{
    beginResetModel();
        mList[row].setDescription(newdescription);
    endResetModel();
}
// Setter function for setting current index to the current item
void ToDoModelMain::setIndex(int Index)
{
    if(setedIndex == 0)
    mList[Index].setmIndex(Index);

}
// Getter function for getting the index of the current item
int ToDoModelMain::getIndex(int Index) const
{
    return mList[Index].getIndex();
}
// Function setNotDone is setting how many items of the embedded list are not done
void ToDoModelMain::setNotDone(int row, int value)
{
    beginResetModel();
    mList[row].notDoneLeft = value;
    endResetModel();
}


//************** Containter Class **************************
ToDoList::ToDoList(QString &Name, QString &Description, bool Done, int ID):mName(Name),mDescription(Description),mDone(Done),mID(ID){}

void ToDoList::setName(QString &Name)
{
    mName = Name;
}

void ToDoList::setDescription(QString &Description)
{
    mDescription = Description;
}

QString ToDoList::getName() const
{
    return mName;
}

QString ToDoList::getDescription() const
{
    return mDescription;
}

int ToDoList::getID() const
{
    return mID;
}

bool ToDoList::getDone() const
{
    return mDone;
}

int ToDoList::getIndex() const
{
    return placeIndex;
}

void ToDoList::setmIndex(int Index)
{
 placeIndex = Index;
}
//***********************************************************************
