
vlog \
-permissive \
-f compile_files.f

vsim \
-c \
-displaymsgmode both \
-onfinish stop \
-voptargs=+acc \
+UVM_TESTNAME=mem_test \
+UVM_VERBOSITY=UVM_MEDIUM \
work.mem_top

add wave -position insertpoint \
sim:/mem_top/mem_dut/clk \
sim:/mem_top/mem_dut/rst_n \
sim:/mem_top/mem_dut/wr_en \
sim:/mem_top/mem_dut/data_in \
sim:/mem_top/mem_dut/address \
sim:/mem_top/mem_dut/data_out \
sim:/mem_top/mem_dut/valid_out \
sim:/mem_top/mem_dut/mem_array

run -all

wave zoom full

radix -binary -showbase
radix signal sim:/mem_top/mem_dut/data_in hexadecimal -showbase
radix signal sim:/mem_top/mem_dut/address hexadecimal -showbase
radix signal sim:/mem_top/mem_dut/data_out hexadecimal -showbase
radix signal sim:/mem_top/mem_dut/mem_array hexadecimal -showbase
radix signal sim:/mem_top/mem_dut/mem_array[0] hexadecimal -showbase
radix signal sim:/mem_top/mem_dut/mem_array[1] hexadecimal -showbase
radix signal sim:/mem_top/mem_dut/mem_array[2] hexadecimal -showbase
radix signal sim:/mem_top/mem_dut/mem_array[3] hexadecimal -showbase
radix signal sim:/mem_top/mem_dut/mem_array[4] hexadecimal -showbase
radix signal sim:/mem_top/mem_dut/mem_array[5] hexadecimal -showbase
radix signal sim:/mem_top/mem_dut/mem_array[6] hexadecimal -showbase
radix signal sim:/mem_top/mem_dut/mem_array[7] hexadecimal -showbase
radix signal sim:/mem_top/mem_dut/mem_array[8] hexadecimal -showbase
radix signal sim:/mem_top/mem_dut/mem_array[9] hexadecimal -showbase
radix signal sim:/mem_top/mem_dut/mem_array[10] hexadecimal -showbase
radix signal sim:/mem_top/mem_dut/mem_array[11] hexadecimal -showbase
radix signal sim:/mem_top/mem_dut/mem_array[12] hexadecimal -showbase
radix signal sim:/mem_top/mem_dut/mem_array[13] hexadecimal -showbase
radix signal sim:/mem_top/mem_dut/mem_array[14] hexadecimal -showbase
radix signal sim:/mem_top/mem_dut/mem_array[15] hexadecimal -showbase
