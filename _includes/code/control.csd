<CsoundSynthesizer>
<CsOptions>
</CsOptions>
; ============================================================================
<CsInstruments>

sr     = 44100
ksmps  = 8
nchnls = 2
0dbfs  = 1

instr 1
  kfreq invalue "freq"
  kamp  invalue "amp"
  asin  oscili  kamp, kfreq
  outs asin, asin
endin

</CsInstruments>
; ============================================================================
<CsScore>
i1 0 36000
</CsScore>
</CsoundSynthesizer>
