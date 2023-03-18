# university-project

## Sound Generator for Simulating the Timbre of Musical Instruments Using MATLAB Program 利用MATLAB程式模擬樂器音色之聲音產生器

###### Advisor: Ching-Hsiang Tseng
###### Author: Chen-Yang Ma, Yu-Hsiang Tseng
###### Communication and Signal Processing Laboratory, Department of Electrical Engineering, National Taiwan Ocean University,202 Keelung

### Introduction

模擬音色的聲音產生器對於製作音樂的便利性很高，可以藉由合成出的聲音，即時聆聽該樂器演奏的聲音，並以此製作出音樂。在這個專題中，先使用MATLAB將樂器的單一音階導入進程式中，再將此單一音階執行audioread(file)指令得到此單音的音頻波型，接著執行envelope( )指令擷取該音頻的邊緣波型。使用power spectrum的指令pspectrum( )執行頻譜分析，會得到該音頻的諧波頻率，將這些諧波頻率的成分頻率數值使用islocalmax( )指令得到，取到諧波頻率的成分頻率數值後，使用sin函數合成成分頻率結合成新的sin函數，再將envelope( )指令所得到的邊緣波型與新的sin函數進行疊合，即可得到具有該樂器音色所模擬的單音，結合resample( )指令還有音階頻率公式Sp=(2.^(n/12))*S，可以再合成出其他音階跟不同長度的拍子。使用readmatrix( )將另外輸入的簡譜音符數值匯入MATLAB，再將匯入的簡譜結合迴圈指令for( )與switch( )指令，搭上sound( )與pause( )指令，便可以使用模擬樂器音色之聲音產生器演奏出簡單的曲子。

### Achievements
1. Matlab code [piano_A4](https://github.com/Enohpgogo/university-project/blob/main/piano-synthesis/piano_A4.m)

![image](https://github.com/Enohpgogo/university-project/blob/main/IMG/piano_A4.jpg)
