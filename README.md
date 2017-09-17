# Design-and-Verification-of-LDPC-Decoder
- Designed the LDPC decoder in the Matlab using the min-sum approach.  - Designed quantized RTL in Verilog with the min-sum approach and parallel architecture. - Created modules for all variants of the variable node unit(VNU) and the check-node unit(CNU) based on the H matrix. Created script for module instantiation of VNU and CNU as per the H matrix.  - Verified the functionality of the Verilog implementation by self-checking test-bench in Verilog to compare the results with Matlab.


This section explains the files that are used for the entire project execution, as mentioned below:

Matlab files
calculate_minsum: function for calculating the minsum
check_node_processing: CNU 
LDPC: ldpc decoder without the function, as a standalone script
Ldpc_decoder: main ldpc decoder function for the decoding
Quant_llr: used for quantization
Regular_Hcheck: function for checking the regularity of the H matrix
Script_LDPC: file provided with the project aim
Variable_node_proessing: VNU 
Verilog_tb_generation: script for testbench generation
 Verilog_generation: script for instantiating  all the modules

Verilog files
CNU_[6-7].v: CNU model
CNU_6_tb.v: Testbench for CNU_6
VNU_[2,3,6]: VNU model
VNU_6_tb: VNU testbench
Top_level_ldpc_entire: Top level model of the Verilog of the LDPC decode
Top_lvel_ldpc_entire_tb: Top level testbench
