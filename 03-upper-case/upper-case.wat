(module
 (import "env" "memory"
         (memory $mem 1))

 (export "toUpperCase" (func $toUpperCase))

 (global $UPPER_OFFSET i32 (i32.const 32))
 (global $LOWERCASE_A i32 (i32.const 97))
 (global $LOWERCASE_Z i32 (i32.const 122))

 (func $toUpperCase (param $index i32) (param $length i32)
       (local $currentCharacter i32)
       (local $maxIndex i32)
       (set_local $maxIndex (i32.add (get_local $index)
                                (get_local $length)))

       (block $break
        (loop $top
         (set_local $currentCharacter (i32.load8_s (get_local $index)))

         ;; Upcase character if it is lower case
         (if (call $isLowerCase (get_local $currentCharacter))
             (then (i32.store8 (get_local $index)
                               (i32.sub (get_local $currentCharacter)
                                        (get_global $UPPER_OFFSET)))))

         ;; Increment index
         (set_local $index (i32.add (get_local $index)
                                    (i32.const 1)))

         ;; Break out of loop when we've processed all characters
         (br_if $break (i32.ge_s (get_local $index)
                                 (get_local $maxIndex)))
         ;; Go to top of the loop
         (br $top))))

 (func $isLowerCase (param $char i32) (result i32)
       (i32.and (i32.ge_s (get_local $char)
                          (get_global $LOWERCASE_A))
                (i32.le_s (get_local $char)
                          (get_global $LOWERCASE_Z)))))
