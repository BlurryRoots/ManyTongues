import unittest
from zoundex import Zoundex


class ZoundexTest(unittest.TestCase):
    def setUp(self):
        pass

    def test_init(self):
        self.assertEqual('F263', Zoundex("figsworth").encoded)

        self.assertEqual('L126', Zoundex("lovecraft").encoded)
        self.assertEqual('L126', Zoundex("loafkraft").encoded)