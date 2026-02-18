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
