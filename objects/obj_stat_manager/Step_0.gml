if (hp <= maxHp && hunger >= maxHunger/2)
	hp+=regenRate;
	
if (hp > maxHp)
	hp = maxHp;
	
if (hunger > maxHunger)
	hunger = maxHunger;
	
if (hunger > 0)
	hunger-=hungerRate;
	
if (hunger <= 0 && !decay_damage)
{
	alarm[0]=30;
	decay_damage=true;
	hunger = 0;
	obj_player.deathMessage = "Starved to death!";
}
if (!obj_player.canBreathe)
{
	air -= airLossRate;	
}
else if (air < maxAir)
{
	air += airLossRate;	
	if (air > maxAir)
		air = maxAir;
}
if (air <= 0 && !decay_damage)
{
	alarm[0]=30;
	decay_damage=true;
	air = 0;
	obj_player.deathMessage = "Drowned!";
}