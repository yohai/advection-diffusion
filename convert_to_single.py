import h5py
import numpy as np
import glob
import os

def convert_h5_to_single(fin,fout):
    f=h5py.File(fin,'r')
    with h5py.File(fout,'w') as fo:
        fo.create_dataset('/x',dtype='float16',data=f['/x'][:])
        fo.create_dataset('/y',dtype='float16',data=f['/y'][:])
        fo.create_dataset('/t',dtype='float16',data=f['/t'][:])
        for i in range(1,51):
            print "%d/%d"%(i,50)
            gi=f['/%03d' % i]
            go=fo.create_group('/%03d' % i)
            for d in gi:
                go.create_dataset(d,dtype='float16',data=gi[d][:].astype('float16'))
            for a in gi.attrs:
                go.attrs[a]=gi.attrs[a]
        fo.close()
