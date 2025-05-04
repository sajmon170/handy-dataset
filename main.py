from torch.utils.data import DataLoader
from dataset import Signs2k
from utils import preview_dataset


def main():
    (train, _, _) = Signs2k(root='data')
    train_dataloader = DataLoader(train)
    preview_dataset(train)


if __name__ == "__main__":
    main()
