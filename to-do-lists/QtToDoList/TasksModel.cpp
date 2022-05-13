#include "TasksModel.h"
#include <QDebug>
#include <QJsonObject>

TasksModel::TasksModel(QObject *parent)
{

}

QHash<int, QByteArray> TasksModel::roleNames() const
{
    return {
        { IdTaskRole, "id" },
        { TitleTaskRole, "title" },
    };
}

QVariant TasksModel::data(const QModelIndex &index, int role) const
{
    if (!hasIndex(index.row(), index.column(), index.parent())) {
        return {};
    }

    const auto task = m_tasks.at(index.row());

    switch (role) {
    case IdTaskRole:
        return task.id;
    case TitleTaskRole:
        return task.title;
    }

    return {};
}

int TasksModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid()) {
        return 0;
    }

    return m_tasks.count();
}

void TasksModel::synchronize(const QVariantList &tasks)
{
    auto containsTask = [this](const QString &id) {
      for (const auto &task : m_tasks) {
          if (task.id == id) {
              return true;
          }
      }
      return false;
    };

    for (const auto &task : tasks) {
        const auto &jsonTaskObject = task.toJsonObject();
        const QString &id = jsonTaskObject["id"].toString();
        const QString &taskTitle = jsonTaskObject["task"].toString();

        if (!containsTask(id)) {
            beginInsertRows(QModelIndex(), m_tasks.count(), m_tasks.count());
            m_tasks << Task{id, taskTitle};
            endInsertRows();
        }
    }

    // could be improved with removing the local tasks what were not present on web
}

void TasksModel::onTaskRemoved(const QString &id)
{
    qDebug() << "onTaskRemoved " << id;
    for (int i = 0; i < m_tasks.count(); ++i) {
        const auto &task = m_tasks[i];
        if (task.id == id) {
            qDebug() << "found that task";
            beginRemoveRows(QModelIndex(), i, i);
            m_tasks.removeAt(i);
            endRemoveRows();
            return;
        }
    }
}
