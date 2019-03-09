import glob
import os
import shutil

# data source https://drive.google.com/drive/u/1/folders/1An715FJYLguzoUz3qf_AK2H0vnpCNlKM
"""
This dataset is cut from a video that each subjective are asked to behave an exact emotion.
Each folder contains a sequence of images from when they are neutral till they express the emotion they were asked to.
Therefore in each folder, some several last images are exactly express the emotion

# How to convert
After download change the name of images folder to images/ , labels folder to labels/
Run this script
"""
# folder name to store data
save_dir = 'data'
# how many last images in sequence to copy
number_last_images = 3

labels = {
    7 :"surprise",
    1: "angry",
    5: "happy" ,
    3:"disgust",
    4:'fear',
    6:'sad',
#     2:'contempt' # don't need
    0:'neutral',
    
}

# create storage folder
for value in labels.values():
    os.makedirs(os.path.join(save_dir,value),exist_ok=True)
    
    
for idx,f in enumerate(glob.glob('./labels/*/*/*.txt')):
    label = int(open(f).readline().split('.')[0])
    if label not in labels.keys():
        continue
    dest_dir = os.path.join(save_dir,labels[label])
    
    images_folder = '/'.join(f.replace('labels','images').split('/')[:-1])
    image_paths = sorted(glob.glob(images_folder+'/*.png'))
    if len(image_paths) > 5:
        [shutil.copy(image_path,dest_dir) for image_path in image_paths[-no_last_images:]]
    else:
        shutil.copy(image_paths[-1],dest_dir)
        
    # copy the first images of each folder as neutral    
    shutil.copy(image_paths[0],os.path.join(save_dir,labels[0]))

        
for emotion_dir in os.listdir(save_dir):
    print(f"{emotion_dir} has \t{len(os.listdir(os.path.join(save_dir,emotion_dir)))}\timages" ) 
print(f"{len(glob.glob('*/*/*.png'))} images in total")    
