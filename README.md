ManyTongues
===========

Implementing an algorithm based on soundex in different languages.

(from [wikipedia](https://en.wikipedia.org/wiki/Soundex))
    The correct value can be found as follows:

    1. 
        Retain the first letter of the name and
        drop all other occurrences of a, e, i, o, u, y, h, w.

    2.
        Replace consonants with digits as follows
        (after the first letter):
        b, f, p, v => 1
        c, g, j, k, q, s, x, z => 2
        d, t => 3
        l => 4
        m, n => 5
        r => 6
    3.
        If two or more letters with the same
        number are adjacent in the original
        name (before step 1), only retain the
        first letter; also two letters with
        the same number separated by 'h' or 'w'
        are coded as a single number, whereas
        such letters separated by a vowel are
        coded twice. This rule also applies
        to the first letter.

    4.
        Iterate the previous step until you
        have one letter and three numbers.
        If you have too few letters in your
        word that you can't assign three
        numbers, append with zeros until
        there are three numbers. If you
        have more than 3 letters, just
        retain the first 3 numbers.

Algorithm has been slightly altered
inspired by the paper found [here](http://www.creativyst.com/Doc/Articles/SoundEx1/SoundEx1.htm).

