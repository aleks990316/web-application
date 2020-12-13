import Vapor 
func routes(_ app: Application) throws {
    try app.register(collection: ControllerSearch())
    try app.register(collection: ControllerUpdate())
    try app.register(collection: ControllerDelete())
}