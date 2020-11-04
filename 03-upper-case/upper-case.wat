(module
 (import "env" "memory"
         (memory $mem 1))

 (export "toUpperCase" (func $toUpperCase))

 (global $UPPER_OFFSET i32 (i32.const 32))
 (global $LOWERCASE_A i32 (i32.const 97))
 (global $LOWERCASE_Z i32 (i32.const 122))

 (func $toUpperCase (param $index i32) (param $length i32)
       (local $curChar i32)
       (local $max i32)
       (set_local $max (i32.add (get_local $index)
                                (get_local $length)))

       (block $break
        (loop $top
         (set_local $curChar (i32.load8_s (get_local $index)))

         (if (call $isLowerCase (get_local $curChar))
             (then (i32.store8 (get_local $index)
                               (i32.sub (get_local $curChar)
                                        (get_global $UPPER_OFFSET)))))

         (set_local $index (i32.add (get_local $index)
                                    (i32.const 1)))

         (br_if $break (i32.ge_s (get_local $index)
                                 (get_local $max)))

         (br $top))))

 (func $isLowerCase (param $char i32) (result i32)
       (i32.and (i32.ge_s (get_local $char)
                          (get_global $LOWERCASE_A))
                (i32.le_s (get_local $char)
                          (get_global $LOWERCASE_Z)))))
