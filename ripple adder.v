module ripple_carry_adder(sum, cout, a, b, mode);
    input [3:0] a;
    input [3:0] b;
    input mode;      
    output [3:0] sum;
    output cout;

    
    wire c1;
    wire c2;
    wire c3;
    wire [3:0] d; 

    
    xor(d[0], b[0], mode);
    xor(d[1], b[1], mode);
    xor(d[2], b[2], mode);
    xor(d[3], b[3], mode);

    
    
    full_adder fa0 (sum[0], c1, a[0], d[0], mode);
    full_adder fa1 (sum[1], c2, a[1], d[1], c1);
    full_adder fa2 (sum[2], c3, a[2], d[2], c2);
    full_adder fa3 (sum[3], cout, a[3], d[3], c3);

endmodule