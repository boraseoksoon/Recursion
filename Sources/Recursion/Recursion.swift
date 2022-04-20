import Foundation

public struct Recursion {
    
    /// Generate `a growing closure` to keep track of the all of history of task, and
    /// run a function as a given parameter after executing all of previous tasks if tasks exist, and add the function to the tasks.
    /// - Returns: `the growing closure` to remember the tasks to execute.
    ///
    /// ```
    /// let recur = Recursion.generateGrowingClosure()
    ///
    /// recur { print("1") }
    /// print("***")
    /// recur { print("2") }
    /// print("***")
    /// recur { print("3") }
    /// print("***")
    /// recur { print("4") }
    ///
    /// // 1
    /// // ***
    /// // 1
    /// // 2
    /// // ***
    /// // 1
    /// // 2
    /// // 3
    /// // ***
    /// // 1
    /// // 2
    /// // 3
    /// // 4
    /// ```
    public static func generateGrowingClosure() -> ((() -> Void)?) -> () {
        let q = DispatchQueue(label: "recursion.generated.static")
        var tasks: [(() -> ())?] = []
        
        return { task in
            q.sync {
                tasks.append(task)
                tasks.forEach { $0?() }
            }
        }
    }
    
    /// Generate a closure to keep track of a base task to grow(optional),
    /// running them no matter when the closure is executed after which a function as a given parameter will be executed additionally.
    /// - Parameters:
    ///   - baseTask: the foundation of a task to run.
    ///   - willGrow: whether the base task will need to be executed one time more as executed or not.
    /// - Returns: the closure to remember the growing(optional) base task to be executed
    /// whenever the closure is executed.
    ///
    /// ```
    ///    let recur = Recursion.generateClosure(willGrow: true,
    ///                                          runningEverytime: { print("base task!") })
    ///
    ///    recur {
    ///        recur {
    ///            recur {
    ///                recur {
    ///                    print("yay!")
    ///                }
    ///            }
    ///        }
    ///    }
    ///
    /// // base task!
    /// // *
    /// // base task!
    /// // base task!
    /// // **
    /// // base task!
    /// // base task!
    /// // base task!
    /// // ***
    /// // base task!
    /// // base task!
    /// // base task!
    /// // base task!
    /// // ****
    /// // yay!
    ///
    /// ```
    public static func generateClosure(willGrow: Bool,
                                       runningEverytime baseTask: @escaping () -> Void)
    -> (( () -> Void)?) -> Void {
        var next = 0
        
        return { lastTask in
            next = willGrow ? next + 1 : 1
            
            _ = {
                (0...next).forEach { _ in baseTask() }
                lastTask?()
            }()
        }
    }
}
