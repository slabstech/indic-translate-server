# Indic Translate Server

## Overview

This project sets up an Indic translation server using Docker Compose, allowing translation between various languages including English, Kannada, Hindi, and others. It utilizes models from AI4Bharat to perform translations.

## Running with Docker Compose

1. **Start the server:**
   ```bash
   docker compose -f compose.yaml up -d
   ```

2. **Update source and target languages:**
   Modify the `compose.yaml` file to set the source (`SRC_LANG`) and target (`TGT_LANG`) languages as per your requirements. Example configurations:
   - **English to Indic:**
     ```yaml
     SRC_LANG: eng_Latn
     TGT_LANG: kan_Knda
     ```
   - **Indic to English:**
     ```yaml
     SRC_LANG: kan_Knda
     TGT_LANG: eng_Latn
     ```
   - **Indic to Indic:**
     ```yaml
     SRC_LANG: kan_Knda
     TGT_LANG: hin_Deva
     ```

## Evaluating Results

You can evaluate the translation results using `curl` commands. Here are some examples:

### English to Kannada
```bash
curl -X POST "http://localhost:8000/translate" \
 -H "Content-Type: application/json" \
 -d '{
       "sentences": ["Hello, how are you?", "Good morning!"],
       "src_lang": "eng_Latn",
       "tgt_lang": "kan_Knda"
     }'
```

### Kannada to English
```bash
curl -X POST "http://localhost:8000/translate" \
 -H "Content-Type: application/json" \
 -d '{
       "sentences": ["ನಮಸ್ಕಾರ, ಹೇಗಿದ್ದೀರಾ?", "ಶುಭೋದಯ!"],
       "src_lang": "kan_Knda",
       "tgt_lang": "eng_Latn"
     }'
```

### Hindi to English
```bash
curl -X POST "http://localhost:8000/translate" \
 -H "Content-Type: application/json" \
 -d '{
       "sentences": ["नमस्ते दुनिया", "आप कैसे हो?"],
       "src_lang": "hin_Deva",
       "tgt_lang": "eng_Latn"
     }'
```

## Setting Up the Development Environment

1. **Create a virtual environment:**
   ```bash
   python -m venv venv
   ```

2. **Activate the virtual environment:**
   ```bash
   source venv/bin/activate
   ```

3. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

## Downloading Translation Models

Models can be downloaded from AI4Bharat's HuggingFace repository:

### Indic to English
```bash
huggingface-cli download ai4bharat/indictrans2-indic-en-dist-200M
```

### English to Indic
```bash
huggingface-cli download ai4bharat/indictrans2-en-indic-1B
```

### Indic to Indic
```bash
huggingface-cli download ai4bharat/indictrans2-indic-indic-dist-320M
```

## Running with FastAPI Server

You can run the server using FastAPI:

```bash
uvicorn indic_translate_server/translate_api:app --host 0.0.0.0 --port 8000 --src_lang eng_Latn --tgt_lang kan_Knda
```

Alternatively, you can specify source and target languages directly:
```bash
python indic_translate_server/translate_api.py --src_lang eng_Latn --tgt_lang kan_Knda
```


## Build Docker image
```bash 
  docker build -t slabstech/indic_translate_server -f Dockerfile.dev .
```

## References

- [AI4Bharat IndicTrans2 Model](https://huggingface.co/ai4bharat/indictrans2-indic-en-dist-200M)
- [AI4Bharat IndicTrans2 GitHub Repository](https://github.com/AI4Bharat/IndicTrans2/tree/main/huggingface_interface)
- [IndicTransToolkit](https://github.com/VarunGumma/IndicTransToolkit.git)
- Extra - pip install git+https://github.com/VarunGumma/IndicTransToolkit.git

---

This README provides a comprehensive guide to setting up and running the Indic Translate Server. For more details, refer to the linked resources.