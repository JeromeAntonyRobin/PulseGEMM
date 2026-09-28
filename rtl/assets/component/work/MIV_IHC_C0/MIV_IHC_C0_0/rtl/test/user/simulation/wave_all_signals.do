quietly catch "add wave -group testbench /testbench/*" wave_error
quietly catch "add wave -group DUT /testbench/DUT/*" wave_error

quietly catch "add wave -group apb_target_0 /testbench/DUT/apb_tgt0/apb_target_0/*" wave_error
quietly catch "add wave -group apb_target_1 /testbench/DUT/apb_tgt1/apb_target_1/*" wave_error
quietly catch "add wave -group apb_target_2 /testbench/DUT/apb_tgt2/apb_target_2/*" wave_error

quietly catch "add wave -group axi_target_0 /testbench/DUT/axi_tgt0/axi_target_0/*" wave_error
quietly catch "add wave -group axi_target_1 /testbench/DUT/axi_tgt1/axi_target_1/*" wave_error
quietly catch "add wave -group axi_target_2 /testbench/DUT/axi_tgt2/axi_target_2/*" wave_error

quietly catch "add wave -group apb_arbiter_0 /testbench/DUT/apb_arbiter_top_0/*" wave_error
quietly catch "add wave -group miv_ihc_core_0 /testbench/DUT/miv_ihc_core_0/*" wave_error

quietly catch "add wave -group h5_irq_module /testbench/DUT/miv_ihc_core_0/gen_intr_module_h5/h5_irq_module/*" wave_error
quietly catch "add wave -group h4_irq_module /testbench/DUT/miv_ihc_core_0/gen_intr_module_h4/h4_irq_module/*" wave_error
quietly catch "add wave -group h3_irq_module /testbench/DUT/miv_ihc_core_0/gen_intr_module_h3/h3_irq_module/*" wave_error
quietly catch "add wave -group h2_irq_module /testbench/DUT/miv_ihc_core_0/gen_intr_module_h2/h2_irq_module/*" wave_error
quietly catch "add wave -group h1_irq_module /testbench/DUT/miv_ihc_core_0/gen_intr_module_h1/h1_irq_module/*" wave_error
quietly catch "add wave -group h0_irq_module /testbench/DUT/miv_ihc_core_0/gen_intr_module_h0/h0_irq_module/*" wave_error

quietly catch "add wave -group CH_H0_H1 /testbench/DUT/miv_ihc_core_0/gen_h0_h1/CH_H0_H1/*" wave_error
quietly catch "add wave -group CH_H0_H2 /testbench/DUT/miv_ihc_core_0/gen_h0_h2/CH_H0_H2/*" wave_error
quietly catch "add wave -group CH_H0_H3 /testbench/DUT/miv_ihc_core_0/gen_h0_h3/CH_H0_H3/*" wave_error
quietly catch "add wave -group CH_H0_H4 /testbench/DUT/miv_ihc_core_0/gen_h0_h4/CH_H0_H4/*" wave_error
quietly catch "add wave -group CH_H0_H5 /testbench/DUT/miv_ihc_core_0/gen_h0_h5/CH_H0_H5/*" wave_error
quietly catch "add wave -group CH_H1_H2 /testbench/DUT/miv_ihc_core_0/gen_h1_h2/CH_H1_H2/*" wave_error
quietly catch "add wave -group CH_H1_H3 /testbench/DUT/miv_ihc_core_0/gen_h1_h3/CH_H1_H3/*" wave_error
quietly catch "add wave -group CH_H1_H4 /testbench/DUT/miv_ihc_core_0/gen_h1_h4/CH_H1_H4/*" wave_error
quietly catch "add wave -group CH_H1_H5 /testbench/DUT/miv_ihc_core_0/gen_h1_h5/CH_H1_H5/*" wave_error
quietly catch "add wave -group CH_H2_H3 /testbench/DUT/miv_ihc_core_0/gen_h2_h3/CH_H2_H3/*" wave_error
quietly catch "add wave -group CH_H2_H4 /testbench/DUT/miv_ihc_core_0/gen_h2_h4/CH_H2_H4/*" wave_error
quietly catch "add wave -group CH_H2_H5 /testbench/DUT/miv_ihc_core_0/gen_h2_h5/CH_H2_H5/*" wave_error
quietly catch "add wave -group CH_H3_H4 /testbench/DUT/miv_ihc_core_0/gen_h3_h4/CH_H3_H4/*" wave_error
quietly catch "add wave -group CH_H3_H5 /testbench/DUT/miv_ihc_core_0/gen_h3_h5/CH_H3_H5/*" wave_error
quietly catch "add wave -group CH_H4_H5 /testbench/DUT/miv_ihc_core_0/gen_h4_h5/CH_H4_H5/*" wave_error

quietly catch "add wave -group miv_ihc_target /testbench/DUT/miv_ihc_core_0/apb_target_0/*" wave_error
quietly catch "add wave -group addr_mux_0 /testbench/DUT/miv_ihc_core_0/addr_mux_0/*" wave_error

quietly catch "add wave -group common_mailbox_ram /testbench/DUT/miv_ihc_core_0/common_mailbox_ram/*" wave_error
quietly catch "add wave -group common_mailbox_ram /testbench/DUT/miv_ihc_core_0/common_mailbox_ram/mem" wave_error