# openstellina
Stellina open-source telescope remote control

This repo is a depository for my initial thoughts on a Stellina remote control

If you don't know what Stellina is, it is an automated refractor telescope and astrograph made by the French company Vaonis.

Normally this telescope is controlled from a mobile phone or tablet. But sometimes we want to do more, such as interface to a planetarium.

This software uses http:// protocol, it should not damage your telescope which is controlled internally by a Raspberry-PI.
However, by using this software you take all responsibility for what happens to your expensive instrument.

Why use OCAML? It is appropriate because OCAML is a French language, but also it is about 90% smaller than a typical equivalent in C++.
This initial demo is around 1200 lines of code (plus standard libraries, and list of 26000 observatory locations).
The Messier catalogue RA/DEC table came from a recent query of SIMBAD

Prerequisites. I use opam to install necessary libraries.

On Debian, the following instructions would suffice, On Mac OSX the homebrew equivalents would be used:

    sudo apt install libexpat1-dev libglib2.0-dev libgmp-dev libgtk2.0-dev libssl-dev zlib1g-dev opam
    ulimit -s 16384
    opam init
    opam pin add https://github.com/jrrk2/openstellina/archive/refs/tags/opam-publish-openstellina.0.0.1.zip

How do you connect to Stellina? This programme runs on any workstation that supports OPAM (Linux, OSX, Windows, Raspberry-PI).

The build procedure on Windows is a work-in-progress. It may be that the npm esy toolchain can be used, this is still being investigated.

Compiling the program: opam does this and adds the openstellina executable to the path, if all the stages above succeed.

Why am I doing this? Because I can, because I like to learn new things, and there are an awful lot of cloudy nights round here.

This programme is version 0.0.1, designed to pipeclean the development process, rather than to be used by non-software expert users.

environment variables:

    TIME_ZONE (a Continent/City string) defaults to Europe/London if /etc/localtime is not readable
    LATITUDE (a floating point number) defaults to Greenwich (51.4777777777777814)
    LONGITUDE (a floating point number) defaults to Greenwich (0.00138888888888888894)
    STELLINA_IP (a dotted decimal IP address) defaults to 10.0.0.1 corresponding to a real Stellina

The method of setting the environment will differ according to O/S. For example under OSX, if you live in Cambridge

    export LATITUDE=52.24510437175544
    export LONGITUDE=0.07952878556283442

If you don't specify a latitude and longitude the GUI will offer a lengthy list of observatory locations for your timezone, read from /etc/localtime.
If you don't happen to have a Stellina handy there are online simulators available (public ones seem to be broken at the moment)

You can use the node command to set up a java-script server to test this application. The method of doing that is outside the scope of this document.
