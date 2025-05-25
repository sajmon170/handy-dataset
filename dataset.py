import os
import torchvision
from torchvision.transforms import v2


def Signs2k(root):
    transforms = v2.Compose([
        v2.Resize(size=256),
        v2.RandomInvert(p=0.5),
        v2.RandomHorizontalFlip(p=0.5),
        v2.RandomVerticalFlip(p=0.5),
        v2.RandomRotation(degrees=360),
        v2.RandomPerspective(),
        v2.ElasticTransform(),
    ])

    train = torchvision.datasets.ImageFolder(os.path.join(root, "train"),
                                             transform=transforms)

    validate = torchvision.datasets.ImageFolder(os.path.join(root, "validate"),
                                                transform=transforms)

    test = torchvision.datasets.ImageFolder(os.path.join(root, "test"),
                                            transform=transforms)

    return (train, validate, test)

