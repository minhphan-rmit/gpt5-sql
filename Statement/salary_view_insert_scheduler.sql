BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
    job_name        => 'PROCESS_SALARY_SUMMARY_JOB',
    job_type        => 'PLSQL_BLOCK',
    job_action      => 'BEGIN process_salary_summary; END;',
    start_date      => SYSTIMESTAMP,
    repeat_interval => 'FREQ=DAILY;BYHOUR=0;',
    enabled         => TRUE,
    comments        => 'Job to process salary summary daily'
  );
END;
/
