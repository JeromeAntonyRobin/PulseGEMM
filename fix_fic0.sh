sed -i '/generate_component -component_name ${sd_name}/d' temp/ref_design/script_support/components/FIC_0_PERIPHERALS.tcl
echo "save_smartdesign -sd_name \${sd_name}" >> temp/ref_design/script_support/components/FIC_0_PERIPHERALS.tcl
echo "generate_component -component_name \${sd_name}" >> temp/ref_design/script_support/components/FIC_0_PERIPHERALS.tcl
