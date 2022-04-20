# Recursion
Data structure using recursion (POC for now)

# How to use

```swift

let recur = Recursion.generateGrowingClosure()

recur { print("1") }
print("***")
recur { print("2") }
print("***")
recur { print("3") }
print("***")
recur { print("4") }

// 1
// ***
// 1
// 2
// ***
// 1
// 2
// 3
// ***
// 1
// 2
// 3
// 4
```


```swift
let recur = Recursion.generateClosure(willGrow: true, runningEverytime: { print("base task!") })

recur {
    recur {
        recur {
            recur {
                print("yay!")
            }
        }
    }
}

// base task!
// *
// base task!
// base task!
// **
// base task!
// base task!
// base task!
// ***
// base task!
// base task!
// base task!
// base task!
// ****
// yay!
```
