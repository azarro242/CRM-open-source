#!/usr/bin/env python3
"""Musique de fond originale (aucun droit tiers) : pulsation tendue « compte à rebours ».

  python3 outils/musique.py <duree_secondes> <sortie.wav>

La mise en place : 112 BPM, la mineur (la – fa – ré – mi), sub-basse en croches,
grosse caisse douce, tic d'horloge en doubles croches, nappe filtrée.
Volume volontairement bas : la voix off reste devant au mixage.
"""
import sys, wave
import numpy as np

SR = 44100
BPM = 112
TEMPS = 60 / BPM
duree = float(sys.argv[1])
sortie = sys.argv[2]
n = int(SR * (duree + 0.5))
t = np.arange(n) / SR
mix = np.zeros(n)

def note(f):
    return 440.0 * 2 ** ((f - 69) / 12)

# grille d'accords (une mesure de 4 temps chacun) — la, fa, ré, mi
ACCORDS = [(45, [57, 60, 64]), (41, [53, 57, 60]), (38, [50, 53, 57]), (40, [52, 56, 59])]
MESURE = 4 * TEMPS

def env(longueur, attaque, chute):
    k = np.arange(longueur) / SR
    e = np.minimum(1, k / max(attaque, 1e-4)) * np.exp(-k / chute)
    return e

def poser(signal, debut):
    i = int(debut * SR)
    if i >= n:
        return
    j = min(n, i + len(signal))
    mix[i:j] += signal[: j - i]

# sub-basse en croches, avec respiration (effet « pompe »)
croche = TEMPS / 2
k = 0
while k * croche < duree + 0.5:
    debut = k * croche
    racine = ACCORDS[int(debut // MESURE) % 4][0]
    f = note(racine)
    L = int(croche * SR)
    x = np.arange(L) / SR
    s = (np.sin(2 * np.pi * f * x) + 0.35 * np.sin(2 * np.pi * 2 * f * x)) * env(L, 0.012, 0.16)
    poser(0.30 * s, debut)
    k += 1

# grosse caisse douce sur chaque temps
k = 0
while k * TEMPS < duree + 0.5:
    L = int(0.35 * SR)
    x = np.arange(L) / SR
    f = 52 + 70 * np.exp(-x / 0.03)
    phase = 2 * np.pi * np.cumsum(f) / SR
    poser(0.42 * np.sin(phase) * env(L, 0.002, 0.11), k * TEMPS)
    k += 1

# tic d'horloge en doubles croches (accent sur les temps)
rng = np.random.default_rng(7)
k = 0
while k * TEMPS / 4 < duree + 0.5:
    L = int(0.03 * SR)
    bruit = rng.standard_normal(L)
    bruit = np.diff(np.concatenate([[0], bruit]))  # aigu
    acc = 0.11 if k % 4 == 0 else 0.05
    poser(acc * bruit * env(L, 0.0005, 0.008), k * TEMPS / 4)
    k += 1

# nappe : dents de scie douces filtrées, attaque lente, une par mesure
def scie(f, x):
    return 2 * ((f * x) % 1.0) - 1

m = 0
while m * MESURE < duree + 0.5:
    _, notes = ACCORDS[m % 4]
    L = int(MESURE * SR)
    x = np.arange(L) / SR
    s = sum(scie(note(p), x) + scie(note(p) * 1.004, x) for p in notes)
    # passe-bas à un pôle
    y = np.zeros(L)
    a = 0.035
    acc = 0.0
    for i in range(L):
        acc += a * (s[i] - acc)
        y[i] = acc
    enveloppe = np.minimum(1, x / 0.6) * np.minimum(1, (MESURE - x) / 0.4)
    poser(0.045 * y * enveloppe, m * MESURE)
    m += 1

# fondu d'entrée très court (le son doit être là dès la 1re image) et de sortie
fin = int(duree * SR)
mix[:int(0.05 * SR)] *= np.linspace(0, 1, int(0.05 * SR))
fondu = int(1.2 * SR)
mix[fin - fondu:fin] *= np.linspace(1, 0, fondu)
mix[fin:] = 0
mix = mix[:fin]
mix /= max(1e-9, np.max(np.abs(mix)))
mix *= 0.7

stereo = np.stack([mix, mix], axis=1)
with wave.open(sortie, "wb") as w:
    w.setnchannels(2)
    w.setsampwidth(2)
    w.setframerate(SR)
    w.writeframes((stereo * 32767).astype(np.int16).tobytes())
print(f"Musique : {sortie} ({duree:.1f} s)")
