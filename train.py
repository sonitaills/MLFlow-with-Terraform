from ultralytics import YOLO

model = YOLO('yolov8m.pt')
results = model.train(data='./lagartas.yaml', epochs=10)