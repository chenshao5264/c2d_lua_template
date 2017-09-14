#ifdef GL_ES
precision mediump float;
#endif
varying vec4 v_fragmentColor;
varying vec2 v_texCoord;

uniform sampler2D u_texture;
uniform float factor;
uniform float speed;
uniform float radian;

void main(void) {
	// 正在处理的这个像素点的颜色
	vec4 texColor = texture2D(CC_Texture0, v_texCoord);

	vec2 offset = vec2(0.0, 0.0);
	//  CC_Time.x是每一帧刷新自增0.01 .y是每帧自增0.1 框架默认是定时刷新
	float offsetX = (v_texCoord.x + v_texCoord.y * tan(radian)) / 2 - CC_Time[1] * speed;
	while (offsetX < 0.0) {
		offsetX = offsetX + 1.0;
	}
	offset.x = offsetX;
	offset.y = v_texCoord.y;
	vec4 texLight = texture2D(u_texture, offset);

	float alpha = texColor.a * texLight.a;
	texColor.r = texColor.r + texLight.r * alpha * factor;
	texColor.g = texColor.g + texLight.g * alpha * factor;
	texColor.b = texColor.b + texLight.b * alpha * factor;

	gl_FragColor = v_fragmentColor * texColor;
}