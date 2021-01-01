import SwiftInternal

@_silgen_name("my_task_runAndBlockThread")
public func myRunAsyncAndBlock(_ asyncFun: @escaping () async -> ())

func fib(_ n: Int) -> Int {
    var first = 0
    var second = 1
    for _ in 0..<n {
        let temp = first
        first = second
        second = temp + first
    }
    return first
}

func asyncFib(_ n: Int) async -> Int {
  if n == 0 || n == 1 {
    return n
  }

  let first = Task.runDetached { () -> Int in
    return await asyncFib(n - 2)
  }

  let second = Task.runDetached { () -> Int in
    return await asyncFib(n - 1)
  }

  let result = await try! first.get() + second.get()

  return result
}

func runFibonacci(_ n: Int) {
  var result = 0
  myRunAsyncAndBlock {
    result = await asyncFib(n)
  }

  print()
  print("Async fib = \(result), sequential fib = \(fib(n))")
  assert(result == fib(n))
}
swiftInstallConcurrencyEnqueueHook()
runFibonacci(6)




