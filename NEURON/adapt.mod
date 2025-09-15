NEURON {
    POINT_PROCESS Adapt
    NONSPECIFIC_CURRENT iadapt
    RANGE g, gmax, tau, e, iadapt
}

UNITS {
    (mA) = (milliamp)
    (mV) = (millivolt)
    (S) = (siemens)
}

PARAMETER {
    gmax = 0.001 (S)    : Max conductance
    tau = 200 (ms)      : Decay time constant
    e = -90 (mV)        : Reversal potential
}

ASSIGNED {
    v (mV)
    iadapt (mA)
}

STATE {
    g (S)
}

INITIAL {
    g = 0
}

BREAKPOINT {
    SOLVE state METHOD cnexp
    iadapt = g * (v - e)
}

DERIVATIVE state {
    g' = -g / tau
}

NET_RECEIVE(weight) {
    g = g + weight * gmax
}
