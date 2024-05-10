

\TLV_version 1d: tl-x.org
\source top.tlv 36

\SV
   // Include Tiny Tapeout Lab.
   // Included URL: "https://raw.githubusercontent.com/os-fpga/Virtual-FPGA-Lab/35e36bd144fddd75495d4cbc01c4fc50ac5bde6f/tlv_lib/tiny_tapeout_lib.tlv"// Included URL: "https://raw.githubusercontent.com/os-fpga/Virtual-FPGA-Lab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlv_lib/fpga_includes.tlv"
   // Calculator VIZ.
   // Included URL: "https://raw.githubusercontent.com/efabless/chipcraft---mest-course/main/tlv_lib/calculator_shell_lib.tlv"
\source top.tlv 74

\SV

// ================================================
// A simple Makerchip Verilog test bench driving random stimulus.
// Modify the module contents to your needs.
// ================================================

module top(input logic clk, input logic reset, input logic [31:0] cyc_cnt, output logic passed, output logic failed);
   // Tiny tapeout I/O signals.
   logic [7:0] ui_in, uo_out;
   logic [7:0] uio_in, uio_out, uio_oe;
   logic [31:0] r;
   always @(posedge clk) r <= $urandom();
   assign ui_in = r[7:0];
   assign uio_in = 8'b0;
   logic ena = 1'b0;
   logic rst_n = ! reset;

   // Instantiate the Tiny Tapeout module.
   tt_um_example tt(.*);

   assign passed = top.cyc_cnt > 80;
   assign failed = 1'b0;
endmodule


// Provide a wrapper module to debounce input signals if requested.

\SV



// =======================
// The Tiny Tapeout module
// =======================

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
       // The FPGA is based on TinyTapeout 3 which has no bidirectional I/Os (vs. TT6 for the ASIC).
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
   wire reset = ! rst_n;
\source top.tlv 132

