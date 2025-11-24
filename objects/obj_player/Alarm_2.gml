var yp = floor((y + 13));
if (vsp == 0 && yp % 8 != 0)
{
	var c = yp % 8;
	y-=c;
}
clipFix = false;