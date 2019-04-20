# ParseMySQLBackup
Splits MySQL Dump file into individual files by tablename with header.

You need Perl installed on your system for this to work.  For more information about Perl please start here: https://www.perl.org/

This will split up a mysqldump file into individual files named after the table including the header metadata.  

This can be useful if you want to only restore one or a subset tables or load them in a different order.
