import torch
#import torchvision
import matplotlib
import matplotlib.pyplot as plt
from torch.utils.data import DataLoader

import torchvision
from torchvision.transforms import v2
from torchvision.io import decode_image
from torchvision import tv_tensors

def show_dataset(dataset):
    labels_map = {
        0: "B",
        1: "M",
        2: "N",
        3: "Nieznane",
        4: "O",
        5: "S",
        6: "T",
    }
    figure = plt.figure(figsize=(8, 8))
    cols, rows = 4, 4
    for i in range(1, cols * rows + 1):
        sample_idx = torch.randint(len(dataset), size=(1,)).item()
        img, label = dataset[sample_idx]
        figure.add_subplot(rows, cols, i)
        plt.title(labels_map[label])
        plt.axis("off")
        print(type(img))
        plt.imshow(img, cmap="gray")
    plt.show()
    

def main():
    train = torchvision.datasets.ImageFolder(root='data/train')
    train_dataloader = DataLoader(train)
    show_dataset(train)


if __name__ == "__main__":
    main()
