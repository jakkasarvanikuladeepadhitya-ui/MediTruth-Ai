MEDTRUTH AI v2 - How to Run (research prototype, synthetic data only)

FILES (one folder): app.py, index.html, medtruth_database.sql, requirements.txt, .env

1. Database: SQL Developer > connect > open medtruth_database.sql > F5
   (if you used the old script, drop the old tables first - see comment at top)
2. Install:  pip install -r requirements.txt
3. Create a file named .env (same folder as app.py), no quotes, no spaces around "=":
      ORACLE_USER=SYSTEM
      ORACLE_PASSWORD=your_oracle_password
      ORACLE_DSN=localhost:1521/XEPDB1
      OPENAI_API_KEY=sk-your-first-NEW-key
      OPENAI_API_KEY_2=sk-your-second-NEW-key
      OPENAI_MODEL=gpt-4o-mini
   NEVER share or upload this file. Revoke any key you have shared.
4. Run:  python app.py   then open http://127.0.0.1:5000

WHAT IT READS
  PDF (text or scanned), PNG/JPG/WEBP photos of reports, DOCX, TXT/CSV, pasted text.
  Scanned PDFs and images need OPENAI_API_KEY (GPT vision) or Tesseract + pytesseract.
  Without a key, text PDFs/TXT/DOCX still work with the rule-based parser.

Q&A: ask about any test. Diagnosis/treatment questions are refused. Each answer shows a mode label.
Errors: "no OPENAI_API_KEY set" -> .env missing/misnamed; 401 -> bad key; 429 -> no credit.

TWO KEYS: if key 1 fails (429 no credit, 401 revoked) the app automatically uses key 2.
STORAGE: if Oracle is not reachable, reports are saved in medtruth_local.db (SQLite) so History still works.
429 error = that OpenAI account has no credit: add billing at platform.openai.com/settings/organization/billing
