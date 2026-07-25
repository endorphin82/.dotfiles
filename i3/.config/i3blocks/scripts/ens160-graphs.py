#!/usr/bin/env python3
import sys
import os

import matplotlib
matplotlib.use("TkAgg")
import matplotlib.pyplot as plt
import matplotlib.dates as mdates
import pandas as pd

CSV_FILE = os.path.expanduser("~/.cache/ens160.csv")
BG = "#1e1e2e"
FG = "#cdd6f4"
COLORS = ["#f38ba8", "#89b4fa", "#a6e3a1", "#f9e2af"]

def main():
    if not os.path.exists(CSV_FILE):
        print(f"CSV не знайдено: {CSV_FILE}", file=sys.stderr)
        sys.exit(1)

    df = pd.read_csv(CSV_FILE, header=None, names=["timestamp", "temp", "hum", "soil", "soil2"])
    if df.empty:
        print("CSV порожній", file=sys.stderr)
        sys.exit(1)

    df["timestamp"] = pd.to_datetime(df["timestamp"], unit="s")
    for c in ["temp", "hum"]:
        df[c] = pd.to_numeric(df[c], errors="coerce")
    for c in ["soil", "soil2"]:
        df[c] = pd.to_numeric(df[c], errors="coerce")

    df = df.dropna(subset=["temp"]).reset_index(drop=True)

    fig, axes = plt.subplots(4, 1, figsize=(10, 8), sharex=True)
    fig.patch.set_facecolor(BG)

    titles = ["Температура (°C)", "Вологість (%)", "Ґрунт 1", "Ґрунт 2"]
    columns = ["temp", "hum", "soil", "soil2"]

    for ax, col, title, color in zip(axes, columns, titles, COLORS):
        series = df.dropna(subset=[col])
        if not series.empty:
            ax.plot(series["timestamp"], series[col], color=color, linewidth=1.5)
        ax.set_facecolor(BG)
        ax.tick_params(colors=FG, labelsize=9)
        for spine in ax.spines.values():
            spine.set_color(FG)
        ax.spines["top"].set_visible(False)
        ax.spines["right"].set_visible(False)
        ax.set_title(title, color=FG, fontsize=11)
        ax.grid(True, alpha=0.15)

    axes[-1].xaxis.set_major_formatter(mdates.DateFormatter("%m/%d %H:%M"))
    fig.autofmt_xdate()
    plt.tight_layout()
    plt.show()

if __name__ == "__main__":
    main()
