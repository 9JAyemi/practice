analyze -sv Vending_Machine.v

elaborate -top Vending_Machine

clock clk
reset reset


# check reset properties 
assert {reset |-> ##1 (Total_Amount = 0) & (dispense = 0)}

# check total amount properties
assert{coin_in = 2'b00 |-> ##1 Total_Amount = 5}
assert{coin_in = 2'b01 |-> ##1 Total_Amount = 10}
assert{coin_in = 2'b10 |-> ##1 Total_Amount = 25}
assert{coin_in = 2'b11 |-> ##1 Total_Amount = 100}

assume{$past(coin_in) == 2'b10}
assert{coin_in = 2'b11 |-> ##1 Total_Amount = 125}