# openstellina
Stellina open-source telescope remote control

This repo is a depository for my initial thoughts on a Stellina remote control

If you don't know what Stellina is, it is an automated refractor telescope and astrograph made by the French company Vaonis.

Normally this telescope is controlled from a mobile phone or tablet. But sometimes we want to do more, such as interface to a planetarium.

This software uses http:// protocol, it should not damage your telescope which is controlled internally by a Raspberry-PI.
However, by using this software you take all responsibility for what happens to your expensive instrument.

Why use OCAML? It is appropriate because OCAML is a French language, but also it is about 90% smaller than a typical equivalent in C++.
This initial demo is just 192 lines of code (plus standard libraries). Eventually we might want to migrate to AstroPi if there is sufficient interest.

Prerequisites. I use opam to install necessary libraries. A sufficient but not necessary list of libraries is in prerequisites.txt

How do you connect to Stellina? This programme runs on any workstation that supports OCAML (Linux, OSX, Windows, Raspberry-PI).

Compiling the program. A Makefile is provided, the prerequisites should be installed first. opam will help with this.

Why am I doing this? Because I can, because I like to learn new things, and there are an awful lot of cloudy nights round here.

This programme is pre-alpha, designed to explore the available API, rather than to be used by end users.

make status -> connects to the Stellina and reads its status

make openarm -> connects to the Stellina and opens the arm (for maintenance).

make init -> connects to the Stellina and runs a full auto-init.

make observe -> connects to the successfully initialised Stellina and begins an observation

make stopobs -> stops the previously started observation

make park -> connects to the Stellina and parks the arm.

make sleep -> connects to the Stellina and prepares for power off.

More targets will be added later, I expect this script will be soon superseded by something more user-friendly.

After a target has been run, debug variables may be examined, or exoit the program with end-of-file (typically ctrl-D), or exit(0);;

environment variables:

LATITUDE (a floating point number) defaults to Greenwich (51.4777777777777814)
LONGITUDE (a floating point number) defaults to Greenwich (0.00138888888888888894)

The method of setting the environment will differ according to O/S. For example under OSX, if you live in Cambridge

export LATITUDE=52.24510437175544
export LONGITUDE=0.07952878556283442

Internally the Makefile will set these environment variables to control the script:

AUTO_INIT (an integer) > 0 to initiate automatic initialisation
PARK (an integer) > 0 to retract the arm