\TLV
   /* verilator lint_off UNOPTFLAT */
   \source top.tlv 126   // Instantiated from top.tlv, 136 as: m5+tt_lab.
      // Connect Tiny Tapeout I/Os to Virtual FPGA Lab.
      \source /raw.githubusercontent.com/osfpga/VirtualFPGALab/35e36bd144fddd75495d4cbc01c4fc50ac5bde6f/tlvlib/tinytapeoutlib.tlv 76   // Instantiated from top.tlv, 128 as: m5+tt_connections()
         $slideswitch[7:0] = *ui_in;
         $sseg_segment_n[6:0] = ~ *uo_out[6:0];
         $sseg_decimal_point_n = ~ *uo_out[7];
         $sseg_digit_n[7:0] = 8'b11111110;
      \end_source
      // Instantiate the Virtual FPGA Lab.
      \source /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv 307   // Instantiated from top.tlv, 130 as: m5+board(/top, /fpga, 7, $, , calc)
         
         \source /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv 355   // Instantiated from /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv, 309 as: m4+thanks(m5__l(309)m5_eval(m5_get(BOARD_THANKS_ARGS)))
            /thanks
               \viz_js
                  box: {width: 300, height: 180, strokeWidth: 0, stroke: "#e0e0e0"},
                  init() {
                     return {
                        thanks: new fabric.Text("Thanks to Efabless, Tiny Tapeout, and our sponsors: ", {
                           left: 10,
                           top: 10,
                           fontSize: 20
                        }),
                        osfpgaImg: this.newImageFromURL("https://raw.githubusercontent.com/os-fpga/Virtual-FPGA-Lab/0dc0c04745e0eaebbe2ca41710e4ffd61d29691c/viz/OSFPGA.jpg", "", {
                           left: 80,
                           top: 50,
                           width: 100,
                           hieght: 30,
                        }),
                        gsocImg: this.newImageFromURL("https://upload.wikimedia.org/wikipedia/commons/0/08/GSoC_logo.svg", "", {
                           left: 190,
                           top: 40,
                           width: 80,
                           height: 80,
                        })
                     }
                  },
                  where: {left: 1696, top: 2090, width: 283, scale: 4.5}
         \end_source
         
      
         // Board VIZ.
      
         // Board Image.
         \viz_js
            box: {strokeWidth: 0},
            init() {
               ret = {}
               ret.img = this.newImageFromURL(
                  "https://raw.githubusercontent.com/os-fpga/Virtual-FPGA-Lab/0dc0c04745e0eaebbe2ca41710e4ffd61d29691c/viz/tt3demoboardwFPGAcarrier2.jpg", "",
                  {  left: 0,
                     top: 0,
                     fill: "#30483c",
                     strokeWidth: 1,
                     width: (function () {return {width: 2600, height: 2044}})().width,
                     height: (function () {return {width: 2600, height: 2044}})().height,
                  },
                  {  angle: 0,
                     strokeWidth: 0
                  }
               )
               return ret;
            },
            where: {},
         /fpga_pins
            \viz_js
               where: {visible: true, justifyX: "center", justifyY: "center", fill: "#303030a0", left: 1221, top: 898, width: 142, height: 142},
               box: {strokeWidth: 0}
            /fpga
               \source top.tlv 44   // Instantiated from /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv, 340 as: m4+calc.
               
                  |calc
                     @1
                        $reset = *reset;
                        $valid = $equals_in && !>>2$equals_in;
                        $val1[7:0] = >>2$out;
                        $add[7:0] = $val1[7:0] + $val2[7:0];
                        $sub[7:0] = $val1[7:0] - $val2[7:0];
                        $mul[7:0] = $val1[7:0] * $val2[7:0];
                        $div[7:0] = $val1[7:0] / $val2[7:0];
                     @2
                        $out[7:0] = $reset ? 8'b0 :
                           !$valid ? >>1$out :
                              $op[1:0] == 2'b00 ? $add :
                              $op[1:0] == 2'b01 ? $sub :
                              $op[1:0] == 2'b10 ? $mul :
                              $div;
                        \source /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv 844   // Instantiated from top.tlv, 62 as: m5+sseg_decoder($segments, $out[3:0])
                           $segments[6:0] =
                                ($out[3:0] == 0) ? 7'b1000000 : // '0'
                                ($out[3:0] == 1) ? 7'b1111001 : // '1'
                                ($out[3:0] == 2) ? 7'b0100100 : // '2'
                                ($out[3:0] == 3) ? 7'b0110000 : // '3'
                                ($out[3:0] == 4) ? 7'b0011001 : // '4'
                                ($out[3:0] == 5) ? 7'b0010010 : // '5'
                                ($out[3:0] == 6) ? 7'b0000010 : // '6'
                                ($out[3:0] == 7) ? 7'b1111000 : // '7'
                                ($out[3:0] == 8) ? 7'b0000000 : // '8'
                                ($out[3:0] == 9) ? 7'b0010000 : // '9'
                                ($out[3:0] == 10) ? 7'b0001000 : // 'a'
                                ($out[3:0] == 11) ? 7'b0000011 : // 'b'
                                ($out[3:0] == 12) ? 7'b1000110 : // 'c'
                                ($out[3:0] == 13) ? 7'b0100001 : // 'd'
                                ($out[3:0] == 14) ? 7'b0000110 : // 'e'
                                ($out[3:0] == 15) ? 7'b0001110 : // 'f'
                                7'b1111111 ;                // 'nothing'
                        \end_source
                        *ou_out  = {1'b0, $segments};
               
                  // Note that pipesignals assigned here can be found under /fpga_pins/fpga.
               
               
               
                  \source /raw.githubusercontent.com/efabless/chipcraftmestcourse/main/tlvlib/calculatorshelllib.tlv 4   // Instantiated from top.tlv, 69 as: m5+cal_viz(@2, m5__l(69)m5_call(if,m5_get(in_fpga), /fpga, /top))
                     // Only for Makerchip.
                     \source /raw.githubusercontent.com/efabless/chipcraftmestcourse/main/tlvlib/calculatorshelllib.tlv 9   // Instantiated from /raw.githubusercontent.com/efabless/chipcraftmestcourse/main/tlvlib/calculatorshelllib.tlv, 6 as: m5+cal_viz_internal.
                        
                        
                        |calc
                           @0
                              $ANY = /fpga|tb/default<>0$ANY;
                              `BOGUS_USE($dummy $rand2 $rand1)
                        |tb
                           @0
                              /default
                                 $reset = *reset;
                                 $valid = ! $reset;
                                 \SV_plus
                                    always @(posedge clk) $$rand[31:0] <= \$random();
                                 $rand_op[2:0] = $rand[2:0];
                                 $rand1[3:0] = $rand[6:3];
                                 $rand2[3:0] = $rand[10:7];
                                 $op[2:0] = ((*top.cyc_cnt % 2) != 0)
                                                ? $rand_op[2:0]
                                                //? ( (*top.cyc_cnt > 33) ? ($rand_op[2:0] % 2) :
                                                //    (*top.cyc_cnt > 15) ? $rand_op[2:0] :
                                                //                          ((($rand_op[2:0] % 2) != 0) + ($rand_op[2:0] % 4)) )
                                                : >>1$op;
                                 $val1[7:0] = '0;
                                 $val2[7:0] = '0;
                                 $equals_in = $rand[11];
                                 $out[7:0] = '0;
                                 $mem[8:0] = 9'h100;   // Indicates to VIZ that there is no memory.
                                 $dummy = 0;
                                 `BOGUS_USE($reset $equals_in $out $mem $valid $val1 $val2 $dummy $rand1 $rand2)
                           @2
                              $ANY = /fpga|calc<>0$ANY;
                     
                              \viz_js
                                 box: {strokeWidth: 0},
                                 init() {
                                    let value_right = 150 + 316 - 30;
                                    
                                    let tlvname = new fabric.Text("TL-V", {
                                      left: 150 + 130,
                                      top: 150 - 40,
                                      fontSize: 22,
                                      fontFamily: "Times",
                                      fill: "white",
                                    });
                                    let hexcalname = new fabric.Text("HEX CALCULATOR", {
                                      left: 150 + 60,
                                      top: 150 - 20,
                                      fontSize: 22,
                                      fontFamily: "Times",
                                      fill: "white",
                                    });
                                    let calbox = new fabric.Rect({
                                      left: 150,
                                      top: 150,
                                      fill: "#779",
                                      width: 316,
                                      height: 366,
                                      stroke: "black",
                                      strokeWidth: 1,
                                      rx: 5, ry: 5,
                                    });
                                    let val1box = new fabric.Rect({
                                      left: 150 + 28,
                                      top: 150 + 83,
                                      fill: "#ddd",
                                      width: 254 + 14,
                                      height: 40,
                                      stroke: "black",
                                      strokeWidth: 1,
                                    });
                                    let val1num = new fabric.Text("", {
                                      left: value_right, top: 150 + 221 + 7, originX: "right", textAlign: "right", fontSize: 22, fontFamily: "Courier New",
                                      top: 150 + 89,
                                    });
                                    let val2box = new fabric.Rect({
                                      left: 150 + 187,
                                      top: 150 + 221,
                                      fill: "#ddd",
                                      width: 109,
                                      height: 40,
                                      stroke: "black",
                                      strokeWidth: 1,
                                    });
                                    let val2num = new fabric.Text("", {
                                      left: value_right, top: 150 + 221 + 7, originX: "right", textAlign: "right", fontSize: 22, fontFamily: "Courier New",
                                      top: 150 + 221 + 7,
                                    });
                                    let outbox = new fabric.Rect({
                                      left: 150 + 97,
                                      top: 150 + 300,
                                      fill: "#ddd",
                                      width: 199,
                                      height: 40,
                                      stroke: "black",
                                      strokeWidth: 1,
                                    });
                                    let outnum = new fabric.Text("", {
                                      left: value_right, top: 150 + 221 + 7, originX: "right", textAlign: "right", fontSize: 22, fontFamily: "Courier New",
                                      top: 150 + 300 + 8,
                                    });
                                    let equalname = new fabric.Text("=", {
                                      left: 150 + 38,
                                      top: 150 + 306,
                                      fontSize: 28,
                                      fontFamily: "Times",
                                    });
                                      let sumbox = new fabric.Rect({
                                      left: 150 + 28,
                                      top: 150 + 148,
                                      fill: "white",
                                      width: 64,
                                      height: 64,
                                      stroke: "#333",
                                      strokeWidth: 1,
                                      rx: 3, ry: 3,
                                    });
                                    let prodbox = new fabric.Rect({
                                      left: 150 + 28,
                                      top: 150 + 222,
                                      fill: "white",
                                      width: 64,
                                      height: 64,
                                      stroke: "#333",
                                      strokeWidth: 1,
                                      rx: 3, ry: 3,
                                    });
                                    let minbox = new fabric.Rect({
                                      left: 150 + 105,
                                      top: 150 + 148,
                                      fill: "white",
                                      width: 64,
                                      height: 64,
                                      stroke: "#333",
                                      strokeWidth: 1,
                                      rx: 3, ry: 3,
                                    });
                                    let quotbox = new fabric.Rect({
                                      left: 150 + 105,
                                      top: 150 + 222,
                                      fill: "white",
                                      width: 64,
                                      height: 64,
                                      stroke: "#333",
                                      strokeWidth: 1,
                                      rx: 3, ry: 3,
                                    });
                                    let sumicon = new fabric.Text("+", {
                                      left: 150 + 28 + 26,
                                      top: 150 + 148 + 22,
                                      fontSize: 22,
                                      fontFamily: "Times",
                                    });
                                    let prodicon = new fabric.Text("*", {
                                      left: 150 + 28 + 26,
                                      top: 150 + 222 + 22,
                                      fontSize: 22,
                                      fontFamily: "Times",
                                    });
                                    let minicon = new fabric.Text("-", {
                                      left: 150 + 105 + 26,
                                      top: 150 + 148 + 22,
                                      fontSize: 22,
                                      fontFamily: "Times",
                                    });
                                    let quoticon = new fabric.Text("/", {
                                      left: 150 + 105 + 26,
                                      top: 150 + 222 + 22,
                                      fontSize: 22,
                                      fontFamily: "Times",
                                    });
                                    let membox = new fabric.Rect({
                                      left: 105 + 150,
                                      top: 150 + 25,
                                      fill: "#ddd",
                                      width: 191,
                                      height: 23,
                                      stroke: "black",
                                      strokeWidth: 1
                                    });
                                    let memname = new fabric.Text("mem", {
                                      left: 150 + 28,
                                      top: 150 + 25,
                                      fontSize: 22,
                                      fontFamily: "Times",
                                    });
                                    let memarrow = new fabric.Text("->", {
                                      left: 150 + 32 + 47,
                                      top: 150 + 25,
                                      fill: "#779",
                                      fontSize: 22,
                                      fontFamily: "monospace",
                                    });
                                    let recallarrow = new fabric.Text("->", {
                                      left: 150 + 38 + 28,
                                      top: 150 + 308,
                                      fill: "#779",
                                      fontSize: 22,
                                      fontFamily: "monospace",
                                    });
                                    let memnum = new fabric.Text("", {
                                      left: value_right, top: 150 + 221 + 7, originX: "right", textAlign: "right", fontSize: 22, fontFamily: "Courier New",
                                      top: 150 + 25,
                                    });
                                    let membuttonbox = new fabric.Rect({
                                      left: 150 + 187,
                                      top: 150 + 151,
                                      fill: "white",
                                      width: 45,
                                      height: 40,
                                      stroke: "#333",
                                      strokeWidth: 1,
                                      rx: 3, ry: 3,
                                    });
                                    let recallbuttonbox = new fabric.Rect({
                                      left: 150 + 245,
                                      top: 150 + 151,
                                      fill: "white",
                                      width: 51,
                                      height: 40,
                                      stroke: "#333",
                                      strokeWidth: 1,
                                      rx: 3, ry: 3,
                                    });
                                    let membuttonname = new fabric.Text("mem", {
                                      left: 150 + 187 + 1,
                                      top: 150 + 151 + 7,
                                      fontSize: 22,
                                      fontFamily: "Times",
                                    });
                                    let recallbuttonname = new fabric.Text("recall", {
                                      left: 150 + 245 + 1,
                                      top: 150 + 151 + 7,
                                      fontSize: 22,
                                      fontFamily: "Times",
                                    });
                                    return {tlvname, hexcalname, calbox, val1box, val1num, val2box, val2num, outbox, outnum, equalname, sumbox, minbox, prodbox, quotbox, sumicon, prodicon, minicon, quoticon,  membox, memname, memnum, membuttonbox, recallbuttonbox, membuttonname, recallbuttonname, memarrow, recallarrow};
                                 },
                                 render() {
                                    let valid = '$valid'.asBool(false);
                                    let has_mem = '$mem'.asInt(NaN) != 0x100;
                                    let op = has_mem ? '$op'.asInt(NaN) : '$op'.asInt(NaN) & 0x3;
                                    let mem_mod = has_mem ? '$mem'.asInt(NaN) : 0;
                                    let is_sum     = valid && (op == 0);
                                    let is_diff    = valid && (op == 1);
                                    let is_prod    = valid && (op == 2);
                                    let is_quot    = valid && (op == 3);
                                    let is_recall  = valid && (op == 4);
                                    let is_mem     = valid && (op == 5);
                                    let is_invalid_op = valid && (op == 6 || op == 7);
                                    let is_arith  = valid && !is_recall && !is_mem && !is_invalid_op;
                     
                                    // For debugging
                                    let oldvalval1 = "";
                                    let oldvalval2 = "";
                                    let oldvalout = "";
                                    let oldvalrecall = "";
                     
                                    this.getObjects().val1num.set({
                                       text: '$val1'.asInt(NaN).toString(16) + oldvalval1,
                                       fill: "blue"});
                                    this.getObjects().val2num.set({
                                       text: '$val2'.asInt(NaN).toString(16) + oldvalval2,
                                       fill: is_arith ? "blue" : "grey"});
                                    this.getObjects().outnum.set({
                                       text: '$out'.asInt(NaN).toString(16) + oldvalout,
                                       fill: is_arith ? "blue" : "grey"});
                     
                                    this.getObjects().memnum.set({
                                       text: mem_mod.toString(16) + oldvalrecall,
                                       fill: has_mem ? "blue" : "grey"});
                                    this.getObjects().sumbox.set({fill: is_sum ?  "#9fc5e8ff" : "white"});
                                    this.getObjects().minbox.set({fill: is_diff ?  "#9fc5e8ff" : "white"});
                                    this.getObjects().prodbox.set({fill: is_prod ? "#9fc5e8ff" : "white"});
                                    this.getObjects().quotbox.set({fill: is_quot ?  "#9fc5e8ff" : "white"});
                                    this.getObjects().membuttonbox.set({fill: is_mem ? "#9fc5e8ff" : "white"});
                                    this.getObjects().recallbuttonbox.set({fill: is_recall ?  "#9fc5e8ff" : "white"});
                                    this.getObjects().memarrow.set({fill: is_mem ? "blue" : "#779"});
                                    this.getObjects().recallarrow.set({fill: is_recall ?  "blue" : "#779"});
                                  }
                        
                        
                     \end_source
                  \end_source
               
                  // Connect Tiny Tapeout outputs. Note that uio_ outputs are not available in the Tiny-Tapeout-3-based FPGA boards.
                  *uo_out = 8'b0;
                  *uio_out = 8'b0;
                  *uio_oe = 8'b0;
               \end_source
      
         // LEDs.
         
      
         // 7-Segment
         \source /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv 395   // Instantiated from /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv, 346 as: m4+fpga_sseg.
            /digit[0]
               \viz_js
                  all: {
                     box: {
                        fill: "#2a2a2a",
                        strokeWidth: 0,
                     },
                  },
                  box: {
                     width: 35,
                     height: 60,
                     strokeWidth: 0,
                  },
                  renderFill() {
                     debugger
                     let attributes = {seven_seg: {color: "#ffff00", background: "#586068"}, switch: {background: "transparent", foreground: "#bab496", foreground_width: 0.7}}
                     attributes = attributes.seven_seg ? attributes.seven_seg : {}
                     return attributes.background ? attributes.background : "#2a2a2a"
                  },
                  layout: {left: -35},
                  where: {left: 1846, top: 1088, scale: 3.36}
               /leds[7:0]
                  $viz_lit = (! /top$sseg_digit_n[digit]) && ! ((#leds == 7) ? /top$sseg_decimal_point_n : /top$sseg_segment_n\[#leds % 7\]);
                  \viz_js
                     box: {left: 0, top: 0, strokeWidth: 0},
                     init() {
                        let led = this.getIndex()
                        let digit = this.getIndex("digit")
                        let squash = 0
                        let sseg = (this.getIndex() == 7) ? new fabric.Circle({
                              left: 26,
                              top: 48,
                              radius: 2.5,
                              opacity: 1,
                              fill: "#707080"
                           })
                           :
                           new fabric.Rect({
                              top: 15 + ((led == 1 || led == 5) ? -4 - squash : (led == 2 || led == 4) ? 16 - 3*squash : (led == 3) ? 31 - 4*squash : (led == 6) ? 11 - 2*squash : -9),
                              left: 10 + ((led == 6) ? -1 : (led == 1) ? 13 : (led == 2) ? 11 : (led == 3) ? -3 : (led == 4) ? -8 : (led == 5) ? -6 : 1),
                              width: ((led == 6) || (led == 3) || (led == 0)) ? 13 : 4,
                              height: ((led == 5) || (led == 4) || (led == 2) || (led == 1)) ? 14 : 4,
                              fill: "#707080",
                              skewX: ((led == 5) || (led == 4) || (led == 2) || (led == 1)) ? -7 : 0,
                              opacity: 1
                           })
                        return{sseg};
                     },
                     render() {
                        let digit = this.getIndex("digit")
                        let segment = this.getIndex()
                        let attributes = {seven_seg: {color: "#ffff00", background: "#586068"}, switch: {background: "transparent", foreground: "#bab496", foreground_width: 0.7}}
                        attributes = attributes.seven_seg ? attributes.seven_seg : {}
                        let color = attributes.color ? attributes.color : "red"
                        this.getObjects().sseg.set({fill: '$viz_lit'.asBool() ? color : "#707080"})
                     },
                     layout: {left: 0, top: 0}
         \end_source
      
         // slideswitches
         \source /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv 454   // Instantiated from /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv, 349 as: m4+fpga_switch.
            /switch[7:0]
               $viz_switch = /top$slideswitch\[#switch\];
               \viz_js
                  box: { width: 18, height: 35, strokeWidth: 0},
                  where: {left: 611, top: 426, scale: 2.9, angle: 90},
                  
                  init() {
                     let attributes = {seven_seg: {color: "#ffff00", background: "#586068"}, switch: {background: "transparent", foreground: "#bab496", foreground_width: 0.7}}
                     attributes = attributes.switch ? attributes.switch : {}
                     let background = attributes.background ? attributes.background : "#333"
                     let slot_color = attributes.slot_color ? attributes.slot_color : "#222"
                     let foreground = attributes.foreground ? attributes.foreground : "#524F4E"
                     foreground_width = attributes.foreground_width ? attributes.foreground_width : 1.25
                     let background_rect = new fabric.Rect({
                        top: 0, left: 0,
                        width: 18, height: 35,
                        strokeWidth: 0,
                        fill: background
                     })
                     let slot = new fabric.Rect({
                                 top: 17.5,
                                 left: 9,
                                 originX: "center",
                                 originY: "center",
                                 width: 12,
                                 height: 26,
                                 fill: slot_color,
                                 rx:2,
                                 ry:2
                              })
                      let state = new fabric.Rect({
                                 top: 17.5,
                                 left: 9,
                                 originX: "center",
                                 originY: "center",
                                 width: 12 * foreground_width,
                                 height: 12 * foreground_width,
                                 fill: foreground,
                                 rx:2,
                                 ry:2
                        })
                       return{background_rect, slot, state}
                  },
                  render(){
                     this.getInitObject("state").set('$viz_switch'.asBool() ? {top: 10.5} : {top: 24.5});
                  }
         \end_source
      
         // pushbuttons
         
      \end_source
      // Label the switch inputs [0..7] (1..8 on the physical switch panel) (top-to-bottom).
      \source /raw.githubusercontent.com/osfpga/VirtualFPGALab/35e36bd144fddd75495d4cbc01c4fc50ac5bde6f/tlvlib/tinytapeoutlib.tlv 82   // Instantiated from top.tlv, 132 as: m5+tt_input_labels_viz.
         /input_label[7:0]
            \viz_js
               box: {width: 40, height: 10, strokeWidth: 0, fill: "#ffffffa0", rx: 4, ry: 4},
               layout: {left: 0, top: 18},
               init() {
                  let labels = ["Value[0]", "Value[1]", "Value[2]", "Value[3]", "Op[0]", "Op[1]", "Op[2]", "="]
                  return {
                     label: new fabric.Text(labels[this.getIndex()], {
                        top: 1,
                        left: 38,
                        fontSize: 6,
                        fontFamily: "Courier New",
                        fontWeight: 600,
                        originX: "right"
                     })
                  }
               },
               where: {left: 370, top: 437, scale: 2.9}
      \end_source
   \end_source

\SV
endmodule

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 
























/top @0 /digit[0:0] /leds[7:0] @0 /fpga_pins /fpga |calc @1 @2 @3 /switch[7:0] @0 $slideswitch $sseg_ decimal_ point_ n $sseg_ digit_ n $sseg_ segment_ n $viz_ lit $add $div $equals_ in $mul $op $out $reset $segments $sub $val1 $val2 $valid $viz_ switch *ou_out *reset *ui_in *uio_oe *uio_out
*uo_out
  0
