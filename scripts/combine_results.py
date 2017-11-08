#!/usr/bin/python

import csv
import argparse

class CombineResults():
    def __init__(self):
        self.parser = argparse.ArgumentParser(description="Combine contamination screening outputs to a single GFF3 file")

    def init(self):
        self.parser.add_argument("--common_contam", type=str)
        self.parser.add_argument("--mitos", type=str)
        self.parser.add_argument("--rrna", type=str)
        self.parser.add_argument("--vecscreen_adaptors", type=str)
        self.parser.add_argument("--vecscreen_univec", type=str)

    def run(self):
        args = self.parser.parse_args()

        if not args.common_contam is None:
            pass

        if not args.mitos is None:
            pass

        if not args.rrna is None:
            pass

        if not args.vecscreen_adaptors is None:
            pass

        if not args.vecscreen_univec is None:
            pass

        print "hello world!"

    def common_contam(self, filename):
        with open(filename, 'r') as csvfile:
            hits_reader = csv.reader(csvfile, delimiter='\t')
            for row in hits_reader:
                print "{0} {1} {2}".format(row[0], row[6], row[7])

if __name__ == "__main__":
    cr = CombineResults()
    cr.init()
    cr.run()
