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
