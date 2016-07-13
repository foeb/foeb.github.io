---
layout: post
title: Setting up CSound and Pure Data on Ubuntu
date: 2016-7-12 12:00:00 -0700
categories: csound puredata jack
---
This is a tutorial on setting up a brand new Ubuntu 64bit system to use CSound
and Pure Data together, including real time audio and Jack. I'm writing this
because I found this information spread all across the net and much of it I
needed to figure out myself. CSound and Pure Data are two of the most powerful
audio synthesis and composition environments out there and fortunately people
have made it possible to use CSound inside Pure Data. This allows you to write
use CSound to write modular components which you can use in Pure Data to wire 
them together, make GUIs for them, and make them interactive in general. If
you run into any problems, create a new issue at the github repository for
[this website](https://github.com/foeb/foeb.github.io) and I'll see if I can
help.

I hope you find it useful. :)

## Installing Jack and configuring real-time support
To install jack (and the lovely qjackctl), type

        sudo apt install qjackctl

in the terminal. Answer "yes" when asked if you would like to enable real-time
support. We still need to do some extra configuration, but I like to think
this helps keep evil spirits away.

To actually set up real-time scheduling, follow steps 1-3
[here](jackaudio.org/faq/linux_rt_config.html), entering the lines given in
step 1 directly into `etc/security/limits.conf`.

## Compiling CSound and Pure Data
(Note: these are instructions for CSound version 6.06.0,
the current version at the time this article was published.)

To begin, you have to first compile CSound from scratch.
While you can use the packages from Ubuntu to start out, I found that
you run into problems easily so it's better to do it right the first time 
to save yourself a lot of trouble down the road.

First, install the build dependencies:

        sudo apt install git cmake libjack-dev pkgconf portaudio19-dev \
                g++ libportmidi-dev libsndfile-dev curl flex bison libboost-all-dev

(If I somehow forget to include a dependency, `apt search` is your friend.)

Next, clone the CSound repository:

        cd ~; mkdir src; cd src
        git clone https://github.com/csound/csound

`csound6~` (the Pure Data object) has Pure Data as a dependency, so we
have to install Pure Data first.

        sudo apt install puredata
        cd csound
        mkdir cs6build; cd cs6build
        cmake ..
        make -j6; sudo make install; sudo ldconfig

If everything went smoothly, you should have working copies of CSound and
Pure Data on your computer! To test CSound, copy this into a new file `hello.csd`:

```
{% include code/hello.csd %}
```

To run it, type `csound hello.csd` in the same directory. You should hear a nice
sine wave when you open `hello.wav` in your favorite media player. If not,
something probably went wrong. Even more fun, try it on `trapped.csd` in the `examples` folder of csound. 
For Pure Data, you can use their `Test Audio and Midi` option in the Media menu.

To test out `csound6~`, copy this into a file named `control.csd`:

```
{% include code/control.csd %}
```

Then, make and save this patch in the same directory:

![control.pd]({{ site.url }}/img/control.pd.svg)

When you turn on DSP in Pure Data, you should hear another nice sine wave.

## Jack settings for CSound alone
If you want to use CSound with Jack for realtime midi and audio, you'll need
to put a lot of settings in your `<CsOptions>`. These settings worked well
for me:

        -odac -+rtaudio=jack -+rtmidi=portmidi -M0 -B256 -+jack_client=csoundmidi

The main setting to note is `-B` which sets the block size. Too low of a value,
CSound complains and you may get dropouts, but higher values leads to greater
latency.

## Vim plugin for editing CSound files
If you want to use vim for CSound, you may want to try out [this](https://github.com/luisjure/csound) plugin.
Or, if you wish, you can use my fork of the same plugin which includes my
recommended settings in templates.

## Resources
Finally, here is a collection of links you may find useful.

- [Chapter 1 of the CSound Book](http://www.csounds.com/chapter1/index.html), a very good introduction
- [The canonical CSound manual](http://www.csounds.com/manual/html/index.html)
- [CSound FLOSS manual](http://write.flossmanuals.net/csound/preface/)
- [Information on using csound6~](http://floss.booktype.pro/csound/a-csound-in-pd/)
- [The Cook collection](http://www.csounds.com/cook/index.html) of CSound instruments
- [The Amsterdam collection](http://www.codemist.co.uk/AmsterdamCatalog/), another collection of CSound instruments
- [Pure Data FLOSS manual](http://write.flossmanuals.net/pure-data/introduction2/)
- [ecoSYSTEM](http://www.monologx.com/ecosystem/), a modular synth in Pure Data
- [RTC-lib](http://www.essl.at/works/rtc.html), real time composition library for Pure Data
- [How to write an external for Pure Data](http://pdstatic.iem.at/externals-HOWTO/), for those of you who like to program in C
- [Sound on Sound articles on synthesis](https://web.archive.org/web/20150705193532/http://www.soundonsound.com/search?url=%2Fsearch&Keyword=%22synth+secrets%22&Words=All&Summary=Yes), not CSound or Pure Data specific
