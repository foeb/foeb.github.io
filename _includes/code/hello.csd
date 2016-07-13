<CsoundSynthesizer>
<CsOptions>
-W -o "hello.wav"
</CsOptions>
; ============================================================================
<CsInstruments>

sr     = 44100
ksmps  = 8
nchnls = 2
0dbfs  = 1

instr 1	
  ifreq = p4
  iamp  = p5
  asin oscili iamp, ifreq
  outs asin, asin
endin

</CsInstruments>
; ============================================================================
<CsScore>
i1 0 2 440 0.5 ; play a sine wave
</CsScore>
</CsoundSynthesizer>
