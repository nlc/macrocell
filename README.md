# macrocell

A basic parser for the pattern-definition syntax used by the _Golly_ Conway's Game of Life program.

Macrocell files define a quad tree of nested sub-grids, allowing for very efficient data representation in the case of large patterns with many repeating sub-patterns.

For example, the 115-byte file with contents

```
[M2] (golly 3.0)
#R B3/S23
.**.**$*.*.*.*$**...**$$**...**$*.*.*.*$.**.**$
4 0 1 1 1
5 2 0 2 2
6 3 3 0 3
7 4 4 4 4
```

expands into the 128x128-cell pattern:

<img src="https://github.com/nlc/macrocell/raw/master/_pattern.png?raw=true" width="512">

which, represented naively as binary cells, would require 16 kilobits, or 2 kilobytes, to store.
