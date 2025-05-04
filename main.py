from torch.utils.data import DataLoader
from dataset import Signs2k
from utils import show_dataset

def main():
    train = Signs2k(root='data')
    train_dataloader = DataLoader(train)
    show_dataset(train)


if __name__ == "__main__":
    main()
