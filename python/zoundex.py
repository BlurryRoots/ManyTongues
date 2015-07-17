class Zoundex():
    lookup_table = {
        "a": 0, "e": 0, "i": 0, "o": 0, "u": 0, "y": 0, "h": 0, "w": 0,
        "b": 1, "f": 1, "p": 1, "v": 1,
        "c": 2, "g": 2, "j": 2, "k": 2, "q": 2, "s": 2, "x": 2, "z": 2,
        "d": 3, "t": 3,
        "l": 4,
        "m": 5, "n": 5,
        "r": 6
    }

    def __init__(self, phrase):
        self.encoded = phrase[0].upper()

        code = ''
        for c in phrase[1:].lower():
            value = self.lookup_table[c]
            code = code + str(value)

        reduced_code = ''
        l = len(code)
        i = 0
        for c in code:
            if (((i + 1) < l) and (code[i] != code[i + 1])
                or (i + 1) == l):
                reduced_code = reduced_code + c
            i = i + 1

        for c in reduced_code:
            if '0' != c:
                self.encoded = self.encoded + c

        el = len(self.encoded)
        if 4 < el:
            self.encoded = self.encoded[0:4]
        elif 4 > el:
            self.encoded = self.encoded + self._build_zeros(el - 4, '')


    def _build_zeros(self, n, accu):
        if 0 == n:
            return accu

        return self.build_zeros(n - 1, accu + '0')