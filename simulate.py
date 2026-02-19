import qsharp
import matplotlib.pyplot as plt
from collections import Counter

qsharp.init(project_root="./")

# --- Parameters ---
NUM_STEPS     = 5
NUM_QUBITS    = 6         # 2^4 = 16 possible positions (0-15)
NUM_SHOTS     = 2000


# --- Run shots ---
counts = Counter()
for _ in range(NUM_SHOTS):
    pos = qsharp.eval(f"QuantumWalk.RunQuantumWalk({NUM_STEPS}, {NUM_QUBITS})")
    counts[pos] += 1

# --- Build distribution over all possible positions ---
num_positions = 2 ** NUM_QUBITS
positions     = list(range(num_positions))
probabilities = [counts.get(p, 0) / NUM_SHOTS for p in positions]

# --- Plot ---
fig, ax = plt.subplots(figsize=(12, 5))

bars = ax.bar(positions, probabilities, color="steelblue", edgecolor="white", linewidth=0.5)

# Highlight the most probable positions
max_prob = max(probabilities)
for bar, prob in zip(bars, probabilities):
    if prob == max_prob:
        bar.set_color("tomato")

ax.set_xlabel("Position", fontsize=13)
ax.set_ylabel("Probability", fontsize=13)
ax.set_title(
    f"Quantum Walk Distribution  |  steps={NUM_STEPS}, qubits={NUM_QUBITS}, shots={NUM_SHOTS}",
    fontsize=14
)
ax.set_xticks(positions)
ax.set_xlim(-0.5, num_positions - 0.5)
ax.set_ylim(0, max_prob * 1.3)

# Annotate bars with count
for p, prob in zip(positions, probabilities):
    if prob > 0:
        ax.text(p, prob + 0.002, f"{prob:.2f}", ha="center", va="bottom", fontsize=8)

plt.tight_layout()
plt.savefig("quantum_walk_distribution.png", dpi=150)
plt.show()

print(f"\nTop 5 positions:")
for pos, count in sorted(counts.items(), key=lambda x: -x[1])[:5]:
    print(f"  Position {pos:>2}: {count:>4} times  ({count/NUM_SHOTS:.1%})")