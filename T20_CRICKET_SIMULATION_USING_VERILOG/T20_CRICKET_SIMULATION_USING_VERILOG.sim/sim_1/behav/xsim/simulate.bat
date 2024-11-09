@echo off
REM ****************************************************************************
REM Vivado (TM) v2024.1 (64-bit)
REM
REM Filename    : simulate.bat
REM Simulator   : AMD Vivado Simulator
REM Description : Script for simulating the design by launching the simulator
REM
REM Generated by Vivado on Fri Nov 08 16:28:04 +0530 2024
REM SW Build 5076996 on Wed May 22 18:37:14 MDT 2024
REM
REM Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
REM Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
REM
REM usage: simulate.bat
REM
REM ****************************************************************************
REM simulate design
echo "xsim cricket_game_sim_tb_behav -key {Behavioral:sim_1:Functional:cricket_game_sim_tb} -tclbatch cricket_game_sim_tb.tcl -view D:/Semester 5/EE5260 Hardware Description Language/T20_CRICKET_SIMULATION_USING_VERILOG/T20_CRICKET_SIMULATION_USING_VERILOG/cricket_game_sim_tb_behav.wcfg -log simulate.log"
call xsim  cricket_game_sim_tb_behav -key {Behavioral:sim_1:Functional:cricket_game_sim_tb} -tclbatch cricket_game_sim_tb.tcl -view D:/Semester 5/EE5260 Hardware Description Language/T20_CRICKET_SIMULATION_USING_VERILOG/T20_CRICKET_SIMULATION_USING_VERILOG/cricket_game_sim_tb_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
