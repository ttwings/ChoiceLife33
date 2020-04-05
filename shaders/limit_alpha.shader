shader_type canvas_item;

uniform float limit = 0.5;
void fragment(){
	COLOR = texture(TEXTURE,UV);
	if(COLOR.a < limit){
		COLOR.a = 0.0;
	}else{
		COLOR.a = 1.0
	}
//	COLOR = vec4(0.0,0.0,0.0,1.0);
}