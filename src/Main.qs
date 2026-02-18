open Microsoft.Quantum.Intrinsic;
open Microsoft.Quantum.Canon;
open Microsoft.Quantum.Diagnostics;

operation Main() : Unit {
    use q = Qubit();

    // Poner el qubit en superposición
    H(q);

    // Medir el qubit
    let result = M(q);

    // Mostrar el resultado en consola
    Message($"Resultado de la medición: {result}");

    // Resetear el qubit a |0⟩ antes de liberarlo
    Reset(q);
}

operation  QuantumStep(
    Coin : (Qubit => Unit),
    Swap : (Qubit => Unit),
    q : Qubit
) : Unit{
    Coin(q);
    Swap(q);
}

operation CoinFlip(q : Qubit) : Unit {
    H(q);
}

operation moveRight(coin : Qubit, pos : Qubit[]) : Unit {
    let n= Length(pos);


    for i in n-1 .. -1 .. 0 {
        mutable controls =[coin];
        for j in 0 .. i-1 {
            set controls += [pos[j]];
        }
        Controlled X(controls, pos[i]);
    }}




     

}
