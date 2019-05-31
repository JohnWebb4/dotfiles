import imageio
import glob
from IPython import display

FPS = 10 # s
anim_file = 'gif.gif'

kargs = { 'duration': 1 / FPS }

with imageio.get_writer(anim_file, mode='I', **kargs) as writer:
  filenames = glob.glob('image*.png')
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
