DELIMITER //
DROP PROCEDURE IF EXISTS ieees006_main.sp_table_prefix//

CREATE PROCEDURE ieees006_main.sp_table_prefix(
  IN lv_prefix VARCHAR( 200 ),
  OUT lv_temp LONG VARCHAR
)
BEGIN

SELECT 
  concat('alter table ',db,'.',tb,' rename ',db,'.',lv_prefix,tb,';')
INTO lv_temp
FROM 
  ( SELECT table_schema db, table_name tb
  FROM information_schema.tables
  WHERE table_schema NOT IN 
    ( 
    'information_schema',
    'mysql' 
    )
  ) A, 
  ( SELECT lv_prefix
  ) B
WHERE db =  'ieees006_main'
AND tb NOT IN (
'users',  'users_roles',  'sequences'
);
SELECT lv_temp;
END
//