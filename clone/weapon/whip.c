// whip.c
// Last Modified by winder on May. 25 2001

#include <weapon.h>
inherit WHIP;

void create()
{
	set_name("皮鞭", ({"pi bian", "pibian", "bian", "whip"}));
	set_weight(1000);
	if (clonep())
		set_default_object(__FILE__);
	else
	{
		set("long", "一条长长的皮鞭．\n");
		set("unit", "条");
		set("value", 500);
	}
	init_whip(15);
	setup();
}
