module ha (s,c,a,b);
	input a;
	input b;
	output s;
	output c;
	xor(s,a,b);
	and(c,a,b);
endmodule

module full_adder (sum, cout,a,b,cin);
    input a;
    input b;
    input cin;
    output sum;
    output cout;
    wire s1; 
    wire c1; 
    wire c2; 
    ha ha1 (s1,c1,a,b);
    ha ha2 (sum,c2,s1,cin);
    or(cout,c1,c2);

endmodule

module ripple_carry_adder(sum, cout, a, b, cin);
    input [3:0] a;
    input [3:0] b;
    input cin;      
    output [3:0] sum;
    output cout;

    wire c1;
    wire c2;
    wire c3;
  
    full_adder fa0 (sum[0], c1, a[0], b[0], cin);
    full_adder fa1 (sum[1], c2, a[1], b[1], c1);
    full_adder fa2 (sum[2], c3, a[2], b[2], c2);
    full_adder fa3 (sum[3], cout, a[3], b[3], c3);

endmodule


module bcd_adder_4bit(
    input [3:0] a,
    input [3:0] b,
    input cin,
    output [3:0] sum,
    output cout
);
    wire [3:0] z;
    wire k;
    wire correction_needed;
    wire unused_cout;

    // Step 1: Initial 4-bit binary addition.[cite: 1] 
    // We connect 'cin' to the 'mode' input.[cite: 1]
    ripple_carry_adder rca_add (
        .sum(z), 
        .cout(k), 
        .a(a), 
        .b(b), 
        .cin(cin)
    );

    // Step 2: Check for BCD overflow.
    // Correction is needed if the carry out is 1, or if the sum is 10-15 (1010 to 1111).
    assign correction_needed = k | (z[3] & z[2]) | (z[3] & z[1]);
    
    // The correction flag serves as the actual carry-out for the next BCD stage.
    assign cout = correction_needed; 

    // Step 3: Create the correction value.
    // If correction_needed is 1, correction_val is 0110 (6). Otherwise, it is 0000.
    wire [3:0] correction_val;
    assign correction_val = {1'b0, correction_needed, correction_needed, 1'b0};

    // Step 4: Add the correction value to the initial sum.[cite: 1]
    ripple_carry_adder rca_correct (
        .sum(sum), 
        .cout(unused_cout), 
        .a(z), 
        .b(correction_val), 
        .cin(1'b0) // No carry-in needed for the correction stage[cite: 1]
    );

endmodule