from ultralytics import YOLO


model = YOLO('./runs/detect/train/weights/best.pt')
model.predict("./datasets/lagargas/images/val", save=True)