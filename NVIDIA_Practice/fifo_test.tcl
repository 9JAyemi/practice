analyze -sv fifo.v

elaborate -top fifo

clock clk
reset !rst_n


#check for rst_n working
assert {!rst_n |-> ##1 (w_ptr == 0)}
assert {!rst_n |-> ##1 (r_ptr == 0)}
assert {!rst_n |-> ##1 (data_out == 0)}

# when full if write is enabled  count value shouldnt change
# when empty if read is enabled count value shouldnt change
assert {full && w_en && !r_en |-> ##1 $stable(count)}
assert {empty && r_en && !w_en |-> ##1 $stable(count)}

# Set the time limit to 1 hour (3600 seconds)
set_prove_time_limit 3600
set_engine_mode Tri
prove -all