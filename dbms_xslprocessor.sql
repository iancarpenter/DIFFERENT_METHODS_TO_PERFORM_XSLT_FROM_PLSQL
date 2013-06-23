DECLARE

l_xml                     VARCHAR2(4000);
l_xsl                     VARCHAR2(4000);
l_parser                  dbms_xmlparser.parser;
l_xml_dom_document        dbms_xmldom.domdocument;
l_xslt_dom_document       dbms_xmldom.domdocument;
l_xslprocessor_ss_type    dbms_xslprocessor.stylesheet;
l_dom_doc_fragment        dbms_xmldom.domdocumentfragment;
l_dom_node                dbms_xmldom.domnode;
l_xsl_processor           dbms_xslprocessor.processor;
l_buffer                  VARCHAR2(2000);

BEGIN

 l_xml :='<?xml version="1.0"?><ROWSET><ROW><EMPNO>7566</EMPNO><ENAME>JONES</ENAME><JOB>MANAGER</JOB><MGR>7839</MGR><HIREDATE>02-APR-1981</HIREDATE><SAL>2975</SAL><DEPTNO>20</DEPTNO><VALID>N</VALID></ROW><ROW><EMPNO>7788</EMPNO><ENAME>SCOTT</ENAME><JOB>ANALYST</JOB><MGR>7566</MGR><HIREDATE>19-APR-1987</HIREDATE><SAL>3000</SAL><DEPTNO>20</DEPTNO><VALID>N</VALID></ROW><ROW><EMPNO>7876</EMPNO><ENAME>ADAMS</ENAME><JOB>CLERK</JOB><MGR>7788</MGR><HIREDATE>23-MAY-1987</HIREDATE><SAL>1100</SAL><DEPTNO>20</DEPTNO><VALID>N</VALID></ROW><ROW><EMPNO>7902</EMPNO><ENAME>FORD</ENAME><JOB>ANALYST</JOB><MGR>7566</MGR><HIREDATE>03-DEC-1981</HIREDATE><SAL>3000</SAL><DEPTNO>20</DEPTNO><VALID>N</VALID></ROW></ROWSET>';

 l_xsl := '<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"><xsl:template match="/"> <html><body> <xsl:for-each select="ROWSET/ROW"> <h2><xsl:value-of select="ENAME"/></h2> </xsl:for-each> </body></html></xsl:template></xsl:stylesheet>';

 l_parser := dbms_xmlparser.newparser;

 dbms_xmlparser.parsebuffer(l_parser, l_xml);

 l_xml_dom_document := dbms_xmlparser.getdocument(l_parser);

 dbms_xmlparser.parsebuffer(l_parser, l_xsl);

 l_xslt_dom_document := dbms_xmlparser.getDocument(l_parser);

 l_xslprocessor_ss_type := dbms_xslprocessor.newStyleSheet(l_xslt_dom_document, '');

 l_xsl_processor := dbms_xslprocessor.newprocessor;

 l_dom_doc_fragment := dbms_xslprocessor.processXSL(l_xsl_processor, l_xslprocessor_ss_type, l_xml_dom_document);

 l_dom_node := dbms_xmldom.makeNode(l_dom_doc_fragment);

 dbms_xmldom.writeToBuffer(l_dom_node, l_buffer);

 dbms_output.put_line(l_buffer);

 dbms_xmldom.freedocument(l_xml_dom_document);
 dbms_xmldom.freedocument(l_xslt_dom_document);
 dbms_xmldom.freedocfrag(l_dom_doc_fragment);
 dbms_xmlparser.freeparser(l_parser);
 dbms_xslprocessor.freeprocessor(l_xsl_processor);

END;
/