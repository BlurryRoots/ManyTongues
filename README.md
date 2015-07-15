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
inspired by the paper found [here](http://www.creativyst.com/Doc/Articles/SoundEx1/SoundEx1.htm), to look like this:

    1.
        Retain the first letter of the word.

    2.
        Map the following:
            'A', E', 'I', 'O', 'U', 'H', 'W', 'Y' => 0

    3.
        Then map the following characters to:
            'B', 'F', 'P', 'V' = >1
            'C', 'G', 'J', 'K', 'Q', 'S', 'X', 'Z' => 2
            'D','T' => 3
            'L' => 4
            'M','N' => 5
            'R' => 6

    4.
        Remove all packs of numbers but one
        occurence *iff* adjacent and equal
        to each other.

    5.
        Remove all remainig zeros.

    6.
        If the number of characters is less
        than four, fill with zeros until number
        is four.
        If the number of characters is more
        then four, trim to four.
