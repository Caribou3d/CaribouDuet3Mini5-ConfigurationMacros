; =========================================================================================================
;
; Configuration file for Duet 3 Mini 5+ (firmware version 3.4)
;
; for 0.9° motors on xy, and 0.9° or 1.8° (only LGXM) motor e
;
; for #CARIBOU_VARIANT
;
; CariboDuetConfiguration Release : "1.9.2"
;                           Build :    56
;
; Copyright Caribou Research & Development 2022. Licensed under GPL3. No commercial use.
; Source code and release notes are available on github: https://github.com/Caribou3d/CaribouDuet3Mini5ConfigurationMacros
;
; =========================================================================================================
; Network settings
; =========================================================================================================
;
#CARIBOU_NAME
;
M552 S1                                                                ; enable network
M586 P0 S1                                                             ; enable HTTP
M586 P1 S1                                                             ; enable FTP
M586 P2 S0                                                             ; disable Telnet
M575 P1 S1 B57600                                                      ; enable support for PanelDue
;
; =========================================================================================================
; Drives
; =========================================================================================================
;
M569 P0.0 S0 D3 V1000                                                  ; physical drive 0.0 goes backwards - z - left
M569 P0.1 S0 D3 V2000                                                  ; physical drive 0.1 goes backwards - x-axis
M569 P0.2 S0 D3 V2000                                                  ; physical drive 0.2 goes backwards - y-axis
M569 P0.3 S0 D3 V1000                                                  ; physical drive ß.3 goes backwards - z - right
M569 P0.4 D3 V1000                                                     ; physical drive 0.4 goes forwards  - extruder
;
; Motor Configuration
;
M584 X0 Y1 Z2:4 E3                                                     ; set drive mapping
M671 X-36.5:293.5 Y0:0 S1.00                                           ; leadscrews at left (connected to Z) and right (connected to E1) of X axis
;
; set Microsteps and steps / mm
;
M350 X16 Y16 Z16 E16 I1                                                ; configure microstepping with interpolation
M92 X200.00 Y200.00 Z400.00 E#CARIBOU_EESTEPS                                    ; set steps per mm
;
; set motor currents
;
; #CARIBOU_MOTOR_CURRENTS
;
M84 S60                                                                ; set idle timeout
;
; set speeds
;
M201 X500.00 Y500.00 Z100.00 E500.00                                   ; set accelerations (mm/s^2)
M203 X12000.00 Y12000.00 Z1000.00 E3600.00                             ; set maximum speeds (mm/min)
M204 P500.0 T500.0                                                     ; set print and travel accelerations (mm(s^2)
M566 X480.00 Y480.00 Z48.00 E300.00                                    ; set maximum instantaneous speed changes (mm/min)
;
M564 H0                                                                ; allow unhomed movement
;
; =========================================================================================================
; Axis Limits
; =========================================================================================================
;
M208 X-2 Y-7.5 Z0 S1                                                   ; set axis minima
M208 X254.6 Y214 #CARIBOU_ZHEIGHT S0                                            ; set axis maxima
;
; =========================================================================================================
; Endstops
; =========================================================================================================
;
M574 X1 S3                                                             ; configure sensorless endstop for low end on x
M574 Y1 S3                                                             ; configure sensorless endstop for low end on y
M574 Z1 S2                                                             ; configure z-probe endstop for low end on z
M574 Z2 S3                                                             ; configure sensorless endstop for high end on z
;
; =========================================================================================================
;
; #CARIBOU_ZPROBE
;
; =========================================================================================================
;
M574 Z1 S2                                                             ; set endstops controlled by probe
;
; Stallguard Sensitivy
;
M915 X S1 F0 H200 R0                                                   ; set x axis Sensitivity
M915 Y S1 F0 H200 R0                                                   ; set y axis Sensitivity
M915 Z S1 F0 H200 R0                                                   ; set z axis Sensitivity
;
; =========================================================================================================
; Heater & Fans
; =========================================================================================================
;
; heated bed
; =========================================================================================================
;
M308 S0 P"temp0" Y"thermistor" T100000 B4138 A"Bed"                    ; configure sensor 0 as thermistor on pin bedtemp
M950 H0 C"out0" Q50 T0                                                 ; create bed heater output on bedheat and map it to sensor 0
M143 H0 S110                                                           ; set temperature limit for heater 0 to 110C
M307 H0 B0 S1.00                                                       ; disable bang-bang mode for the bed heater and set PWM limit
M140 H0                                                                ; map heated bed to heater 0
;
; extruder
; =========================================================================================================
;
; #CARIBOU_HOTEND_THERMISTOR
;
; =========================================================================================================
;
M308 S4 P"mcu-temp" Y"mcu-temp" A"MCU"                                 ; set virtual heater for MCU
M308 S5 P"drivers" Y"drivers" A"Driver"                                ; set virtual heater for stepper drivers
;
; =========================================================================================================
; Fans
; =========================================================================================================
;
; extruder fan (temerature controlled)
;
M950 F1 C"out5" Q500                                                   ; create fan 1 on pin fan0 and set its frequency
M106 P1 H1 T45                                                         ; set fan 2 value. Thermostatic control is turned on
;
; radial fan
;
M950 F0 C"out6" Q25                                                    ; create fan 0 on pin fan1 and set its frequency
M106 P0 S0 H-1                                                         ; set fan 0 value. Thermostatic control is turned off
;
; ========================================================================================================
; Tools
; =========================================================================================================
;
M563 P0 D0 H1 F0                                                       ; define tool 0
G10 P0 X0 Y0 Z0                                                        ; set tool 0 axis offsets
M568 P0 S0 R0 A0                                                       ; turn off extruder
M302 S#CARIBOU_MINEXTRUDETEMP R#CARIBOU_MINRETRACTTEMP                                                         ; allow extrusion starting from 180°C and retractions already from 180°C
;
; =========================================================================================================
; other settings
; =========================================================================================================
;
M18 XY                                                                 ; release / unlock x, y
M501                                                                   ; use config-override (for Thermistor Parameters and other settings)
G90                                                                    ; send absolute coordinates...
M83                                                                    ; ... but relative extruder moves
;
; =========================================================================================================
;  filament handling
; =========================================================================================================
;
; execute macros that determine the status of the filament sensor
;
M98 P"0:/sys/00-Functions/FilamentsensorStatus"
;
; =========================================================================================================
;
; =========================================================================================================
;
; Offsets - place off-sets for x and y here. z-offsets are handled in the print sheet macros
;
; #CARIBOU_OFFSETS
;
; =========================================================================================================
;
;
; =========================================================================================================
;
; global varibales
;
global IdleCounter = 0
global ExtruderTempActive_Old = 0
global BedTempActive_Old = 0
;
; =========================================================================================================
;
