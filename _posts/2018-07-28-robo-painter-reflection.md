---
layout: post
title: robo-painter
date: 2018-07-28 12:00:00 -0700
categories: c lua programming
---
[![control.pd]({{ site.url }}/img/1149_5_preview.png)]({{ site.url }}/img/1149_5.png)

*(click on images for full-size)*

[`robo-painter`](https://github.com/foeb/robo-painter) started off as an attempt to train a computer to recognize beauty. The problem is fascinating. If a program like that became widespread, it could greatly enrich our lives and would be a step towards "true" artificial intelligence.

[![control.pd]({{ site.url }}/img/20141_7_preview.png)]({{ site.url }}/img/20141_7.png)

For the project, I used C to write compiled libraries to be used in a Lua interpreter. This choice was largely because of my tastes in programming at the time. They're both wonderful, complementary languages and I had a lot of fun using them in previous projects. Together, they allow rapid prototyping (in Lua) and a way to isolate and rewrite performance-intensive code (in C) to keep the program running smoothly.

[![control.pd]({{ site.url }}/img/20275_7_preview.png)]({{ site.url }}/img/20275_7.png)

Since my goal in starting `robo-painter` was to use [genetic programming](https://en.wikipedia.org/wiki/Genetic_programming) to select attractive images, the language for the image generator had to be robust and failure-proof, even when randomly mutated or spliced. I decided on using an expression tree represented as a one-dimensional array, which worked tremendously. With that structure, every string of expressions is a valid expression tree in this language. In practice, this was an array of bytes representing expressions which took arguments in Polish notation, similar to a somewhat more low-level S-expression in Lisp. *The Art of Computer Programming* provided the algorithm to evaluate the expression tree. The algorithm for Perlin noise was based off of the C++ implementation on Wikipedia with a large set of precomputed gradient vectors.

[![control.pd]({{ site.url }}/img/20297_7_preview.png)]({{ site.url }}/img/20297_7.png)

The biggest problem I encountered was building, by far! Finding out how to compile statically linked C libraries correctly for Lua took a couple days. The process is not well documented, at all. I've spent way too much time over the past few years trying to make other people's code build, and its the main reason I would be wary to use C/C++ for any future projects.

[![control.pd]({{ site.url }}/img/20393_7_preview.png)]({{ site.url }}/img/20393_7.png)

Ultimately, I ran out of interest and only the image generator half is complete. I would like to try something similar to `robo-painter` again in the future, but I would probably redesign the language to be human-readable and easier to extend. 