import SwiftInternal

@_silgen_name("my_task_runAndBlockThread")
public func myRunAsyncAndBlock(_ asyncFun: @escaping () async -> ())

swiftInstallConcurrencyEnqueueHook()

import Dispatch

extension DispatchQueue {
    func async() async {
        await withUnsafeContinuation { (continuation: UnsafeContinuation<Void>) in
            print("200")
            async {
                print("400")
                print("resume")
                continuation.resume(returning: ())
                print("500")
            }
            print("300")
        }
    }
}

print("100")
myRunAsyncAndBlock {
    print("A")
    await DispatchQueue.global().async()
    sleep(10)
    print("B")
}
import Foundation
print("999")
