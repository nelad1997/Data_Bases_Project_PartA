create table Content(
    Name varchar(50) primary key ,
    Language varchar(50),
    Upload_Date DATE
);



create table Movie(
    Name varchar(50) primary key,
    Genre varchar(50),
    foreign key (Name) references Content(Name) ON DELETE CASCADE
);



create table Song(
    Name varchar(50) primary key,
    Length_Sec int,
    foreign key (Name) references Content(Name) ON DELETE CASCADE
);




create table Content_Man(
    Name varchar(50) primary key,
);



create table Actor(
    Name varchar(50) primary key,
    foreign key (Name) references Content_Man(Name) ON DELETE CASCADE
);


create table Artist(
    Name varchar(50) primary key,
    Loved_Song varchar(50) not null,
    foreign key (Loved_Song) references Song(Name)
    foreign key (Name) references Content_Man(Name) ON DELETE CASCADE
);


create table Performed_By(
    Song_Name varchar(50) primary key,
    Artist_Name varchar(50),
    foreign key (Song_Name) references Song(Name) ON DELETE CASCADE,
    foreign key (Artist_Name) references Artist(Name) ON DELETE CASCADE
);


create table Jealous_Of(
    Actor1 varchar(50),
    Actor2 varchar(50),
    Cause varchar(50),
    primary key (Actor1, Actor2),
    foreign key (Actor1) references Actor (Name) ON DELETE CASCADE,
    foreign key (Actor2) references Actor(Name) ON DELETE CASCADE,
    check (Actor1 <> Actor2)
);


create table Played_In(
    Actor_Name varchar(50),
    Movie_Name varchar(50),
    Salary float,
    check ( Salary > 10000 ),
    primary key (Actor_Name,Movie_Name),
    foreign key (Actor_Name) references Actor (Name) ON DELETE CASCADE,
    foreign key (Movie_Name) references Movie(Name) ON DELETE CASCADE
);




create table User (
    ID int primary key,
    Name varchar(50),
    EMail varchar(50) unique,
    Country varchar (50)
);

create table Date(
    date DATE primary key
);


create table Advertisement(
    Ad_id int primary key ,
    Ad_Description varchar(50),
    Artist_showed varchar(50) not null,
    foreign key (Artist_showed) references Artist(Name) ON DELETE CASCADE
);

create table Consume(
    User_id int,
    Content_Name varchar(50),
    Date DATE,
    Grade int,
    Ad_In int,
    check ( Grade<=5 and Grade>=1 ),
    primary key (User_id,Content_Name,Date),
    foreign key (User_id) references User(ID) ON DELETE CASCADE,
    foreign key (Content_Name) references Content(Name) ON DELETE CASCADE,
    foreign key (Date) references Date(date) ON DELETE CASCADE,
    foreign key (Ad_In) references Advertisement(Ad_id)
);

create table Playlist(
    Name varchar(50),
    User_id int,
    primary key (Name,User_id),
    foreign key (User_id) references User(ID) ON DELETE CASCADE
);

create table In_Playlist(
    Name varchar(50),
    User_id int,
    Song_In varchar(50),
    primary key (Name,User_id,Song_In),
    foreign key (Name,User_id) references Playlist(Name,User_id) ON DELETE CASCADE,
    foreign key (Song_In) references Song(Name) ON DELETE CASCADE
);


create table Mark_Not_Fit(
    Name varchar(50),
    User_id_playlist int,
    User_id_Marking int,
    Song_In varchar(50),
    check (User_id_playlist <>  User_id_Marking ),
    primary key (Name,User_id_playlist,User_id_Marking,Song_In),
    foreign key (Name,User_id_playlist,Song_In) references In_Playlist(Name,User_id,Song_In) ON DELETE CASCADE,
    foreign key (User_id_Marking) references User(ID) ON DELETE CASCADE
);


