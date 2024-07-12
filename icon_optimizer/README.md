# icon_optimizer
icon_optimizer is a script that optimizes SVGs in bulk so that 
it can be converted into a font file without any issues.
It converts the SVGs using picosvg and runs them in parallel using
the multiprocessing library.

## Installation
1. First clone picosvg from [here](https://github.com/googlefonts/picosvg)
2. Then run `pip install -e .` in the picosvg directory
3. Clone this repository
4. Run `npm start` in the icon_optimizer directory
5. The optimized SVGs will be in the `icons_optimized` directory under the `shadcn_flutter` directory