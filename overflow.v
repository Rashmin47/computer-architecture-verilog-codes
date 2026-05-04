module OverflowDetector(overflow,a,b,sum);
  input a,b,sum;     // MSB of A, B and Sum
  output overflow;
  assign overflow = (a ^ sum) & (b ^ sum);
endmodule
//***Testbench Module***
module overflowtb;
wire overflow;
reg a,b,sum;
OverflowDetector uut(overflow,a,b,sum);
initial
begin	
        $dumpfile("overflow.vcd");
        $dumpvars(); 	//for gtkwave display
        $monitor($time," overflow=%b,a=%b,b=%b,sum=%b",overflow,a,b,sum);	

	a=0; b=0; sum=0;      // No overflow
     #1 a=0; b=0; sum=1;   // Overflow (positive + positive = negative)
     #1 a=1; b=1; sum=0;   // Overflow (negative + negative = positive)
     #1 a=1; b=1; sum=1;   // No overflow
     #1 a=0; b=1; sum=0;   // No overflow
     #10 $finish;
end
endmodule