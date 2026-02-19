namespace QuantumWalk{ 
import Std.Convert.ResultArrayAsInt;
open Microsoft.Quantum.Intrinsic;
open Microsoft.Quantum.Canon;
open Microsoft.Quantum.Diagnostics;
open Microsoft.Quantum.Convert;
open Microsoft.Quantum.Math;
open Microsoft.Quantum.Measurement;


operation Main() : Unit {

    let numSteps = 3;
    let numQubits = 4;
    RunQuantumWalk(numSteps, numQubits);
    
}

operation  QuantumStep(coin : Qubit, pos : Qubit[]) : Unit {
    CoinFlip(coin);
    moveRight(coin, pos);
    moveLeft(coin, pos);
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
    }
}


operation moveLeft(coin : Qubit, pos : Qubit[]) : Unit {
    let n= Length(pos);
    X(coin);
    for i in n-1 .. -1 .. 0 {
        mutable controls =[coin];
        for j in 0 .. i-1 {
            X(pos[j]);
            set controls += [pos[j]];
        }
        Controlled X(controls, pos[i]);
        for j in 0 .. i-1 {
            X(pos[j]);
        }
    }
    X(coin);
}

operation RunQuantumWalk(numSteps : Int, numQubits : Int) : Int {
    use coin = Qubit(); 
    use positions = Qubit[numQubits];
    for i in 0 .. numQubits-2 {
        X(positions[i]);
    }
    
    for step in 1 .. numSteps {
        QuantumStep(coin, positions);
    }
    // Measure the final position
    let results = MeasureEachZ(positions);
    let intresults = ResultArrayAsInt(results);
    Message($"Final position: {intresults}");
    ResetAll(positions);
    Reset(coin);
    return intresults;
}
}