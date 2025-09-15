TITLE L-type calcium channel (cal)

NEURON {
    SUFFIX cal
    USEION ca READ eca WRITE ica
    RANGE gcalbar, ica, gcal
}

UNITS {
    (mA) = (milliamp)
    (mV) = (millivolt)
    (mM) = (millimole/liter)
    FARADAY = (faraday) (coulomb)
    R = (k-mole) (joule/degC)
}

PARAMETER {
    gcalbar = 0.003 (S/cm2)   : Maximum conductance
    eca = 140     (mV)        : Reversal potential for calcium
}

ASSIGNED {
    v       (mV)
    celsius (degC)
    gcal    (S/cm2)
    ica     (mA/cm2)
    minf
    mtau    (ms)
}

STATE {
    m
}

BREAKPOINT {
    SOLVE states METHOD cnexp
    gcal = gcalbar * m*m
    ica = gcal * (v - eca)
}

DERIVATIVE states {
    rates(v)
    m' = (minf - m)/mtau
}

PROCEDURE rates(v (mV)) {
    LOCAL alpha, beta
    TABLE minf, mtau FROM -100 TO 100 WITH 200

    alpha = 0.055 * (-27 - v) / (exp((-27-v)/3.8) - 1)
    beta  = 0.94 * exp((-75-v)/17)
    minf = alpha / (alpha + beta)
    mtau = 1 / (alpha + beta)
    if (mtau < 0.1) { mtau = 0.1 }
}
