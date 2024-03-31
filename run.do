
vlog \
-permissive \
-f compile_files.f

vsim \
-c \
-displaymsgmode both \
-onfinish stop \
-voptargs=+acc \
+UVM_TESTNAME=mem_random_test \
+UVM_VERBOSITY=UVM_MEDIUM \
+UVM_NO_RELNOTES \
work.mem_top

run -all
