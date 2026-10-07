-- MedTruth AI v2: Oracle XE 12c+. Run in SQL Developer (F5).
-- If you ran the OLD script, first run:  DROP TABLE test_result; DROP TABLE medical_report; DROP TABLE knowledge_base;
CREATE TABLE medical_report (
  report_id   NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  filename    VARCHAR2(200) NOT NULL,
  report_text CLOB NOT NULL,
  uploaded_at TIMESTAMP DEFAULT SYSTIMESTAMP
);
-- No fixed test list any more: any test name is allowed; ranges may be one-sided (e.g. <3.30)
CREATE TABLE test_result (
  result_id   NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  report_id   NUMBER NOT NULL REFERENCES medical_report(report_id) ON DELETE CASCADE,
  test_name   VARCHAR2(200) NOT NULL,
  value_num   NUMBER NOT NULL,
  unit        VARCHAR2(50),
  ref_low     NUMBER,
  ref_high    NUMBER,
  status      VARCHAR2(10) NOT NULL,
  evidence    VARCHAR2(500) NOT NULL,
  evidence_ok NUMBER(1) DEFAULT 0 NOT NULL,
  CONSTRAINT ck_status CHECK (status IN ('LOW','NORMAL','HIGH','UNKNOWN'))
);
-- Queries
SELECT * FROM test_result;
SELECT r.filename, t.test_name, t.value_num, t.status FROM medical_report r JOIN test_result t ON t.report_id = r.report_id;
SELECT status, COUNT(*) AS n FROM test_result GROUP BY status;
-- UPDATE test_result SET status = 'LOW' WHERE result_id = 1;
-- DELETE FROM medical_report WHERE report_id = 1;   -- cascades
