# CSCE5810.001 - Group Project for UNT CSCE 5810.001

This project's aim was to recreate Thomas Morgan's experiments with fruit flies by tracking genetic traits across generations. Due to memory limitations, we have limited the amount of fruit fly generations that will be executed. This project will track the following two traits:
 
* Red/White Eyes
* Mutant Vestigial Wings

## Assumptions Made for this Project

* Initial population is capped at 20 flies (with the number of male and female flies determined at random).
* Each mating produces between 50-500 larvae.
* Larvae hatch during the same generation as birth and become sexually mature when they reach the next generation.
* Each larvae egg has a 50% chance of becoming male and a 50% chance of becoming female upon birth.
* Flies can live a maximum of 3 generations (no more).
* Observed Phenotypes include all dead flies.

## Compilation Requirements
* A native Perl compiler must be installed on your system in order to run this project. Please view the instructions below for your operating system.

## About Running/Compiling on Different Operating Systems
* Linux: This project was developed within a Linux enviroment with the intention of it being ran and or compiled within a Linux enviroment. Therefore, there should be no problem running and or compiling assuming the Compilation Requirements (listed down below) are met. Perl is natively installed in most popular Linux distributions.

* Windows: There is no native support for the Perl on Windows so you will need to install a Perl package in order to run and or compile this project. One such option is Strawberry Perl, which can be found at http://www.strawberryperl.com/. Other options involve downloading Microsoft Visual Studio which has a native Perl compiler and RTE.

* OSX: This project can be ran natively on this operating system as a Perl compiler is included natively. Please open up a Terminal window and navigate to the folder that contains your project. From there, you can execute the "main.pl" file in the terminal to begin the runtime of this project.

## How to use
To use this experiment project, you must:
 1. Upon execution of the program, you will be required to enter the percentage of the initial population of female flies that carry the 'mutant white eyes' phenotype. Once that value (between 0 and 100%) is input, press the 'enter/return' key on your keyboard to continue.
 2. Next, you will be asked to enter the percentage of the initial population of maile flies that carry the 'mutant white eyes' phenotype. Once that value (between 0 and 100%) is input, press the 'enter/return' key on your keyboard to continue.
 3. Finally, you will be asked to enter the percentage of flies (male and female as one) that carry the 'mutant vestigial wings' phenotype'. Once that value (between 0 and 100%) is input, press the 'enter/return' key on your keyboard to continue.
 4. From here, the program will calculate the statistics across generations for the two given phenotypes.
 
 ## Phenotype Translation Table
 
| Phenotype Identifier | Description |
| --- | --- |
| VW | Long  Wings (Dominant) / Red Eyes (Dominant) |
| vW | Short Vestigial Wings (Recessive) / Red Eyes (Dominant) |
| vw | Short Vestigial Wings (Recessive) / White Eyes (Recessive) |

## Example Output

```
F2 population: 2016    [M/F: 998/1018]    [alive/dead: 1947/69]
F2 matings: 243
Observed phenotypes:
      Males: [VW: 1]    [vW: 935]    [vw: 62]    
    Females: [VW: 3]    [vW: 982]    [vw: 33]
```

## Glossary of Terms
| Term | Description |
| --- | --- |
| Phenotype | Physical characteristics of an organism that are dependent upon which genes are dominant and which are recessive. |
| Vestigial | An organ or part of a body that is degenrate or has become functionless over the course of evolution. |



## Acknowledgements

* Perl Code Author & Project Lead: Jacob Hochstetler
* ReadMe Author: Yale Empie
