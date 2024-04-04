#include <stdlib.h>
#include <iostream>
#include <cstdlib>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "VCircularFifo.h"

// Change simulation time to number of cycles required
#define MAX_SIM_TIME 300
//To keep track of the current cycle
vluint64_t sim_time = 0;


int main(int argc, char** argv, char** env) { 
    VCircularFifo *dut = new VCircularFifo;

    //To generate trace
    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 5);     
    m_trace->open("waveform.vcd");

    //Simulation loop
    while (sim_time < MAX_SIM_TIME) {
        dut-> reset = 0;
        // Resetting for one clock cycle between 1 and 2
        if (sim_time >= 0 && sim_time <= 2) {
            dut-> reset = 1;
            //Reset any input signals
            dut->io_enq_write = 0;
            dut->io_enq_din = 0;
            dut->io_enq_dinValid = 0;
            dut->io_deq_read = 0;
        }
        //Simulation for a fifo width of 8 bits and depth of 4

        //Add input signals here
        if (dut->clock) {
            //Put a value in, without valid.
            if (sim_time > 2 && sim_time <= 4) {
                dut->io_enq_write = 1;
                dut->io_enq_dinValid = 0;
                dut->io_enq_din = 1;

            //Put 2 values in, with valid.
            } else if (sim_time > 4 && sim_time <= 6) {
                dut->io_enq_write =1;
                dut->io_enq_dinValid = 1;
                dut->io_enq_din = 2;
            } else if (sim_time > 6 && sim_time <= 8) {
                dut->io_enq_write =1;
                dut->io_enq_dinValid = 1;
                dut->io_enq_din = 3;

            //Take a value out.
            } else if (sim_time > 8 && sim_time <= 10) {
                dut->io_deq_read = 1;
                dut->io_enq_write =0;
                dut->io_enq_dinValid = 1;
                dut->io_enq_din = 4;

            // Put 4 values in, with valid.
            } else if (sim_time > 10 && sim_time <= 12) {
                dut->io_deq_read = 0;
                dut->io_enq_write =1;
                dut->io_enq_dinValid = 1;
                dut->io_enq_din = 5;
            } else if (sim_time > 12 && sim_time <= 14) {
                dut->io_enq_write =1;
                dut->io_enq_dinValid = 1;
                dut->io_enq_din = 6;
            } else if (sim_time > 14 && sim_time <= 16) {
                dut->io_enq_write =1;
                dut->io_enq_dinValid = 1;
                dut->io_enq_din = 7;
            } else if (sim_time > 16 && sim_time <= 18) {
                dut->io_enq_write =1;
                dut->io_enq_dinValid = 1;
                dut->io_enq_din = 8;

            // Put 5th value in, with valid.
            } else if (sim_time > 18 && sim_time <= 20) {
                dut->io_enq_write =1;
                dut->io_enq_dinValid = 1;
                dut->io_enq_din = 9;
                dut->io_deq_read = 0;

            // Take 4 values out
            } else if (sim_time > 20 && sim_time <= 30) {
                dut->io_enq_write =0;
                dut->io_deq_read = 1;
            
            // Try to take another value out.
            } else if (sim_time > 30 && sim_time <= 32) {
                dut->io_deq_read = 1;
            
            } else {
                dut->io_deq_read = 0;
                dut->io_enq_write = 0;
                dut->io_enq_dinValid = 0;
            }
        }
        
        //Eval will set the signals in and make them reflect in output
        dut->clock ^= 1;
        dut->eval();

        //Add any checks here for output
        //Simulation body
        
        //Can add printf lines to obeserve the outputs

        m_trace->dump(sim_time);
        sim_time++;
    }

    m_trace->close();
    delete dut;
    exit(EXIT_SUCCESS);
}
