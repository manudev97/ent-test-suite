import pandas as pd
import matplotlib.pyplot as plt

# Load the CSV file into a DataFrame
df = pd.read_csv('./resultados.csv')

# Plotting the data
plt.figure(figsize=(10, 6))

# Plot Entropy
plt.subplot(2, 2, 1)
plt.plot(df['Archivo'], df['Entropy'], marker='o')
plt.title('Entropy')
plt.xlabel('Archivo')
plt.ylabel('Entropy')
plt.xticks(rotation=90)

# Plot Chi-square
plt.subplot(2, 2, 2)
plt.plot(df['Archivo'], df['Chi-square'], marker='o')
plt.title('Chi-square')
plt.xlabel('Archivo')
plt.ylabel('Chi-square')
plt.xticks(rotation=90)

# Plot Mean
plt.subplot(2, 2, 3)
plt.plot(df['Archivo'], df['Mean'], marker='o')
plt.title('Mean')
plt.xlabel('Archivo')
plt.ylabel('Mean')
plt.xticks(rotation=90)

# Plot Monte-Carlo-Pi
plt.subplot(2, 2, 4)
plt.plot(df['Archivo'], df['Monte-Carlo-Pi'], marker='o')
plt.title('Monte-Carlo-Pi')
plt.xlabel('Archivo')
plt.ylabel('Monte-Carlo-Pi')
plt.xticks(rotation=90)

plt.tight_layout()
plt.show()
plt.savefig('mi_grafico.png')