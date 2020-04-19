shader_type canvas_item;

void vertex(){
//	VERTEX *= abs(pow(sin(TIME * 2.0), 2) - clamp(sin(TIME), 1, 1.5)) + 0.5;
	VERTEX *= clamp(abs(sin(TIME*4.0)) + 0.5, 1, 1.5);
}