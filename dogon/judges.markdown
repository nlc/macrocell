### To use:

    make

    ./prog < pattern.mc

### Try:

    ./prog < glider.mc

    ./prog < infinite_5x5.mc

    ./prog < mosquito5.mc
    # Press the minus key a few times until you see white specks,
    # then press space, and the ] key a few times.

    ./prog < message.mc

### Selected Judges Remarks:

[1991/davidguy](http://ioccc.org/years-spoiler.html#1991_davidguy),
[2011/blakely](http://ioccc.org/years-spoiler.html#2011_blakely),...

...This entry likely concludes the IOCCC category "Cellular automata simulators",
it would be very hard to beat it on its field.

FYI: The .mc extension stands for Golly macrocell format.

We truly have not much more to add, except two things:

* If a large sparse pattern is given, at the start of the program
  you are much more likely to see a blank board rather than the loaded configuration,
  and to see it, you may need to zoom out a few times.

* if you're using a virtual machine with less than 4 Gb of available
  model RAM, you'd want to reduce the value of the Z define in the Makefile
  to 0x10000000, otherwise the entry will promptly crash.

In the interest of saving lives, this entry was not fuzzed.
