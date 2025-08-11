import torch
import torch.nn as nn
import torch.nn.functional as F
from torchvision import transforms
from PIL import Image
import requests
from io import BytesIO
import sys
import os
from urllib.parse import urlparse

# ------------------ Vision Transformer (ViT) ------------------

class PatchEmbedding(nn.Module):
    def __init__(self, img_size=224, patch_size=16, in_channels=3, embed_dim=384):
        super().__init__()
        self.proj = nn.Conv2d(in_channels, embed_dim, kernel_size=patch_size, stride=patch_size)

    def forward(self, x):
        x = self.proj(x)  # [B, C, H/patch, W/patch]
        x = x.flatten(2).transpose(1, 2)  # [B, N, C]
        return x

class TransformerBlock(nn.Module):
    def __init__(self, embed_dim, num_heads, mlp_dim, dropout=0.1):
        super().__init__()
        self.norm1 = nn.LayerNorm(embed_dim)
        self.attn = nn.MultiheadAttention(embed_dim, num_heads, dropout=dropout, batch_first=True)
        self.norm2 = nn.LayerNorm(embed_dim)
        self.mlp = nn.Sequential(
            nn.Linear(embed_dim, mlp_dim),
            nn.GELU(),
            nn.Dropout(dropout),
            nn.Linear(mlp_dim, embed_dim),
            nn.Dropout(dropout)
        )

    def forward(self, x):
        x = x + self.attn(self.norm1(x), self.norm1(x), self.norm1(x))[0]
        x = x + self.mlp(self.norm2(x))
        return x

class ViT(nn.Module):
    def __init__(self, img_size=224, patch_size=16, in_channels=3,
                 num_classes=3, embed_dim=384, depth=4, num_heads=4, mlp_dim=1024, dropout=0.1):
        super().__init__()
        self.patch_embed = PatchEmbedding(img_size, patch_size, in_channels, embed_dim)
        self.cls_token = nn.Parameter(torch.zeros(1, 1, embed_dim))
        self.pos_embed = nn.Parameter(torch.zeros(1, (img_size // patch_size) ** 2 + 1, embed_dim))
        self.dropout = nn.Dropout(dropout)

        self.transformer = nn.Sequential(*[
            TransformerBlock(embed_dim, num_heads, mlp_dim, dropout) for _ in range(depth)
        ])

        self.norm = nn.LayerNorm(embed_dim)
        self.head = nn.Linear(embed_dim, num_classes)

    def forward(self, x):
        B = x.size(0)
        x = self.patch_embed(x)
        cls_tokens = self.cls_token.expand(B, -1, -1)
        x = torch.cat([cls_tokens, x], dim=1)
        x = x + self.pos_embed
        x = self.dropout(x)
        x = self.transformer(x)
        x = self.norm(x[:, 0])
        return self.head(x)

# ------------------ Utility Functions ------------------

def is_url(path_or_url):
    try:
        result = urlparse(path_or_url)
        return result.scheme in ("http", "https")
    except:
        return False

def load_image(path_or_url):
    if is_url(path_or_url):
        try:
            response = requests.get(path_or_url)
            response.raise_for_status()
            if "image" not in response.headers["Content-Type"]:
                raise ValueError("URL does not point to an image.")
            return Image.open(BytesIO(response.content)).convert('RGB')
        except Exception as e:
            print(f"❌ Failed to load image from URL: {e}")
            return None
    else:
        try:
            if not os.path.exists(path_or_url):
                raise FileNotFoundError(f"File not found: {path_or_url}")
            return Image.open(path_or_url).convert('RGB')
        except Exception as e:
            print(f"❌ Failed to load local image: {e}")
            return None

# ------------------ Prediction ------------------

def predict(image_path_or_url, model_path):
    class_names = ['advanced_glucoma', 'early_glucoma', 'normal']
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")

    # Load model
    model = ViT(num_classes=len(class_names)).to(device)
    model.load_state_dict(torch.load(model_path, map_location=device))
    model.eval()

    # Load image
    image = load_image(image_path_or_url)
    if image is None:
        return

    # Preprocess
    transform = transforms.Compose([
        transforms.Resize((224, 224)),
        transforms.ToTensor(),
        transforms.Normalize([0.5]*3, [0.5]*3)
    ])
    image = transform(image).unsqueeze(0).to(device)

    # Predict
    with torch.no_grad():
        output = model(image)
        probs = F.softmax(output, dim=1)
        pred_idx = torch.argmax(probs, dim=1).item()

    predicted_class = class_names[pred_idx]
    confidence = probs[0][pred_idx].item()

    print(f"🧠 Predicted Class: {predicted_class}")
    print(f"📊 Confidence: {confidence * 100:.2f}%")

# ------------------ CLI Entry ------------------

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("❌ Usage: python predict.py <image_path_or_url>")
        sys.exit(1)

    image_path_or_url = sys.argv[1]
    model_path = "vit_fundus1.pth"
    predict(image_path_or_url, model_path)
