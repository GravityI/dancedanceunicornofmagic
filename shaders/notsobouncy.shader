shader_type canvas_item;

uniform float speed;

void vertex(){
	VERTEX *= abs(pow(sin(TIME * 1.0), 2) + 0.5 - clamp(cos(TIME), 1, 2)) + 1.0;
//	VERTEX *= clamp(abs(sin(TIME * speed)) + 0.5, 1, 1.5);
}