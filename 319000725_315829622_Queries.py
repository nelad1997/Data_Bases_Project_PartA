QUERY_ANSWERS = {
    "Q3":
        """
        select T.title,count(*) as numOfActors,round(Avg(cast(A.salary as float)),2) as AvgSalary
From atleastTwo T inner join ActorsInMovies A on T.title=A.title
group by  T.title
order by AvgSalary,T.title;
        """,
		
	"Q4":
        """
select *
from afinal
except
select *
from afinal f1
where f1.releaseDate < any(select f2.releaseDate
                           from afinal f2
                           where f1.aname=f2.aname);

        """
}
