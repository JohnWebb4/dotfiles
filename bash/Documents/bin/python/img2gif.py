import sys
import imageio
import glob
from IPython import display

FPS = int(sys.argv[1]) if len(sys.argv) > 1 else 10 # s
anim_file = 'gif.gif'

kargs = { 'duration': 1 / FPS }

with imageio.get_writer(anim_file, mode='I', **kargs) as writer:
  filenames = glob.glob('image*.*')

  if (len(filenames) == 0):
      raise ValueError('No image files found beginning with image')

  filenames = sorted(filenames)
  last = -1
  for i,filename in enumerate(filenames):
    image = imageio.imread(filename)
    writer.append_data(image)
  image = imageio.imread(filename)
  writer.append_data(image)

import IPython
if IPython.version_info > (6,2,0,''):
  display.Image(filename=anim_file)
