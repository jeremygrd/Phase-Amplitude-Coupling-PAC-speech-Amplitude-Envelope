# Phase-Amplitude-Coupling-PAC-speech-Amplitude-Envelope

In this project we looked at PAC on the speech amplitude envelope across 17 languages.

Data retrieved from [here](https://www.faithcomesbyhearing.com/audio-bible-resources/mp3-downloads?)

We selected recordings which did not contain any sound effects but only plain speech. 



language             | nb of files| duration   |
---------------------|------------|------------|
ar: arabic           | 7224 files | 6.02 hours |
en: English          | 6078 files | 5.06 hours |
es: Spanish          | 6767 files | 5.64 hours |
eu: Basque           | 6573 files | 5.47 hours |
fi: Finnish          | 7393 files | 6.16 hours |
fr: French           | 5606 files | 4.67 hours |
hi: Hindi            | 6783 files | 5.65 hours |
hy: Armenian         | 6346 files | 5.28 hours |
ja: Japanese         | 7758 files | 6.46 hours |
ko: Korean           | 7172 files | 5.97 hours |
nl: Dutch            | 6611 files | 5.50 hours |
ru: Russian          | 9039 files | 7.53 hours |
sv: Swedish          | 5322 files | 4.43 hours |
ta: Tamil            | 10571 files| 8.81 hours |
th: Thai             | 8072 files | 6.72 hours |
vi: Vietnamese       | 6268 files | 5.22 hours |
zh: Chinese mandarin | 5831 files | 4.86 hours |

languages: [ISO 639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes)


    
Audiofiles were then transform to mono, downsampled to 16KHz and cut in pieces of 3 seconds.

Speech Amplitude envelopes were computed on the audiofiles using Matlab code.

Speech Amplitude envelope data was downsampled to 512Hz. 

Then PAC (Tort et al., 2010)  was computed on the concatenated segments for each language

200 permutations were created by shuffling the phases of the signal.

Shoutout to [PacTools] (https://github.com/pactools/pactools)



references

Tort, A. B., Komorowski, R., Eichenbaum, H., & Kopell, N. (2010). Measuring phase-amplitude coupling between neuronal oscillations of different frequencies. Journal of neurophysiology, 104(2), 1195-1210.

Dupré la Tour, T., Tallot, L., Grabot, L., Doyère, V., Van Wassenhove, V., Grenier, Y., & Gramfort, A. (2017). Non-linear auto-regressive models for cross-frequency coupling in neural time series. PLoS computational biology, 13(12), e1005893.


