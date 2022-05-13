#ifndef TASKSMODEL_H
#define TASKSMODEL_H

#include <QAbstractListModel>

struct Task {
    QString id   = "";
    QString title = "";
};

class TasksModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum TaskRole {
        IdTaskRole = Qt::UserRole + 1,
        TitleTaskRole
    };

    explicit TasksModel(QObject *parent = nullptr);

    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

public slots:
    void synchronize(const QVariantList &tasks);
    void onTaskRemoved(const QString &id);

private:
    QList<Task> m_tasks{};
};

#endif // TASKSMODEL_H
