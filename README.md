# openstellina
Stellina status display

This repo is a depository for my initial thoughts on a Stellina status display (and maybe control in future).

If you don't know what Stellina is, it is an automated refractor telescope and astrograph made by the French company Vaonis.

Normally this telescope is controlled from a mobile phone or tablet. But sometimes we want to know more about how things work,
what observations have been made, why they failed, a record of settings used such as RA and DEC.

This software uses http:// protocol, it should not damage your telescope which is controlled internally by a Raspberry-PI.
However, by using this software you take all responsibility for what happens to your expensive instrument.

Consult TerminalSavedOutput.txt for an example session from running this programme.

Why use OCAML? It is appropriate because OCAML is a French language, but also it is about 90% smaller than a typical equivalent in C++.
This initial demo is just 192 lines of code (plus standard libraries). Eventually we might want to migrate to AstroPi if there is sufficient interest.

Prerequisites. I use opam to install necessary libraries. A sufficient but not necessary list of libraries is in prerequisites.txt

How do you connect to Stellina? This programme runs on a workstation. If you have an AppleSilicon ML laptop or similar, Stellinapp can run natively because it is arm code. You will need to connect the Wifi to Stellina or an extender. I see no reason why it would not work on any machine with Wifi within range of the Stellina. In theory Legacy O/S like Windows should also work, but I do not have access to such machines.

Compiling the program. A Makefile is provided the prerequisites should be installed first. opam will help with this.

Why am I doing this? Because I can, because I like to learn new things, and there are an awful lot of cloudy nights round here.

