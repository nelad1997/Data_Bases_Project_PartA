VIEWS_DICT = {
    "Q3":
        [
		"""
create view onTimeActor
AS
SELECT  Distinct A.aname,M.title
from  ActorsInMovies A join Movies M
on A.title=M.title
where not exists((select distinct YEAR(M2.releaseDate)
                 from Movies M2)
                    except
                 (select distinct YEAR(M3.releaseDate)
                 from ActorsInMovies A2 inner join Movies M3
                 on A2.title = M3.title
                 where a2.aName=a.aName));
		""",
        """
        create view allMovieActors
AS
select  aname,avg(salary) as AvgSalary
from ActorsInMovies
group by aname;
        """,
            """create view profitablemovies
as
select distinct title
from ActorsInMovies
except
select distinct title
from (select A.title
from ActorsInMovies A
where A.salary<all(select AvgSalary
                   from allMovieActors aMA
                   where A.aname=aMA.aname) ) as t;

            ""","""create view atleastTwo
as
select distinct M.title
from profitablemovies p inner join onTimeActor T
on p.title=T.title  inner join Movies M on p.title=M.title
where M.language='English'
group by M.title
having count(distinct t.aname)>=2;
            """
        ]
    ,
    "Q4":
        [
		"""
CREATE VIEW OUTOFJEALOUS
AS
SELECT title
FROM (select distinct m.title
      from Movies m
      except
      select distinct a1.title
      from ActorsInMovies A1
      where exists (select *
              from Jealous J inner join ActorsInMovies A on j.aName2=a.aName
              where a.title=a1.title and a1.aName=j.aName1)) as mtA1t
EXCEPT
SELECT DISTINCT A1.TITLE
FROM  ActorsInMovies A1
where a1.aName not in (SELECT j.aName2
                       FROM  Jealous J);
		""",
        """
        CREATE VIEW firstConditions
AS
SELECT distinct A.aname
from ActorsInMovies a inner join Movies m on a.title=m.title
where exists(select *
             from ActorsInMovies a1 inner join Movies m1 on a1.title=m1.title
             where a1.title<>a.title and a.aName=a1.aName and m.language<>m1.language);

        """,
            """create view allConditions
as
select distinct a.aname
from ActorsInMovies a inner join OUTOFJEALOUS o on o.title=a.title inner join firstConditions fc
on a.aName=fc.aname
except
select distinct a.aname
from ActorsInMovies a
where a.salary>=all(select a2.salary
                    from ActorsInMovies a2
                    where a.title=a2.title);
            ""","""create view afinal
as
select a.aname,m.title, m.releaseDate
from allConditions al inner join ActorsInMovies A on al.aname=a.aname inner join movies m
on m.title=a.title;
            """
        ]
}



















