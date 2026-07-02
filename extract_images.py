import fitz
import os
import sys

def extract_images(pdf_path, output_dir, prefix):
    if not os.path.exists(pdf_path):
        print(f"File not found: {pdf_path}")
        return

    os.makedirs(output_dir, exist_ok=True)
    doc = fitz.open(pdf_path)
    count = 1
    
    for page_num in range(len(doc)):
        page = doc.load_page(page_num)
        images = page.get_images(full=True)
        for img in images:
            xref = img[0]
            base_image = doc.extract_image(xref)
            image_bytes = base_image["image"]
            ext = base_image["ext"]
            img_filename = f"{prefix}_{count}.{ext}"
            img_filepath = os.path.join(output_dir, img_filename)
            with open(img_filepath, "wb") as f:
                f.write(image_bytes)
            print(f"Saved: {img_filepath}")
            count += 1

if __name__ == "__main__":
    out_dir = r"c:\Users\xemon\Downloads\fd\intern\sebian-lab.github.io\static\images"
    
    pdf1 = r"c:\Users\xemon\Downloads\fd\intern\sebian-lab.github.io\Verslag_Virtualisatie_Lab_sebi2026 (1).pdf"
    extract_images(pdf1, out_dir, "vmware_lab")
    
    pdf2 = r"c:\Users\xemon\Downloads\fd\intern\sebian-lab.github.io\Sebian_van_de_Spiegle (1).pdf"
    extract_images(pdf2, out_dir, "azure_lab")
