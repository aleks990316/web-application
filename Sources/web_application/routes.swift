import Vapor 
func routes(_ app: Application) throws {
    try app.register(collection: app.containerAPI.searchController)
    try app.register(collection: app.containerAPI.updateController)
    try app.register(collection: app.containerAPI.deleteController)
}