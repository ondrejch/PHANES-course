from pathlib import Path
import sys
import unittest

sys.path.insert(0, str(Path(__file__).resolve().parent))
from spec import validate
class SpecificationTests(unittest.TestCase):
    def test_inventory(self):
        self.assertEqual(validate(),{'fuel_pins_per_assembly':264,'fuel_pins_in_core':2376})
    def test_rejects_overlap_and_invalid_budget(self):
        for args in ({'radii':(.4,.5,.7)},{'radii':(.4,.3,.5)},
                     {'reflector':0},{'inactive':40},{'particles':0}):
            with self.subTest(args=args),self.assertRaises(ValueError): validate(**args)
if __name__=='__main__': unittest.main()
