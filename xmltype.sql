DECLARE

l_xml XMLTYPE;
l_xsl XMLTYPE;
l_transformed XMLTYPE;

BEGIN

 l_xml := XMLTYPE.CREATEXML('<?xml version="1.0"?><ROWSET><ROW><EMPNO>7566</EMPNO><ENAME>JONES</ENAME><JOB>MANAGER</JOB><MGR>7839</MGR><HIREDATE>02-APR-1981</HIREDATE><SAL>2975</SAL><DEPTNO>20</DEPTNO><VALID>N</VALID></ROW><ROW><EMPNO>7788</EMPNO><ENAME>SCOTT</ENAME><JOB>ANALYST</JOB><MGR>7566</MGR><HIREDATE>19-APR-1987</HIREDATE><SAL>3000</SAL><DEPTNO>20</DEPTNO><VALID>N</VALID></ROW><ROW><EMPNO>7876</EMPNO><ENAME>ADAMS</ENAME><JOB>CLERK</JOB><MGR>7788</MGR><HIREDATE>23-MAY-1987</HIREDATE><SAL>1100</SAL><DEPTNO>20</DEPTNO><VALID>N</VALID></ROW><ROW><EMPNO>7902</EMPNO><ENAME>FORD</ENAME><JOB>ANALYST</JOB><MGR>7566</MGR><HIREDATE>03-DEC-1981</HIREDATE><SAL>3000</SAL><DEPTNO>20</DEPTNO><VALID>N</VALID></ROW></ROWSET>');

 l_xsl := XMLTYPE.CREATEXML('<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"><xsl:template match="/"> <html><body> <xsl:for-each select="ROWSET/ROW"> <h2><xsl:value-of select="ENAME"/></h2> </xsl:for-each> </body></html></xsl:template></xsl:stylesheet>');

 l_transformed := l_xml.transform(xsl => l_xsl);

 DBMS_OUTPUT.PUT_LINE(l_transformed.getstringval());

END;
/