# Single Subject Research (SSR) Plots Using Zsh + gnuplot
This is a test of how one can create line graphs using Zsh and the gnuplot cli application.<br>The interest in this project came out of curiosity to alternatives to using Microsoft Excel, Python, or the SSD for R package.
## Requirements
1. Terminal shell using zsh.
2. Install [gnuplot](http://www.gnuplot.info/)
```zsh
brew install gnuplot
```
3. Create a .csv file with the following headers (e.g. [a-b-data.csv](https://github.com/AlvaroGomezMartinez/ssr-test/blob/main/a-b-data.csv), [a-b-a-b-data.csv](https://github.com/AlvaroGomezMartinez/ssr-test/blob/main/a-b-a-b-data.csv)):
```csv
Session | Phase | Score
```
4. Create a .sh file to run the gnuplot script (e.g. [plot_ab_graph.sh](https://github.com/AlvaroGomezMartinez/ssr-test/blob/main/plot_ab_graph.sh), [plot_abab_graph.sh](https://github.com/AlvaroGomezMartinez/ssr-test/blob/main/plot_abab_graph.sh)).
5. Give the .sh file permission to execute:
```zsh
chmod +x plot_ab_graph.sh
```
## Running the script
From terminal run the script by providing its title and the data file. For example:
```zsh
./plot_ab_graph.sh a-b-data.csv
```
or
```zsh
./plot_abab_graph.sh a-b-a-b-data.csv
```
## Notes
While this looks promising, it is not user friendly. It works well for A-B plots, but once you start introducing additional phases the complexity increases. It is do-able, however, you need to invest a good amount of time to get a shell working.
### System
Mac mini 2023<br>
Chip: Apple M2<br>
macOS: Sequoia 15.5<br>
Terminal: Version 2.14 (455.1)<br>
zsh: version 5.9 (arm64-apple-darwin24.0)<br>
Visual Studio Code: Version 1.102.0
