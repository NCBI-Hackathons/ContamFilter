#!/usr/bin/python

import csv
import argparse
from operator import itemgetter 

class CombineResults():
    def __init__(self):
        self.parser = argparse.ArgumentParser(description="Combine contamination screening outputs to a single GFF3 file")

    def init(self):
        self.parser.add_argument("-o","--output", required=True, type=argparse.FileType('w'))
        self.parser.add_argument("--common_contam", type=str)
        self.parser.add_argument("--mitos", type=str)
        self.parser.add_argument("--rrna", type=str)
        self.parser.add_argument("--vecscreen_adaptors", type=str)
        self.parser.add_argument("--vecscreen_univec", type=str)

    def run(self):
        args = self.parser.parse_args()

        self.writer = csv.writer(args.output, "excel-tab")
        self.writer.writerow(["##gff-version 3"])

        self.hits = []

        if not args.common_contam is None:
            self.common_contam(args.common_contam)

        if not args.mitos is None:
            pass

        if not args.rrna is None:
            pass

        if not args.vecscreen_adaptors is None:
            self.vector_screen(args.vecscreen_adaptors)

        if not args.vecscreen_univec is None:
            self.vector_screen(args.vecscreen_univec)

        sorted_hits = sorted(self.hits, key=itemgetter(0,3,4)) 
        for hit in sorted_hits:
            self.writer.writerow(hit)

    def common_contam(self, filename):
        with open(filename, 'r') as csvfile:
            hits_reader = csv.reader(csvfile, delimiter='\t')
            for row in hits_reader:
                output = [row[0], row[1], "region", row[6], row[7], row[2], ".", "."]
                self.hits.append(output)

    def vector_screen(self, filename):
        with open(filename, 'r') as csvfile:
            hits_reader = csv.reader(csvfile, delimiter='\t')
            for row in hits_reader:
                if row[0].startswith('VecScreen_Strong'):
                    output = [row[1], ".", "region", row[2], row[3], ".", ".", "."]
                    self.hits.append(output)


if __name__ == "__main__":
    cr = CombineResults()
    cr.init()
    cr.run()
