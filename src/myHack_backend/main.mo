import Buffer "mo:base/Buffer";
import Text "mo:base/Text";
import { toText } "mo:base/Nat";

actor TaskManager {

  type Task = {
    id : Nat;
    title : Text;
    description : Text;
    isYourTaskCompleted : Bool;
  };

  var taskDB = Buffer.Buffer<Task>(0);

  let DbHeaders = ["ID", "Title", "Description", "Task Status"];

  public func createTask(newTask: Task ) : async Text {
   
    let _ = taskDB.add(newTask);
    return "Task created successfully!";
  };

  // Function to list all tasks
  public query func listTasks() : async Text {
    var csvText = "";

    // Add headers to CSV text
    for (index in DbHeaders.keys()) {
      let header = DbHeaders[index];
      if (index == DbHeaders.size() - 1) {
        csvText #= header # "\n";
      } else {
        csvText #= header # ",";
      };
    };

    // Add tasks to CSV text
    let taskSnapshot = Buffer.toArray(taskDB);
    for (task in taskSnapshot.vals()) {
      csvText #= toText(task.id) # ",";
      csvText #= task.title # ",";
      csvText #= task.description # ",";

      let completed = if (task.isYourTaskCompleted == true) {
        "Task Completed";
      } else {
        "Pending";
      };

      csvText #= completed # "\n";

    };

    return csvText;
  };


}; 