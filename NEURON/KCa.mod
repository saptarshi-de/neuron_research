TITLE KCa channel from Destexhe et al., 1994

NEURON {
    SUFFIX KCa
    USEION k READ ek WRITE ik
    USEION ca READ cai
    RANGE gkbar, ik
    GLOBAL minf, mtau
}

UNITS {
    (mA) = (milliamp)
    (mV) = (millivolt)
    (mM) = (millimole/liter)
}

PARAMETER {
    gkbar = 0.01 (S/cm2)
    caix = 0.001 (mM)
    ek = -80 (mV)
}

ASSIGNED {
    v (mV)
    cai (mM)
    ik (mA/cm2)
    minf
    mtau (ms)
}

STATE {
    m
}

BREAKPOINT {
    SOLVE states METHOD cnexp
    ik = gkbar * m * (v - ek)
}

DERIVATIVE states {
    rates(cai)
    m' = (minf - m) / mtau
}

PROCEDURE rates(cai (mM)) {
    minf = cai / (cai + caix)
    mtau = 2 (ms)
}
