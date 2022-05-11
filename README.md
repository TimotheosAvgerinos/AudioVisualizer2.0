# AudioVisualizer2.0

### Εισαγωγικα
  Το **Audio Visualizer** είναι ένα πρόγραμμα το οποίο δημιουργήθηκε στα πλαίσια του μαθήματος "Επεξεργασία Ομιλίας και Ήχου" του τμήματος πληροφορικής του Ιονίου Πανεπιστημίου. Η εργασία έγινε από τον Τιμόθεο Αυγερινό (Π2015009) και τον Κωνσταντίνο Αφεντούλη (Π2015021).
 
  
  ## Τεχνολογιες 
  Το **Audio Visualizer** έχει υλοποιηθεί με το λογισμικό **MatLab**.
  Για το **UI** της εφαρμογής έχει χρησιμοποιηθεί το **App Designer** του Matlab.
  Για την οπτικοποίηση χρησιμοποιήθικαν τα objects : 
  - timescope
  - dsp.TimeScope
  - dsp.ArrayPlot
  - dsp.SpectrumAnalyzer


## UI
![UI](https://github.com/p15avge/AudioVisualizer2.0/blob/main/Screenshots/UI.png)

# Οπτικοποιήσεις
## Timescope
Πατώντας ο χρήστης το πρώτο κουμπί στο δεξί panel το **TimeScope** του εμφανίζει ένα άλλο παράθυρο και του απεικονίζει το μουσικό κομμάτι του σε ενα δυσδιάστατο γράφημα όπου στον αξονα **X** βρίσκεται ο **χρόνος(Τ)** σε seconds και στον αξονα **Υ** απεικονίζεται το **ευρος(Amplitude)**.![Timescope](https://github.com/p15avge/AudioVisualizer2.0/blob/main/Screenshots/TimeScope%201png.png)

![ΤTimescope low y limits](https://github.com/p15avge/AudioVisualizer2.0/blob/main/Screenshots/Timescope%201%20y%20limits%20low.png)

## Timescope 2
Πατώντας το δεύτερο κουμπί **TimeScope 2** οι άξονες απεικονίζουν τα ίδια όπως και το πρώτο γράφημα αλλά με άλλο τρόπο. 
![ΤTimescope 2](https://github.com/p15avge/AudioVisualizer2.0/blob/main/Screenshots/TimeScope%202%20plot.png)
![Timescope 2 low](https://github.com/p15avge/AudioVisualizer2.0/blob/main/Screenshots/TimeScope%202.png)

## Array Plot
Το **Array Plot** αποτελεί ακόμα ένα τρόπο οπτικοποιησης του κομματιού που έχουμε βάλει στο πρόγραμμα  και εμφανίζει διανύσματα ομοιόμορφα τοποθετημένα γύρο από τον άξονα Χ. Στον άξονα Υ βρίσκεται το εύρος (amplitude).
![Array Plot stem](https://github.com/p15avge/AudioVisualizer2.0/blob/main/Screenshots/ArrayScope.png)
Array Plot με Plot type **Stem**.

![Array plot Line](https://github.com/p15avge/AudioVisualizer2.0/blob/main/Screenshots/Array%20plot%20line.png)
Array Plot με Plot type **Line**.

![Array Plot Stairs](https://github.com/p15avge/AudioVisualizer2.0/blob/main/Screenshots/Array%20plot%20%20stairs.png)
Array Plot με Plot type **Stairs**.

## Spectrum Scope
Το Spectrum έχει στον άξονα **Χ** τις **συχνότητές (Frequency)** και στον **Υ** τα **dBm**.

![Spectrum scope](https://github.com/p15avge/AudioVisualizer2.0/blob/main/Screenshots/SpectrumScope.png)
Spectrum Scope σε **Linear Scale** και **Two-sided plot**.


![Spectrum scope](https://github.com/p15avge/AudioVisualizer2.0/blob/main/Screenshots/Spectrum%20one-side%20log.png)
Spectrum Scope σε **Log Scale** και **One-sided plot**.

![Spectrum scope](https://github.com/p15avge/AudioVisualizer2.0/blob/main/Screenshots/Spectrogram.png)
Spectrogram, βάζοντας το View type να είναι στην επιλογή **Spectrogram**.


![Spectrogram Spectrum](https://github.com/p15avge/AudioVisualizer2.0/blob/main/Screenshots/Spectrum%20and%20Spectrogram.png)
Spectrum και Spectrogram μαζί στο ίδιο διάγραμμα.
