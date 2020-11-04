(module
 (import "env" "rand" (func $rand (result i32)))
 (import "env" "log" (func $log (param i32)))

 (func (export "logRandomNumber")
       call $rand
       call $log))
