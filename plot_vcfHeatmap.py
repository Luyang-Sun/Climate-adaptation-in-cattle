#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Haplotype heatmap visualization from VCF files
Created on Sun Nov  3 17:28:50 2019
"""

import os
import click
CONTEXT_SETTINGS = dict(help_option_names=['-h', '--help'])
import numpy as np
import pandas as pd
from cyvcf2 import VCF
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import seaborn as sns

def load_rename_mapping(rename_file):
    """Load sample ID renaming mapping from file"""
    old_to_new = {}
    with open(rename_file) as f:
        for line in f:
            parts = line.strip().split()
            old_to_new[parts[0]] = parts[1]
    return old_to_new

@click.command(context_settings=CONTEXT_SETTINGS)
@click.option('--vcffile', help='Input genotype VCF file', required=True)
@click.option('--outlist', help='Outgroup samples list (for determining derived allele)', default=None)
@click.option('--querylist', help='Samples to visualize (one sample per line)', required=True)
@click.option('--region', help='Genomic region to plot (e.g. 12:1000-2000)', default=None)
@click.option('--regionfile', help='File with multiple regions to plot (3 columns: chr\\tstart\\tend)', default=None)
@click.option('--maf', help='Minimum allele frequency threshold (default=0.2)', type=float, default=0.2)
@click.option('--rename', help='File to rename sample IDs (two columns: oldID newID)', default=None)
@click.option('--outfile', help='Output image file')
@click.option('--figsize', nargs=2, type=float, help='Figure dimensions (default: 20 5)', default=(20, 5))
@click.option('--ticklabelsize', help='Tick label size (default: 1)', default=1, type=int)
@click.option('--dpi', help='Image resolution (default: 500)', default=500)
@click.option('--outprefix', help='Output file prefix (used with regionfile)', default=None)
@click.option('--outsuffix', help='Output file suffix/format (used with regionfile)', default=None)
def main(vcffile, outlist, querylist, region, regionfile, maf, rename, outfile, figsize, ticklabelsize, dpi, outprefix, outsuffix):
    """
    Generate haplotype heatmap from VCF genotype data.
    Uses outgroup samples to determine ancestral allele if provided.
    Without outgroup, uses REF/ALT from VCF directly.
    """
    # Load query samples
    querysamples = [x.strip() for x in open(querylist)]
    
    # Initialize VCF readers
    if outlist:
        outsamples = [x.strip() for x in open(outlist)]
        vcf_outgroup = VCF(vcffile, gts012=True, samples=outsamples)
    
    vcf_query = VCF(vcffile, gts012=True, samples=querysamples)
    
    # Check for missing samples
    if len(querysamples) > len(vcf_query.samples):
        missing = set(querysamples) - set(vcf_query.samples)
        print(f'Missing query samples: {missing}')
        for ind in missing:
            querysamples.remove(ind)
    
    # Process regions
    regions = []
    if regionfile:
        with open(regionfile) as f:
            for line in f:
                parts = line.strip().split()
                regions.append(f'{parts[0]}:{parts[1]}-{parts[2]}')
    else:
        regions.append(region)
    
    # Process each region
    for i, region in enumerate(regions):
        genotypes = []
        positions = []
        
        if outlist:
            # Determine ancestral allele from outgroup
            for variant_outgroup, variant_query in zip(vcf_outgroup(region),
                                                     vcf_query(region)):
                if (len(variant_query.ALT) == 1 and 
                    len(variant_query.REF) == 1 and 
                    len(variant_query.ALT[0]) == 1):  # Keep only biallelic SNPs
                    
                    # Count genotype categories (0=HOM_REF, 1=HET, 2=HOM_ALT, 3=UNKNOWN)
                    counts = np.bincount(variant_outgroup.gt_types)
                    
                    try:
                        major_gt = np.argmax([counts[0], counts[2]])  # Compare REF and ALT homozygotes
                    except IndexError:  # No HOM_ALT
                        major_gt = 0
                    
                    # Process genotypes
                    gt_array = variant_query.gt_types
                    if major_gt == 0:
                        # Swap REF and ALT if major allele is ALT
                        gt_array[gt_array==2] = -9
                        gt_array[gt_array==0] = 2
                        gt_array[gt_array==-9] = 0
                    
                    genotypes.append(gt_array.tolist())
                    positions.append(variant_query.POS)
        else:
            # Use VCF REF/ALT directly
            for variant_query in vcf_query(region):
                if (len(variant_query.ALT) == 1 and 
                    len(variant_query.REF) == 1 and 
                    len(variant_query.ALT[0]) == 1):  # Keep only biallelic SNPs
                    
                    genotypes.append(variant_query.gt_types.tolist())
                    positions.append(variant_query.POS)

        # Create DataFrame
        df = pd.DataFrame(genotypes, columns=vcf_query.samples, index=positions)
        df = df[querysamples]  # Reorder columns
        df = df.replace(3, np.nan)  # Convert missing to NaN
        print(f'{os.path.basename(vcffile)} {region}:\n{df.shape}')

        # Rename samples if mapping provided
        if rename:
            rename_map = load_rename_mapping(rename)
            df.columns = [rename_map[x] for x in df.columns]

        # Filter by MAF
        freqs = df.sum(axis=1).values / (df.count(axis=1).values * 2)
        df = df.loc[((1-maf)>=freqs)&(freqs>=maf), :]
        print(f'After MAF ({maf}) filtering:\n{df.shape}')

        # Generate heatmap
        fig, ax = plt.subplots(1, 1, figsize=figsize)
        ax.set_facecolor("grey")
        sns.heatmap(df.T, yticklabels=1, cmap='YlGnBu', ax=ax)
        ax.set_title(region)
        
        # Adjust tick labels
        for label in (ax.get_xticklabels() + ax.get_yticklabels()):
            label.set_fontsize(ticklabelsize)
        
        # Save output
        if not outprefix:
            plt.savefig(outfile, dpi=dpi)
        else:
            plt.savefig(f'{outprefix}_{i+1}.{outsuffix}')
        plt.close()

if __name__ == '__main__':
    main()