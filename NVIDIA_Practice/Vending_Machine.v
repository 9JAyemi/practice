/*
A  soda  vending  machine  that  can  deliver  three  kinds  of  soda, A, B and C.  
All the three soda  cost  the  same  amount -70  cents.  
The  vending  machine  has  four  coin  slots,  one each  for nickel (N = 5c), dime (I = 10c), quarter (Q = 25c) and dollar (D = 100c). 
Coins are inserted into the machine one at a time in any order. The machine should take coins until 70 cents or more has been  put  in.  
When  this  occurs,  the  machine  should  wait  for  the choice  of  the  soda A, B or C. 
After the choice is made, the machine is ready for vending.
The  machine  should  indicate  vending  by  turning  on  one  of  the lines A_O, B_O or C_O for  1 second.  
During  this  time  the  machine  cannot  accept  any  coins.  After  1  second,  the machine  is ready to accept coins again. 
The machine does not return any change. The machine should be a Finite  State  Machine  (FSM)  operating  with a  100 Hz clock.  
The machine  should  have  a  reset input  (R),  which  when  pressed  and  released  puts  the  machine in  READY  mode.  
Whenever  this happens,  the  machine  should  display  the  total  amount accumulated  since  last  reset. 
Also,  the internal amount accumulated is reset to zero cents.
*/
//RTL

module Vending_Machine(A_o,B_o,C_o,Total_Amount,clk,rst,A,B,C,D,Q,I,N);

input clk,rst;
input D,Q,I,N;
input A,B,C;

output reg A_o,B_o,C_o;
output Total_Amount;

reg [1:0] ps,ns;
reg [6:0] count;
reg Lid;
reg [6:0]Total_Amount;


always@(posedge clk or posedge rst)
begin
	if(rst)
	  ps <= 2'b00;
 
	else
	  ps <= ns;
end

 
always@(ps or N or I or Q or D)
	case(ps)
	  2'b00:begin
				
				A_o <= 1'b0;
				B_o <= 1'b0;
				C_o <= 1'b0;
				
				Total_Amount <= count;
				count <= 3'b0;

				ns <= 2'b01;
				end
				
	 2'b01:begin

				if(N)
				count = count + 7'b101;	
				else if(I)
				count = count + 7'b1010;
				else if(Q)
				count = count + 7'b11001;
				else if(D)
				count = count + 7'd1000100;
				else
				count = count;

								
				if(count >= 7'b1000110)
					ns = 2'b10;
				else
					ns = 2'b01;
				end 
				
	  2'b10:begin
	  	
				if (A == 1'b1 && B == 1'b0 && C == 1'b0)
					A_o <= 1'b1;

				else if (A == 1'b0 && B == 1'b1 && C == 1'b0)
					B_o <= 1'b1;
			 
				else if (A == 1'b0 && B == 1'b0 && C == 1'b1)
					C_o <= 1'b1;
					
				else 
					begin
					A_o <= 1'b0;
					B_o <= 1'b0;
					C_o <= 1'b0;
					end	
				
				end
	endcase
	
endmodule	

