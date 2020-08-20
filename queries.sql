SELECT DISTINCT health, Name
FROM minion
order by health;

select m.Name , count(i.ItemName) 
from minion m , item i 
where m.Name = i.minion_Name 
group by m.name; 

select PlayerName 
from Player 
where PlayerName like '__c%';

select *
from server
where MaxPlayers > 3000;

Select s.TotalDmg, s.TotalDef
from itemset s
where s.CharName = 'Yasuo';

Select * 
From Item
Where Cost = (select min(cost) 
				from item);
                
Select m.name, i.itemName, i.capacity
From minion m , item i
Where m.name = i.minion_name and i.capacity between 5 and 15;                

Select Email , Servername
From Account; 

(Select defense as "def/dmgP", itemname
From defitems 
where defense = (select max(defense) from defitems)
)
union
(
Select damage, itemname
From dmgitems 
where damage = (select max(damage) from dmgitems)
);

select i.charname, u.itemname
from item u natural join itemset i
where u.itemname = 'blackoutfit';

Select *
from account
where account.PlayerID= 'H6';

Select sum(i.cost) , avg(i.cost), s.charname 
from item i natural join itemset s 
group by s.charname;

select count(PlayerID), servername
from account
group by servername; 

select *
from minitem;

select sum(capacity), name
from minitem 
group by name;

Update item
Set cost = 175000
Where itemname = 'Bow';

select itemname, Cost
from item 
where itemname = 'bow';