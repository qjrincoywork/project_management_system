import Auth from './Auth'
import UserController from './UserController'
import ProjectController from './ProjectController'
import TaskController from './TaskController'
import Settings from './Settings'

const Controllers = {
    Auth: Object.assign(Auth, Auth),
    UserController: Object.assign(UserController, UserController),
    ProjectController: Object.assign(ProjectController, ProjectController),
    TaskController: Object.assign(TaskController, TaskController),
    Settings: Object.assign(Settings, Settings),
}

export default Controllers