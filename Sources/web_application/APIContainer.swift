import Vapor

class ContainerAPI {
    var searchController: ControllerSearch {
        ControllerSearch()
    }
    var updateController: ControllerUpdate {
        ControllerUpdate()
    }
    var deleteController: ControllerDelete {
        ControllerDelete()
    }
}

extension Application {
    var containerAPI: ContainerAPI {
        .init()
    }
}
