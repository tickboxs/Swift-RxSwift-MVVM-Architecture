import UIKit

// Model
struct CheckModel {
    var time:String
    var feelingCheck:Bool
}

// Data
var checkDB =  [
 CheckModel(time: "Sunday, 7 Jun 2020", feelingCheck: false),
 CheckModel(time: "Monday, 8 Jun 2020", feelingCheck: true),
 CheckModel(time: "Wednesday, 10 Jun 2020", feelingCheck: true),
 CheckModel(time: "Wednesday, 10 Jun 2020", feelingCheck: true),
 CheckModel(time: "Wednesday, 10 Jun 2020", feelingCheck: false),
 CheckModel(time: "Wednesday, 10 Jun 2020", feelingCheck: true),
 CheckModel(time: "Wednesday, 10 Jun 2020", feelingCheck: false),
 CheckModel(time: "Wednesday, 10 Jun 2020", feelingCheck: false),
 CheckModel(time: "Wednesday, 10 Jun 2020", feelingCheck: true),
 CheckModel(time: "Wednesday, 10 Jun 2020", feelingCheck: false)]

// Need a dict to accmodate
var dict = [String : [CheckModel]]()

for checkModel in checkDB {
    if var checkModels = dict["\(checkModel.time)"] {
        checkModels.append(checkModel)
        dict["\(checkModel.time)"] = checkModels
    } else {
        var checkModels = [CheckModel]()
        checkModels.append(checkModel)
        dict["\(checkModel.time)"] = checkModels
    }
}

// convert dict to array
var checkModelsArray = [[CheckModel]](dict.values)

// check all true to false if there is at least one false
let finalCheckModels = checkModelsArray.map {
    $0.first(where: { $0.feelingCheck == false }) != nil ?
        $0.map { CheckModel(time: $0.time, feelingCheck: false) } :
        $0
}

print(finalCheckModels)
