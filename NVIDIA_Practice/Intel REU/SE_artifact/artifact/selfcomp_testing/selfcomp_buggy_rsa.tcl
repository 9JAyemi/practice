analyze -sva selfcomp_buggy_rsa.v

elaborate -top BuggyRSATester -bbox_mul 256

#specify clock and reset
clock clock
reset reset -non_resettable_regs 0

stopat se1.aes_invcipher.io_output_op1_*
stopat se1.aes_invcipher.io_output_op2_*
stopat se2.aes_invcipher.io_output_op1_*
stopat se2.aes_invcipher.io_output_op2_*

stopat se1._output_buffer_T
stopat se2._output_buffer_T

assume {se1._output_buffer_T == se2._output_buffer_T}

abstract -init_value {se1.d se2.d}

assert {oneValid -> bothValid}
assert {io_out_resultOne == io_out_resultTwo}

set_prove_time_limit 3600
prove -bg -all

set_engine_mode Tri