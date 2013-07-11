lab 1 - SQLgettingStarted

SELECT emp.ename, dept.dname, emp.sal FROM emp, dept WHERE sal BETWEEN 1000 AND 2000;

SELECT DISTINCT emp.job FROM emp;

SELECT emp.ename, dept.dname, dept.deptno FROM emp, dept WHERE dept.deptno BETWEEN 10 AND 30;

SELECT emp.ename, dept.dname, emp.hiredate FROM emp, dept WHERE emp.hiredate BETWEEN '01-JAN-1982' AND '31-DEC-1982';

SELECT emp.ename FROM emp WHERE emp.ename LIKE '%TH%' OR ename LIKE '%LL%';

SELECT dept.dname, dept.deptno FROM emp, dept ORDER BY dept.dname;

SELECT emp.ename, emp.job, emp.sal, emp.comm FROM emp WHERE emp.mgr IS null;

SELECT E.ename, E.job, E.comm/sal FROM emp E WHERE E.job='SALESMAN' ORDER BY E.comm/sal;

SELECT E.ename, E.job, (comm+sal)*12 FROM emp E WHERE E.job='SALESMAN';

SELECT E.ename, E.job, E.sal, D.deptno FROM emp E, dept D WHERE E.job='SALESMAN' AND D.deptno=30 AND sal>=1500;

lab 2 - functions

SELECT COUNT (JOB) "MANAGERS" FROM EMP WHERE JOB = 'MANAGER';

SELECT AVG(sal+comm)*12 "SALESMANS' ANNUAL SALARY" FROM EMP WHERE JOB = 'SALESMAN';

SELECT MAX(sal) "Max sal", MIN(sal) "Min sal", MAX(sal)-MIN(sal) "Difference" FROM emp;

SELECT MAX(length(dname)) "No. of char" FROM dept;

SELECT COUNT(sal) "Salary", COUNT(comm) "Commission" FROM emp WHERE emp.deptno=30;

SELECT AVG(comm) "Commission", AVG(nvl(comm,0)) "Commission avg of all" FROM emp;

SELECT AVG(sal), AVG(comm), AVG(sal+nvl(comm,0)), AVG(sal+comm) FROM emp;

SELECT ename, ROUND((sal/22),2) "DAILY", ROUND(sal/(22*8),2) "HOURLY" FROM emp WHERE deptno=30;

SELECT ename, TRUNC((sal/22),2) "DAILY", TRUNC(sal/(22*8),2) "HOURLY" FROM emp WHERE deptno=30;

lab 3 - dates

SELECT ename, job, TO_CHAR(hiredate, 'MM/DD/YY') hiredate FROM emp WHERE deptno=20;

SELECT TO_CHAR(hiredate, 'DAY, MONTH, DD, YYYY') hiredate FROM emp WHERE deptno=20;

SELECT TO_CHAR(hiredate, 'DAY MONTH DDTH YYYY') hiredate FROM emp WHERE deptno=20;

SELECT ename "NAME" , TO_CHAR(hiredate, 'MONTH DDTH, YYYY, HH:MIPM') hiredate FROM emp WHERE deptno=20;

lab 4 - joins

SELECT emp.ename, emp.sal, dept.loc FROM emp, dept WHERE emp.deptno=dept.deptno AND dept.loc='DALLAS';

SELECT emp.ename, emp.sal, dept.loc, dept.deptno FROM emp, dept WHERE emp.deptno=dept.deptno ORDER BY dept.deptno;

SELECT emp.ename, dept.loc, dept.deptno FROM emp, dept WHERE emp.deptno=dept.deptno;

SELECT dept.deptno, dept.dname, dept.loc FROM dept LEFT JOIN emp ON (dept.deptno = emp.empno) AND empno IS NULL;

SELECT E.ename, E.sal, E.job, J.ename, J.sal, J.job FROM emp E, emp J WHERE E.sal>J.sal AND J.ename='JONES';

SELECT E.ename, E.sal, E.job, J.ename, J.sal, J.job FROM emp E, emp J WHERE E.mgr = J.empno AND E.sal>J.sal;

lab 5 - groupBy

SELECT deptno, ROUND(AVG(sal),2) AS "AVG SAL" FROM emp GROUP BY deptno;

SELECT emp.deptno, emp.job, COUNT(*) "Name", AVG(emp.sal)*12 "AVG Sal" FROM emp GROUP BY emp.deptno, emp.job;

SELECT dept.dname, emp.job, COUNT(emp.ename) "Name", AVG(emp.sal)*12 "AVG Sal" FROM emp, dept WHERE emp.deptno=dept.deptno GROUP BY dept.dname, emp.job;

SELECT AVG(sal)*12 "AVG SAL", job, COUNT(*) FROM emp GROUP BY job HAVING COUNT(*)>2; 

SELECT deptno FROM emp WHERE job='CLERK' GROUP BY deptno HAVING COUNT(*)>=2;

SELECT deptno, ROUND(AVG(sal),2), ROUND(AVG(sal)*0.25,2), AVG(comm) FROM emp GROUP BY deptno HAVING AVG(comm)>AVG(sal)*0.25; 

SELECT deptno, AVG(sal)*12 FROM emp WHERE job NOT IN('MANAGER','PRESEDENT') GROUP BY deptno; 

SELECT job, COUNT(*), AVG(sal)*12 FROM emp GROUP BY job HAVING COUNT(*)>2; 

lab 6 - subquires

SELECT ename, job FROM emp WHERE job=(SELECT job FROM emp WHERE ename='JONES');

SELECT ename, deptno FROM emp WHERE deptno=10 AND job IN (SELECT job FROM emp WHERE deptno=30);

SELECT ename, job, sal FROM emp WHERE (job, sal) = (SELECT job, sal FROM emp WHERE ename='FORD');

SELECT ename, job, deptno, sal FROM emp WHERE job IN (SELECT job FROM emp WHERE job='JONES') OR sal >= (SELECT sal FROM emp WHERE ename='FORD') ORDER BY job, sal;

SELECT ename, job, deptno FROM emp WHERE deptno=10 AND job IN (SELECT job FROM emp WHERE deptno IN (SELECT deptno FROM dept WHERE dname='SALES'));

SELECT ename, loc, job, sal FROM emp, dept WHERE loc='CHICAGO' AND emp.deptno=dept.deptno AND job IN (SELECT job FROM emp WHERE ename='ALLAN') ORDER BY ename;

SELECT ename, deptno, sal, job FROM emp X WHERE sal > (SELECT AVG(sal) FROM emp WHERE X.deptno=deptno) ORDER BY deptno;

lab 7 - data manipulation

CREATE TABLE loans(lno NUMBER(3), empno NUMBER(4), type CHAR(1), amnt NUMBER(8,2));

INSERT INTO loans(lno, empno, type, amnt) VALUES('23', '7499', 'm', '20000.00'); 
INSERT INTO loans(lno, empno, type, amnt) VALUES('42', '7499', 'c', '2000.00');
INSERT INTO loans(lno, empno, type, amnt) VALUES('65', '7844', 'm', '3564.20');

SELECT * FROM loans;

ALTER TABLE loans ADD outst NUMBER(8,2);

UPDATE loans SET amnt = amnt * 1.1 WHERE type='m';

DELETE FROM loans WHERE amnt<3000;

RENAME loans TO accounts;

ALTER TABLE accounts RENAME COLUMN lno TO loanno; SELECT * FROM accounts;
