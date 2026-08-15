onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color Gold /JohnsonCounter/rstn
add wave -noupdate -color Red /JohnsonCounter/clk
add wave -noupdate -color {Violet Red} -expand -subitemconfig {{/JohnsonCounter/d[3]} {-color {Violet Red}} {/JohnsonCounter/d[2]} {-color {Violet Red}} {/JohnsonCounter/d[1]} {-color {Violet Red}} {/JohnsonCounter/d[0]} {-color {Violet Red}}} /JohnsonCounter/d
add wave -noupdate -color {Lime Green} -expand -subitemconfig {{/JohnsonCounter/q[3]} {-color {Lime Green}} {/JohnsonCounter/q[2]} {-color {Lime Green}} {/JohnsonCounter/q[1]} {-color {Lime Green}} {/JohnsonCounter/q[0]} {-color {Lime Green}}} /JohnsonCounter/q
add wave -noupdate /JohnsonCounter/not_q3
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {541 ps} {919 ps}
